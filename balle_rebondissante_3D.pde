Ground ground;
Cube cube;
Axes axes;
Orb orb;

Point p1, p2, p3, p4, p5, p6, p7, p8;

Surface surface, s2, s3, s4, s5, s6;
Surface[] terrain;

float verticaleTranslate = 0;
float horizontaleTranslate = 0;
float depthTranslate = 0;
float rotationX = 0;
float rotationY = 0;
float constX = 0;
float constY = 0;

PVector gravity;

boolean keyW, keyA, keyS, keyD, keySpace, keyCtrl, keyY, keyX;

void setup() {
  size(1080, 720, P3D);
  axes = new Axes(200, 200, 200);
  ground = new Ground(500, 500, 20, 10);
  
  gravity = new PVector(0, -1, 0);
  orb = new Orb(290, 300, 0,  10, gravity, 0.91);
  
}

void draw() {
  background(200);
  lights();
  pushMatrix();

  translate(horizontaleTranslate, verticaleTranslate + (height/2) , depthTranslate);
  translate(width / 3, 0);
  
  rotateX(rotationX);
  rotateY(rotationY);
  
  rotateX(90);
  
  axes.display();
  ground.display2();
  orb.display();
  
  orb.move();
  orb.checkGroundCollision(ground);
  
  updateMovement();
  popMatrix();
}


void keyPressed() {
  switch (key) {
    case ' ':
      keySpace = true;
      break;
    case CODED: // Left Control
      if (keyCode == CONTROL) {
        keyCtrl = true;
      }
      break;
    case 'z':
      keyW = true;
      break;
    case 'q':
      keyA = true;
      break;
    case 'd':
      keyD = true;
      break;
    case 'w':
      keyS = true;
      break;
    case 'y':
      keyY = true;
      break;
    case 'x':
      keyX = true;
      break;
    default:
      break;
  }
}

void keyReleased() {
  switch (key) {
    case ' ':
      keySpace = false;
      break;
    case CODED:
      if (keyCode == CONTROL) {
        keyCtrl = false;
      }
      break;
    case 'z':
      keyW = false;
      break;
    case 'q':
      keyA = false;
      break;
    case 'd':
      keyD = false;
      break;
    case 'w':
      keyS = false;
      break;
    case 'x':
      keyX = false;
      break;
    case 'y':
      keyY = false;
      break;
    default:
      break;
  }
}

void updateMovement() {
  if (keySpace) {
    verticaleTranslate += 10;
  }
  if (keyCtrl) {
    verticaleTranslate -= 10;
  }
  if (keyW) {
    depthTranslate += 10;
  }
  if (keyA) {
    horizontaleTranslate += 10;
  }
  if (keyD) {
    horizontaleTranslate -= 10;
  }
  if (keyS) {
    depthTranslate -= 10;
  }
  if (keyY) {
    constY += 0.01;
    rotationY = constY * PI;
  }
    if (keyX) {
    constX += 0.01;
    rotationX = constX * PI;
  }
}
