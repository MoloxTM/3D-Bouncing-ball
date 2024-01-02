class Ground {
  Point p1, p2, p3, p4;
  float x, y, z, len, rot;
  
  // Constructor
  Ground(Point p1, Point p2, Point p3, Point p4) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    
    x = (p2.x+p1.x)/2;
    y = (p2.y+p1.y)/2;
    z = (p2.z+p1.z) /2;
    len = dist(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    rot = atan2((p1.y-p2.y), (p1.x-p2.x));
  }
}
