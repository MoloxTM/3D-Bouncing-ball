class Axes {

  float x, y, z;
  Axes(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void display() {
    beginShape(LINES);
      stroke(138,43,226);
      vertex(0, 0, 0);
      vertex(x, 0, 0);
      stroke(0, 255, 0);
      vertex(0, 0, 0);
      vertex(0, y, 0);
      stroke(0, 0, 255);
      vertex(0, 0, z);
      vertex(0, 0, 0);
    endShape();
  }
}
