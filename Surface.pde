class Surface {

  Point p1, p2, p3, p4;
  float largeur, longueur;
  Point[] points;
  Surface(Point p1, Point p2, Point p3, Point p4) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    this.points = new Point[] {p1, p2, p3, p4};
  }
  
  void display() {
    beginShape(QUADS);
      stroke(0, 0, 0);
      fill(255,0,0);
      vertex(p1.x, p1.y, p1.z);
      vertex(p2.x, p2.y, p2.z);
      vertex(p3.x, p3.y, p3.z);
      vertex(p4.x, p4.y, p4.z);
    endShape();
  }
  
  Point maxPointY(Point p1, Point p2) {
    if(p1.y > p2.y) return p1;
    return p2;
  }
  
  Point closestPoint(float targetx, float targetz, Point[] points) {
    Point closest = p1;
    float minDelta = Float.MAX_VALUE;
    for(int i = 0; i < 4; i++){
      float delta = dist(abs(targetx), abs(targetz), abs(points[i].x), abs(points[i].z));
      if(delta < minDelta) {
        minDelta = delta;
        closest = points[i];
      }
    }
    return closest;
  }
  
  // ATTENTION indice 0 -> x et indice 1 -> z
  Point[] associatePoints(Point p) {
    Point[] res = new Point[2];
    if((p.x == p1.x) && (p.z == p1.z)) {
      res[0] = p4;
      res[1] = p2;
    } else if((p.x == p2.x) && (p.z == p2.z)){
      res[0] = p3;
      res[1] = p1;      
    } else if((p.x == p3.x) && (p.z == p3.z)){
      res[0] = p2;
      res[1] = p4;      
    } else if((p.x == p4.x) && (p.z == p4.z)){
      res[0] = p1;
      res[1] = p3;      
    }
    return res;
  }
    
  float barryCentric(Point p1, Point p2, Point p3, PVector pos) {
    float det = (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
    float l1 = ((p2.z - p3.z) * (pos.x - p3.x) + (p3.x - p2.x) * (pos.z - p3.z)) / det;
    float l2 = ((p3.z - p1.z) * (pos.x - p3.x) + (p1.x - p3.x) * (pos.z - p3.z)) / det;
    float l3 = 1.0f - l1 - l2;
    return l1 * p1.y + l2 * p2.y + l3 * p3.y;
  }
  
}
