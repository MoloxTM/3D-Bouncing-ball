class Orb {
  // Orb has positio and velocity
  PVector position;
  PVector velocity;
  float r;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.9;
  PVector gravity = new PVector(0,0.5, 0);

  Orb(float x, float y, float z, float r_) {
    position = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    r = r_;
  }

  void move() {
    // Move orb
    velocity.add(gravity);
    velocity.x *= damping;
    velocity.y *= damping;
    velocity.z *= damping;
    position.add(velocity);
  }

  void display() {
    // Draw orb
    noStroke();
    fill(0, 0, 255);
    push();
    translate(position.x, position.y, position.z);
    sphere(r);
    pop();
  }
  
  // Check boundaries of window
  void checkWallCollision() {
    if (position.y > width-r) {
      position.x = width-r;
      velocity.x *= -damping;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -damping;
    }
  }

    // Check boundaries of window
  void checkGroundFlatCollision(Ground groundSegment) {
    if(position.x  > groundSegment.p1.x && position.x < groundSegment.p2.x){
      if (position.y > groundSegment.y) {
        position.y = groundSegment.y-r;
        velocity.y *= -damping;
      }
    }
  }
 
  public float barryCentric(Point p1, Point p2, Point p3){
    float det = (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
    float l1 = ((p2.z - p3.z) * (position.x - p3.x) + (p3.x - p2.x) * (position.z - p3.z)) / det;
    float l2 = ((p3.z - p1.z) * (position.x + p3.x) + (p1.x - p3.x) * (position.z - p3.z)) / det;
    float l3 = 1.0f - l1 - l2;
    return l1 * p1.y + l2 * p2.y + l3 * p3.y;
  }
  
  void checkGroundCollision(Ground groundSegment) {
    if((position.x  >= groundSegment.p1.x && position.x < groundSegment.p3.x) && (position.z  >= groundSegment.p1.z && position.z < groundSegment.p3.z)){
      
      Point pIncident = new Point(0,0,0);
      if (abs(position.x - groundSegment.p1.x) > abs(position.x - groundSegment.p2.x)){
         pIncident.x = groundSegment.p2.x;
      }else{
         pIncident.x = groundSegment.p1.x;
      }
      
      if (abs(position.z - groundSegment.p1.z) > abs(position.z - groundSegment.p4.z)){
         pIncident.z = groundSegment.p4.z;
  
      }else{
         pIncident.z = groundSegment.p1.z;
      }
      
      Point pointVoisin1 = new Point(0,0,0);
      Point pointVoisin2 = new Point(0,0,0);
      
      if (pIncident.x == groundSegment.p1.x ){
          if (pIncident.z == groundSegment.p1.z){
            pIncident = groundSegment.p1;
            pointVoisin1 = groundSegment.p4;
            pointVoisin2 = groundSegment.p2;
          }
          else if (pIncident.z == groundSegment.p4.z){
            pIncident = groundSegment.p4;
            pointVoisin1 = groundSegment.p1;
            pointVoisin2 = groundSegment.p3;
  
          }
      }
      
      if (pIncident.x == groundSegment.p2.x ){
        if (pIncident.z == groundSegment.p3.z){
          pIncident = groundSegment.p3;
          pointVoisin1 = groundSegment.p2;
          pointVoisin2 = groundSegment.p4;
  
        }
        else if (pIncident.z == groundSegment.p1.z){
          pIncident = groundSegment.p2;
          pointVoisin1 = groundSegment.p3;
          pointVoisin2 = groundSegment.p1;        
        }
      }
      
      //System.out.println("");
      //System.out.println("-------------------------");

      //System.out.println("");

      
      //System.out.println("position x = " + position.x + " position y = " + position.y + " position z = " + position.z);

      //System.out.println("p1 x = "+ groundSegment.p1.x + " p1 y = "+ groundSegment.p1.y+" p1 z = "+ groundSegment.p1.z);
      //System.out.println("p2 x = "+ groundSegment.p2.x + " p2 y = "+ groundSegment.p2.y+" p2 z = "+ groundSegment.p2.z);
      //System.out.println("p3 x = "+ groundSegment.p3.x + " p3 y = "+ groundSegment.p3.y+" p3 z = "+ groundSegment.p3.z);
      //System.out.println("p4 x = "+ groundSegment.p4.x + " p4 y = "+ groundSegment.p4.y+" p4 z = "+ groundSegment.p4.z);

      //System.out.println("incident x = "+ pIncident.x + " incident y = "+ pIncident.y+" incident z = "+ pIncident.z);
      //System.out.println("Voisin1 x = "+ pointVoisin1.x + " Voisin1 y = "+ pointVoisin1.y+" Voisin1 z = "+ pointVoisin1.z);
      //System.out.println("Voisin2 x = "+ pointVoisin2.x + " Voisin2 y = "+ pointVoisin2.y+" Voisin2 z = "+ pointVoisin2.z);

      float incidentY = barryCentric(pIncident, pointVoisin1, pointVoisin2);
      
      //System.out.println("incidentY = " + incidentY);


      if (position.y+this.r > incidentY){
        
        
        float penteZ = (pointVoisin1.y-pIncident.y)/(pointVoisin1.z-pIncident.z);
        float penteX = (pointVoisin2.y-pIncident.y)/(pointVoisin2.x-pIncident.x);
        
        float moyX = (abs(pIncident.x) + abs(pointVoisin2.x))/2;
        Point pMilieuX = new Point(moyX, 0, pIncident.z);
        
        float moyZ = (abs(pIncident.x) + abs(pointVoisin1.x))/2;
        Point pMilieuZ = new Point(pIncident.x, 0, moyZ);
        
        float distX = dist(pMilieuX.x, 0, pMilieuX.z, abs(position.x), 0, abs(position.z));
        float distZ = dist(abs(position.x), 0, abs(position.z), pMilieuZ.x, 0, pMilieuZ.z);
        
        float disTotal = distX + distZ;
        
        float pourcX = (distX/disTotal);
        float pourcZ = (distZ/disTotal);
                    
        //System.out.println("coefX ="+ pourcX);
        //System.out.println("coefZ ="+ pourcZ);

        float nX = cos(PI/2) - atan(penteX + pourcX);
        float nY = sin(PI/2) - atan(penteX + pourcX);
        float nZ = cos((PI/2) - atan(penteZ * pourcZ));
        float nYZ = sin((PI/2) - atan(penteZ * pourcZ));  

        
        //System.out.println("1 er velocityX = "+ nZ);
        //System.out.println("1 er velocityY = "+ nY); 


        float vnX =velocity.y * nY;
        

        float vnZ =  velocity.y * nYZ;
        
        //System.out.println("tesX = "+ vnX);
        //System.out.println("testZ = "+ vnZ); 


        
        velocity.x += (damping+1) * (vnX) * nX;
        velocity.y += -(damping+1) * (vnX) * nY + (this.gravity.y);

        // System.out.println("1 er velocityX = "+ velocity.x);
        //System.out.println("1 er velocityY = "+ velocity.y); 

        velocity.z += (damping+1) * (vnZ) * nZ;
        velocity.y += -(damping+1) * (vnZ) * nYZ;
                
        position.y = incidentY-r;
        //System.out.println("2 eme velocityZ = "+ velocity.z);
        //System.out.println("2 eme velocityY = "+ velocity.y);
      }
      
    }
  }
}
