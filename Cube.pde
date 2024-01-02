class Cube {
  Surface s1, s2, s3, s4, s5, s6;
  Point p1, p2, p3, p4, p5, p6, p7, p8;
  float largeur, longueur;
  Cube(Point p1, Point p2, Point p3, Point p4, float largeur, float longueur) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    this.p5 = new Point(p1.x, p1.y, p1.z + largeur);
    this.p6 = new Point(p2.x, p2.y, p2.z + largeur);
    this.p7 = new Point(p3.x, p3.y, p3.z + longueur);
    this.p8 = new Point(p4.x, p4.y, p4.z + longueur);
    this.largeur = largeur;
    this.longueur = longueur;

    this.s1 = new Surface(p1, p2, p3, p4);
    this.s2 = new Surface(p5, p6, p7, p8);
    this.s3 = new Surface(p4, p3, p7, p8);
    this.s4 = new Surface(p1, p2, p6, p5);
    this.s5 = new Surface(p1, p4, p8, p5);
    this.s6 = new Surface(p2, p3, p7, p6);
  }
  
  void display() {
    s1.display();
    s2.display();
    s3.display();
    s4.display();
    s5.display();
    s6.display();
  }
}
