class Orb {
  // Orb has positio and velocity
  PVector position;
  PVector velocity;
  float r, x, y, z, k;
  PVector gravity;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8;
  boolean surfaceFind = false;

  Orb(float x, float y, float z, float r_, PVector gravity, float k) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r_;
    this.gravity = gravity;
    this.k = k;
    position = new PVector(this.x, this.y, this.z);
    velocity = new PVector(0, gravity.y, 0);
  }

  void move() {
    // Move orb
    velocity.add(gravity);
    velocity.x *= k;
    velocity.y *= k;
    velocity.z *= k;
    position.add(velocity);
    //System.out.println("Position x:" + position.x + " y:" + position.y + " z:" + position.z);
  }

  void display() {
    translate(position.x, position.y, position.z);
    noStroke();
    fill(0, 0, 255);
    sphere(r);
    //System.out.println("Orb x:" + position.x + " y:" +position.y + " z:" + position.z);
  }
  

  void checkGroundCollision(Ground ground) {

    if(position.x < -ground.longueur || position.x > ground.longueur || position.z < -ground.largeur || position.z > ground.largeur) return;
    
    // On cherche la surface la plus proche de la sphère en x et z
    Surface s = ground.terrain2[0][0];
    boolean findSurface = false;
    int i = 0;
    while((i < 2*ground.n)&&(!findSurface)) {
      int j = 0;
      while((j < 2*ground.n)&&(!findSurface)){
        //System.out.println("i:" + i + " j:" + j);
        s = ground.terrain2[i][j];
        if((abs(s.p1.x) <= abs(this.position.x)) && (abs(s.p3.x) >= abs(this.position.x)) && (abs(s.p1.z) <= abs(this.position.z)) && (abs(s.p3.z) >= abs(this.position.z))){
          findSurface = true;
        } 
        j++;
      }
      i++;
    }
    
    // On récupère le point le plus près de la sphère en x et z et les segments qui lui sont associés
    Point closest = s.closestPoint(position.x, position.z, s.points);
    Point[] pointsAssocie = s.associatePoints(closest);
    Point paX = pointsAssocie[0];
    Point paZ = pointsAssocie[1];

    float heightSurfaceImpact = s.barryCentric(paX, paZ, closest, position);
    
    float sphereLedge = position.y;

    for(float alpha = 0; alpha > -PI/2; alpha-= 0.001) {
      sphereLedge += r * sin(alpha);
      if(sphereLedge > heightSurfaceImpact) {
        //System.out.println("Au dessus - sphereLedge:" + sphereLedge + " Barry:" + heightSurfaceImpact);
        return;
      }
    
    }

    position.y = heightSurfaceImpact - r;

    //Milieu Segment en x
    float moyX = (abs(closest.x) + abs(paZ.x))/2;
    Point pMilieuX = new Point(moyX, 0, closest.z);

    //Milieu segment en z
    float moyZ = (abs(closest.z) + abs(paX.z))/2;
    Point pMilieuZ = new Point(closest.x, 0, moyZ);

    //Calcul du pourcentage d'influence
    float distX = dist(abs(pMilieuX.x), 0,abs(pMilieuX.z), abs(position.x), 0, abs(position.z));
    float distZ = dist(abs(position.x), 0,abs(position.z), abs(pMilieuZ.x), 0, abs(pMilieuZ.z));
    float disTotal = distX + distZ;
    float coeffX = (distX/disTotal);
    float coeffZ = (distZ/disTotal);
    //System.out.println("coeffX:" + coeffX);
    //System.out.println("coeffZ:" + coeffZ);

    
    //Calcul des pentes (coeffs directeur des segments en x et en z)
    float aX = ((paZ.y) - (closest.y)) / ((paZ.x) - (closest.x));
    float aZ = ((paX.y) - (closest.y)) / ((paX.z) - (closest.z));
    //System.out.println("aX:" + aX);
    //System.out.println("aZ:" + aZ);
    
    //Partie pour x
    float nX = cos((PI/2) - atan(aX * coeffX));
    //System.out.println("nx :" + nX);
    float nY = sin((PI/2) - atan(aX * coeffX));
    //System.out.println("nyx :" + nY);
    
    //Partie pour z
    float nZ = cos((PI/2) - atan(aZ * coeffZ));
    float nYZ = sin((PI/2) - atan(aZ * coeffZ));
    //System.out.println("nZ:" + nZ);
    //System.out.println("nYZ:" + nYZ);


    float vnX = velocity.x*nX + velocity.y*nY;
    float vnZ = velocity.z*nZ + velocity.y*nYZ;
    //System.out.println("vnX:" + vnX);
    //System.out.println("vnZ:" + vnZ);

    velocity.x += (k+1)*(vnX)*nX;
    velocity.y += -(k+1)*(vnX)*nY + (this.gravity.y);
    
    velocity.z += (k+1)*(vnZ)*nZ;
    velocity.y += -(k+1)*(vnZ)*nYZ;
    //System.out.println("velocity x:" + velocity.x + " y:" + velocity.y + " z:" + velocity.z);
    
  }

}
