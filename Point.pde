class Point {
  float x, y, z;
  
  Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
      
  void afficher() {
    System.out.println( "Point{x=" + x + ", y=" + y + ", z=" + z + "}");
  }
    
}
