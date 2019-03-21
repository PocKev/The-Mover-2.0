class Map {
  ArrayList<Wall> walls;

  public Map(String fileName) {
    walls = new ArrayList<Wall>();
    loadMap(fileName);
    //walls.add(new Wall(350, 100, 400, 10, 0));
  }

  void display() {
    for (Wall wall : walls) {
      wall.display();
    }
  }
  
  void loadMap(String f) {
    String[] lines = loadStrings(f); //get all lines, store it into an array
    for (int i = 0; i < lines.length; i++) {
      float[] args = float(split(lines[i], ',')); //reading each line
      walls.add(new Wall(args[0], args[1], args[2], args[3], args[4])); //creates a new shape stored in file
    }
    System.out.println("loaded");
  }
}
