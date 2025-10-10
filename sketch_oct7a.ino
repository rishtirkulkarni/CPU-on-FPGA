#include <U8g2lib.h>
#include <Arduino.h>

// --- LCD Constructor (KS0108, 270° rotated for vertical/flipped display) ---
// R3 = 270° clockwise (vertical orientation, flipped 180 deg)
U8G2_KS0108_128X64_F u8g2(U8G2_R3,     
  /* d0=*/2,  /* d1=*/3,  /* d2=*/4,  /* d3=*/5,
  /* d4=*/6,  /* d5=*/7,  /* d6=*/8,  /* d7=*/9,
  /* enable=*/11, /* dc=*/10,
  /* cs0=*/12, /* cs1=*/13,
  /* reset=*/U8X8_PIN_NONE);

// --- Buttons (INPUT_PULLUP) ---
const int buttonRight = A0; 
const int buttonLeft  = A1;

// --- Main Game Grid setup ---
#define CELL 6          
#define COLS 10         
#define ROWS 19         
byte grid[ROWS][COLS] = {0}; 

// --- Mini-Game Grid setup (For Start Screen Animation) ---
#define MINI_ROWS 9
#define MINI_COLS 10
#define MINI_Y_OFFSET 37 // Y start position for the mini-game area
#define MINI_X_OFFSET 2  // Matches main game border offset (left side)
byte miniGrid[MINI_ROWS][MINI_COLS] = {0};

// --- Tetromino Definitions (4x4 max for rotation) ---
const byte TETROMINOS[7][4][4] = {
    {{0, 0, 0, 0}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // I
    {{1, 0, 0, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // J
    {{0, 0, 1, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // L
    {{0, 1, 1, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // O
    {{0, 1, 1, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // S
    {{0, 1, 0, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}, // T
    {{1, 1, 0, 0}, {0, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}  // Z
};

// --- Game State Variables ---
int blockX, blockY;
byte currentShape[4][4];
long score = 0; 
bool gameOver = false;
bool gameRunning = false;
unsigned long lastFallTime = 0;
const int constantFallInterval = 150; 
int fallInterval = constantFallInterval; 
unsigned long lastMoveTime = 0;
const int moveRepeatDelay = 100;
unsigned long gameOverTime = 0;
const unsigned long gameOverDuration = 10000; // 10 seconds
long frameCounter = 0; 

// --- Mini-Game State Variables ---
byte miniCurrentShape[4][4];
int miniBlockX, miniBlockY;
unsigned long miniLastFallTime = 0;
const int miniFallInterval = 400; // Slower fall for demonstration
const int miniMoveInterval = 300; // Auto-move interval
unsigned long miniLastMoveTime = 0;
int miniMoveDirection = 0; // 0=none, 1=left, 2=right

// --- Forward Declarations ---
void newBlock();
bool checkCollision(int nx, int ny, byte shape[4][4]);
void placeBlock();
void resetGame();

// --- Mini-Game Logic ---

bool miniCheckCollision(int nx, int ny, byte shape[4][4]) {
  for (int i = 0; i < 4; i++) { 
    for (int j = 0; j < 4; j++) { 
      if (shape[i][j]) {
        int gx = nx + j;
        int gy = ny + i;

        if (gx < 0 || gx >= MINI_COLS) return true;
        if (gy >= MINI_ROWS) return true; 
        if (gy < 0) continue; 

        if (miniGrid[gy][gx]) return true;
      }
    }
  }
  return false;
}

void miniNewBlock() {
  int shapeIndex = random(0, 7); 
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      miniCurrentShape[i][j] = TETROMINOS[shapeIndex][i][j];
    }
  }
  miniBlockX = MINI_COLS / 2 - 2; 
  miniBlockY = -1; 
  
  // Decide next move pattern
  miniMoveDirection = random(0, 3); // 0=none, 1=left, 2=right
  miniLastMoveTime = millis();
}

void miniPlaceBlock() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (miniCurrentShape[i][j]) {
        int gx = miniBlockX + j;
        int gy = miniBlockY + i;
        if (gy >= 0 && gy < MINI_ROWS && gx >= 0 && gx < MINI_COLS) {
          miniGrid[gy][gx] = 1;
        }
      }
    }
  }
  
  // Line clearing is removed as requested to match the main game logic.
  
  // *** Check for Game Over in Mini-Game and Restart Animation ***
  int shapeIndex = random(0, 7);
  byte nextShape[4][4];
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      nextShape[i][j] = TETROMINOS[shapeIndex][i][j];
    }
  }
  
  // If the next block immediately collides upon spawning, clear the whole mini-grid
  if (miniCheckCollision(MINI_COLS / 2 - 2, -1, nextShape)) {
      // Game over in mini-game: Clear grid and start over
      for (int r = 0; r < MINI_ROWS; r++) {
          for (int c = 0; c < MINI_COLS; c++) {
              miniGrid[r][c] = 0;
          }
      }
  }
  
  miniNewBlock();
}

void updateMiniGame() {
    unsigned long now = millis();
    
    // Auto Movement (Left/Right)
    if (now - miniLastMoveTime > miniMoveInterval) {
        int newX = miniBlockX;
        if (miniMoveDirection == 1) { // Left
            newX--;
        } else if (miniMoveDirection == 2) { // Right
            newX++;
        }
        
        if (newX != miniBlockX && !miniCheckCollision(newX, miniBlockY, miniCurrentShape)) {
            miniBlockX = newX;
        }
        miniLastMoveTime = now;
    }

    // Auto Fall (Gravity)
    if (now - miniLastFallTime > miniFallInterval) {
        if (!miniCheckCollision(miniBlockX, miniBlockY + 1, miniCurrentShape)) {
            miniBlockY++;
        } else {
            miniPlaceBlock();
        }
        miniLastFallTime = now;
    }
}

void drawMiniGame() {
  // Define the frame for the mini-game area (Y=37 to Y=95)
  // 2-pixel thick border for mini-game area
  u8g2.drawFrame(0, MINI_Y_OFFSET - 2, 64, MINI_ROWS * CELL + 4); // Outer frame
  u8g2.drawFrame(1, MINI_Y_OFFSET - 1, 62, MINI_ROWS * CELL + 2); // Inner frame
  
  // Draw static blocks
  for (int r = 0; r < MINI_ROWS; r++) {
    for (int c = 0; c < MINI_COLS; c++) {
      if (miniGrid[r][c]) {
        // Blocks are offset by MINI_X_OFFSET and MINI_Y_OFFSET
        u8g2.drawBox((c * CELL) + MINI_X_OFFSET, (r * CELL) + MINI_Y_OFFSET, CELL, CELL);
      }
    }
  }

  // Draw falling block
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (miniCurrentShape[i][j]) {
        // Blocks are offset by MINI_X_OFFSET and MINI_Y_OFFSET
        u8g2.drawBox((miniBlockX + j) * CELL + MINI_X_OFFSET, (miniBlockY + i) * CELL + MINI_Y_OFFSET, CELL, CELL);
      }
    }
  }
}

// --- Main Game Logic (UNCHANGED) ---

// FIX: Added 'int' type to the 'ny' parameter in the function definition
bool checkCollision(int nx, int ny, byte shape[4][4]) {
  for (int i = 0; i < 4; i++) { 
    for (int j = 0; j < 4; j++) { 
      if (shape[i][j]) {
        int gx = nx + j;
        int gy = ny + i;

        if (gx < 0 || gx >= COLS) return true;
        if (gy >= ROWS) return true; 
        if (gy < 0) continue; 

        if (grid[gy][gx]) return true;
      }
    }
  }
  return false;
}

void newBlock() {
  int shapeIndex = random(0, 7); 
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      currentShape[i][j] = TETROMINOS[shapeIndex][i][j];
    }
  }
  blockX = COLS / 2 - 2; 
  blockY = -1; 

  if (checkCollision(blockX, blockY, currentShape)) {
    gameOver = true;
    gameOverTime = millis();
  }
}

void placeBlock() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (currentShape[i][j]) {
        int gx = blockX + j;
        int gy = blockY + i;
        if (gy >= 0 && gy < ROWS && gx >= 0 && gx < COLS) {
          grid[gy][gx] = 1;
        }
      }
    }
  }

  score += 10; 
  newBlock();
}

void drawGame() {
  // 1. Draw the 2-pixel thick border for the game area.
  u8g2.drawFrame(0, 0, 64, 118); 
  u8g2.drawFrame(1, 1, 62, 116); 

  // 2. Draw the static grid blocks
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      if (grid[r][c]) {
        u8g2.drawBox((c * CELL) + 2, (r * CELL) + 2, CELL, CELL);
      }
    }
  }

  // 3. Draw the current falling block
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (currentShape[i][j]) {
        u8g2.drawBox((blockX + j) * CELL + 2, (blockY + i) * CELL + 2, CELL, CELL);
      }
    }
  }

  // 4. Draw the score
  u8g2.setFont(u8g2_font_5x7_tr);
  u8g2.setCursor(0, 125); 
  u8g2.print("SCORE: ");
  u8g2.print(score);
}

// --- Draw Cool Smiley Animation (Pixel Art from Image, now scaled up and accurate) ---
void drawSmileyAnimation() {
  // Now 30x30 pixels visually, achieved by using a 15x15 array and scale of 2
  int emoji_map_size = 15; // The base pixel map size
  int visual_scale = 2;    // Each pixel is drawn as a 2x2 box for 30x30 total size
  int visual_size = emoji_map_size * visual_scale; // 30x30 pixels visually

  // Calculate centered position for the 30x30 graphic:
  int center_x = u8g2.getDisplayWidth() / 2; // 32
  
  int start_x = center_x - (visual_size / 2); // 32 - 15 = 17 (This centers the 30px image)
  // Adjusted start_y to properly center the 30x30 image between the score value (y=55) and the restart message (y=115)
  int start_y = 70; // (55 + 115) / 2 = 85. 85 - (30/2) = 70
  
  // ** ORIGINAL 15x15 Mapped Array ** (Used with visual_scale = 2)
  const uint8_t smiley_map[15][15] = {
    //   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4
    //   . . . . . 1 1 1 1 1 . . . . .
    {0,0,0,0,0,1,1,1,1,1,0,0,0,0,0}, // 0
    //   . . . 1 1 . . . . . 1 1 . . .
    {0,0,0,1,1,0,0,0,0,0,1,1,0,0,0}, // 1
    //   . . 1 . . . . . . . . 1 . . .
    {0,0,1,0,0,0,0,0,0,0,0,0,1,0,0}, // 2
    //   . 1 . . . . . . . . . . 1 . .
    {0,1,0,0,0,0,0,0,0,0,0,0,0,1,0}, // 3
    //   . 1 . . . . . . . . . . 1 . .
    {0,1,0,0,0,0,0,0,0,0,0,0,0,1,0}, // 4
    //   1 1 1 1 1 1 1 1 1 1 1 1 1 1 .  <-- Glasses line (Black pixels from image)
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, // 5 
    //   1 . 1 . . 1 1 . 1 . . 1 1 . 1 
    {1,0,1,0,0,1,1,0,1,0,0,1,1,0,1}, // 6 
    //   1 . 1 . 1 1 1 . 1 . 1 1 1 . 1 
    {1,0,1,0,1,1,1,0,1,0,1,1,1,0,1}, // 7 
    //   1 . . 1 1 1 . . . 1 1 1 . . 1 
    {1,0,0,1,1,1,0,0,0,1,1,1,0,0,1}, // 8 
    //   1 . . . . . . . . . . . . . 1 
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1}, // 9
    //   . 1 . . . . . . . . 1 . . 1 .
    {0,1,0,0,0,0,0,0,0,0,1,0,0,1,0}, // 10
    //   . 1 . . . . 1 1 1 1 . . . 1 .  <-- Mouth detail (Black lines from image)
    {0,1,0,0,0,0,1,1,1,1,0,0,0,1,0}, // 11
    //   . . 1 . . . . . . . . . 1 . .
    {0,0,1,0,0,0,0,0,0,0,0,0,1,0,0}, // 12
    //   . . . 1 1 . . . . . 1 1 . . .
    {0,0,0,1,1,0,0,0,0,0,1,1,0,0,0}, // 13
    //   . . . . . 1 1 1 1 1 . . . . .
    {0,0,0,0,0,1,1,1,1,1,0,0,0,0,0}  // 14
  };
  
  // Draw the lit pixels using a 2x2 box for scaling
  for (int y = 0; y < emoji_map_size; y++) {
    for (int x = 0; x < emoji_map_size; x++) {
      if (smiley_map[y][x] == 1) {
        u8g2.drawBox(start_x + x * visual_scale, start_y + y * visual_scale, visual_scale, visual_scale);
      }
    }
  }
}

// --- Draw Game Over screen ---
void drawGameOver() {
  u8g2_uint_t w;
  u8g2_uint_t center_x;
  unsigned long now = millis();
  
  // 1. Title: GAME OVER
  u8g2.setFont(u8g2_font_7x13_tr);
  const char* titleStr = "GAME OVER";
  w = u8g2.getStrWidth(titleStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 15);
  u8g2.print(titleStr);
  
  // 2. Final Score Text
  u8g2.setFont(u8g2_font_5x7_tr);
  const char* scoreLabelStr = "FINAL SCORE:";
  w = u8g2.getStrWidth(scoreLabelStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 35);
  u8g2.print(scoreLabelStr);

  // 3. Score Value
  char scoreValueStr[16];
  sprintf(scoreValueStr, "%ld", score);
  u8g2.setFont(u8g2_font_9x15_t_cyrillic);
  w = u8g2.getStrWidth(scoreValueStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 55);
  u8g2.print(scoreValueStr);
  
  // 4. Score Symbol (NOW COOL SMILEY, scaled up and centered)
  drawSmileyAnimation(); 

  // 5. Restarting Text
  u8g2.setFont(u8g2_font_5x7_tr);
  const char* msg1 = "RESTARTING IN:";
  w = u8g2.getStrWidth(msg1);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 115);
  u8g2.print(msg1);

  // 6. Countdown Timer (Visible, BELOW RESTARTING IN)
  long timeRemaining = (gameOverDuration - (now - gameOverTime)) / 1000;
  if (timeRemaining < 0) timeRemaining = 0; 

  char countdownStr[5];
  sprintf(countdownStr, "T-%ld", timeRemaining);
  u8g2.setFont(u8g2_font_9x15_t_cyrillic);
  w = u8g2.getStrWidth(countdownStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 127); // Placed at the very bottom
  u8g2.print(countdownStr);
}


// --- Draw Start Screen ---
void drawStartScreen() {
  u8g2_uint_t w;
  u8g2_uint_t center_x;
  
  // 1. Title: ARDUINO TETRIS
  u8g2.setFont(u8g2_font_7x13_tr);
  
  const char* title1 = "ARDUINO";
  w = u8g2.getStrWidth(title1);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 15); 
  u8g2.print(title1);
  
  const char* title2 = "TETRIS";
  w = u8g2.getStrWidth(title2);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 30); 
  u8g2.print(title2);

  // 2. Self-Playing Mini-Game Animation
  drawMiniGame();

  // 3. Call to Action (UNIFORM SPACING)
  u8g2.setFont(u8g2_font_6x12_tr);
  
  // "PRESS" - Y=105
  const char* pressStr = "PRESS";
  w = u8g2.getStrWidth(pressStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 105); 
  u8g2.print(pressStr);

  // "ANY BUTTON" - Y=117 (12 pixel vertical step)
  const char* anyButtonStr = "ANY BUTTON";
  w = u8g2.getStrWidth(anyButtonStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 117); 
  u8g2.print(anyButtonStr);

  // "TO PLAY!" - Y=128 (11 pixel vertical step, bottom line)
  const char* playStr = "TO PLAY!";
  w = u8g2.getStrWidth(playStr);
  center_x = (u8g2.getDisplayWidth() - w) / 2;
  u8g2.setCursor(center_x, 128); 
  u8g2.print(playStr);
}

// --- Reset Game State ---
void resetGame() {
  score = 0;
  gameOver = false;
  fallInterval = constantFallInterval; 
  gameOverTime = 0;
  gameRunning = false;
  lastFallTime = millis();
  frameCounter = 0; 
  
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      grid[r][c] = 0;
    }
  }
  
  // Reset Mini-Game State
  for (int r = 0; r < MINI_ROWS; r++) {
    for (int c = 0; c < MINI_COLS; c++) {
      miniGrid[r][c] = 0;
    }
  }
  miniNewBlock();
  miniLastFallTime = millis();
}

// --- Setup ---
void setup() {
  pinMode(buttonLeft, INPUT_PULLUP);
  pinMode(buttonRight, INPUT_PULLUP);
  u8g2.begin();
  randomSeed(analogRead(A5)); 
  resetGame();
}

// --- Main Loop ---
void loop() {
  frameCounter++; // Increment frame counter for all animations

  if (!gameRunning) {
    // 1. Update Mini-Game State
    updateMiniGame();

    // 2. Draw Start Screen
    u8g2.firstPage();
    do { drawStartScreen(); } while (u8g2.nextPage());

    if (digitalRead(buttonLeft) == LOW || digitalRead(buttonRight) == LOW) {
      gameRunning = true;
      newBlock();
    }
    delay(20); // Faster draw rate for smooth animation
    return;
  }

  if (gameOver) {
    unsigned long now = millis();
    u8g2.firstPage();
    do { drawGameOver(); } while (u8g2.nextPage());

    if (now - gameOverTime >= gameOverDuration) {
      resetGame();
    }
    delay(50);
    return;
  }
  
  // --- Read Buttons (Main Game) ---
  bool leftPressed  = (digitalRead(buttonLeft) == LOW);
  bool rightPressed = (digitalRead(buttonRight) == LOW);
  unsigned long now = millis();

  if (now - lastMoveTime > moveRepeatDelay) {
    
    // Check Left movement first
    if (leftPressed && !checkCollision(blockX - 1, blockY, currentShape)) {
      blockX--;
      lastMoveTime = now;
    } 
    // Check Right movement
    else if (rightPressed && !checkCollision(blockX + 1, blockY, currentShape)) {
      blockX++;
      lastMoveTime = now;
    }
  }

  // --- Gravity (Automatic Fall) ---
  if (now - lastFallTime > fallInterval) {
    if (!checkCollision(blockX, blockY + 1, currentShape)) {
      blockY++; // Fall down one step
    } else {
      placeBlock(); // Land the block and get a new one
    }
    lastFallTime = now;
  }

  // --- Draw frame ---
  u8g2.firstPage();
  do {
    drawGame();
  } while (u8g2.nextPage());

  delay(20);
}
