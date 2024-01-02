/**
 * Non-orthogonal Collision with Multiple Ground Segments 
 * by Ira Greenberg. 
 * 
 * Based on Keith Peter's Solution in
 * Foundation Actionscript Animation: Making Things Move!
 */

Orb orb;

PVector gravity = new PVector(0,0.5);
// The ground is an array of "Ground" objects
int segments = 40;
Ground[][] ground = new Ground[segments][segments];
float constanteX = 0;
float constanteY = 0;
float moveX = 0;
float moveZ = 0;
float moveY = 0;
boolean keyQ, keyZ, keyD, keyS, keyA, keyE, keyY, keyX;
int i = 0;

void setup(){
  size(1000, 700, P3D);
  noStroke();

  // An orb object that will fall and bounce around
  orb = new Orb(356, -200, 240, 5);

  // Calculate ground peak heights 
  float[] peakHeights = new float[(segments*segments)+1];
  for (int i=0; i<peakHeights.length; i++){
    peakHeights[i] = random(-10, 10);
  }

  /* Float value required for segment width (segs)
   calculations so the ground spans the entire 
   display window, regardless of segment number. */
  float segs = segments;

  
  for (int i=0; i<segments; i++){
    for(int j = 0; j < segments; j++){
      Point p1 = new Point(1000/segs*j, peakHeights[segments*i+j], 500/segs*i);
  
      Point p3 = new Point(1000/segs*(j+1), peakHeights[segments*i+j+1], 500/segs*(i+1));  
      
      Point p2 = new Point(p3.x, p1.y, p1.z);

      Point p4 = new Point(p1.x, p3.y, p3.z);
      
      ground[i][j]  = new Ground(p1,p2,p3, p4);
    }
  }
}



void draw(){
  // Background
  lights();
  background(200);
  
  /*  
  // Move and display the orb
  orb.move();
  orb.display();
  // Check walls
  orb.checkWallCollision();

  // Check against all the ground segments
  for (int i=0; i<segments; i++){
    orb.checkGroundCollision(ground[i]);
  }*/
  
  translate(400+moveX, 550+moveY, -500+moveZ);
  updateMouvement();
  rotateY(constanteY * PI);
  rotateX( constanteX * PI);
  
  orb.move();
  orb.display();  
    //for (int j = 0; j < segments-1; j++){
    //  System.out.println(ground[0][j].y);
    //}
  for (int i = 0; i < segments; i++){
    for (int j = 0; j < segments; j++){
      orb.checkGroundCollision(ground[i][j]);
    }
  }
  
  if ( i == 0 ){
    for (int i = 0; i < segments; i++){
      for (int j = 0; j < segments; j++){
        System.out.println("ground x = "+ ground[i][j].p1.x + "ground y = " + ground[i][j].p1.y +"ground z =" + ground[i][j].p1.z);
      }
    }  
  }
  
  fill(255, 80, 80);
  beginShape();
  for (int i = 0; i < segments; i++){
    for (int j = 0; j < segments; j++){
      vertex(ground[i][j].p1.x, ground[i][j].p1.y, ground[i][j].p1.z); 
      vertex(ground[i][j].p2.x, ground[i][j].p2.y, ground[i][j].p2.z);
      vertex(ground[i][j].p3.x, ground[i][j].p3.y, ground[i][j].p3.z); 
      vertex(ground[i][j].p4.x, ground[i][j].p4.y, ground[i][j].p4.z); 
    }
  }
  vertex(0, 0 , 500);
  endShape();
  
  i++;
}

void keyPressed(){
  if (key == 'q' || key == 'Q'){
    keyQ = true;
  }
  if (key == 'd' || key == 'D'){
    keyD = true;
  }
  if (key == 'a' || key == 'A'){
    keyA = true;
  }
  if (key == 'e' || key == 'E'){
    keyE = true;
  }
  if (key == 'z' || key == 'Z'){
    keyZ = true;
  }
  if (key == 's' || key == 'S'){
    keyS = true;
  }
  if (key == 'x' || key == 'X'){
    constanteX = constanteX-0.1;
  }
  if (key == 'y' || key == 'y'){
    constanteY = constanteY-0.1;
  }
}

void keyReleased(){
  if (key == 'q' || key == 'Q'){
    keyQ = false;
  }
  if (key == 'd' || key == 'D'){
    keyD = false;
  }
  if (key == 'a' || key == 'A'){
    keyA = false;
  }
  if (key == 'e' || key == 'E'){
    keyE = false;
  }
  if (key == 'z' || key == 'Z'){
    keyZ = false;
  }
  if (key == 's' || key == 'S'){
    keyS = false;
  }
  
}




void updateMouvement(){
  int mouvement = 0;
  if (keyS || keyD || keyE){
    mouvement = -20;
  }else if(keyA || keyZ || keyQ){
    mouvement = 20;
  }
    if (keyE || keyA) 
      moveZ = moveZ + mouvement;
    if (keyD || keyQ )
      moveX = moveX + mouvement;
    if (keyZ || keyS) 
      moveY = moveY+mouvement;

}
