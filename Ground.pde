class Ground {
  Surface[] terrain;
  Surface[][] terrain2;
  int[][] peakValues;
  int longueur, largeur, n, peak;
  float peakHeigh;
  Point p1, p2, p3, p4;

  Ground(int longueur, int largeur, int n, int peak) {
    this.terrain = new Surface[longueur];
    this.terrain2 = new Surface[longueur*2][largeur*2];
    this.peakValues = new int[longueur*2][largeur*2];
    this.longueur = longueur;
    this.largeur = largeur;
    this.n = n;
    this.peak = peak;
    generatePeakValues();
    generateTerrain2();
  }

  void generateTerrain() {
    int pas = (int)(longueur/n);
    for(int i = 0; i < n; i++) {
      if(i==0) {
        peakHeigh = random(-peak, peak);
        p1 = new Point(i, peakHeigh, 0);
        peakHeigh = random(-peak, peak);
        p2 = new Point(i + pas, peakHeigh, 0);
        peakHeigh = random(-peak, peak);
        p3 = new Point(i + pas, peakHeigh, largeur);
        peakHeigh = random(-peak, peak);
        p4 = new Point(i, peakHeigh, largeur);
      } else {
        p1 = terrain[i-1].p2;
        peakHeigh = random(-peak, peak);
        p2 = new Point((i + 1) * pas, peakHeigh, 0);
        peakHeigh = random(-peak, peak);
        p3 = new Point((i + 1) * pas, peakHeigh, largeur);
        p4 = terrain[i-1].p3;
      }
      Surface s = new Surface(p1, p2, p3, p4);
      terrain[i] = s;
    }
  }
  void generatePeakValues(){
    for(int i = 0; i< 2*n;i++){
        for(int j =0; j< 2*n ; j++){
          peakValues[i][j] = (int)random(-peak,peak);
      }
    }
  }
  
  void generateTerrain2() {
    int pasx = (int)(longueur/n);
    int pasz = (int)(largeur/n);
    int k = 0;
    for(int i = -n; i < n; i++){
      int h = 0;
      for(int j = -n; j < n; j++){
        p1 = new Point(i*pasx, peakValues[k][h], j*pasz);
        p4 = new Point(i*pasx, peakValues[k][h+1], (j+1)*pasz);
        p2 = new Point((i+1)*pasx, peakValues[k+1][h], j*pasz);
        p3 = new Point((i+1)*pasx, peakValues[k+1][h+1], (j+1)*pasz);
        Surface s = new Surface(p1, p2, p3, p4);
        //System.out.println("Surface p1 x :" + s.p1.x + " p2 x :" + s.p2.x + "p3 x :" + s.p3.x + " p4 x :" + s.p4.x);
        terrain2[k][h] = s;
        h++;
      }
      k++;
    }
  }
  
  void display2() {
    for(int i = 0; i < (2*n)-1; i++) {
      for(int j = 0; j < (2*n)-1; j++){
        Surface s = terrain2[i][j];
        s.display();
      }     
    }
  }
  
  void display() {
    for(int i=0; i < this.n; i++) {
      Surface s = this.terrain[i];
      s.display();
    }
  }
  
  void printTerrain() {
    for(int i = 0; i < 2*n; i++){
      for(int j = 0; j < 2*n; j++){
        Surface s = terrain2[i][j];
        System.out.println("Surface p1 x :" + s.p1.x + " p1 z:" +s.p1.z + " p2 x :" + s.p2.x + "p3 x :" + s.p3.x + " p4 x :" + s.p4.x + " i:" + i + " j:" + j);
      }
    }
  }

}
