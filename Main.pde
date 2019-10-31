Particle part;
ArrayList<Wall> walls;
float angle = 270;
int wallNumber = 5;

PImage cropped;
PImage sourceImage;
PGraphics mask;

void setup() {
  size(1280, 720);
  
  sourceImage = loadImage("grad2.png");
  sourceImage.resize(width*2, width*2);
  sourceImage.loadPixels();

  cropped = createImage(1280, 750, RGB);
  cropped.loadPixels();

  translate(width/2, height/2);
  walls = new ArrayList<Wall>();

  walls.add(new Wall(0, 0, width, 0));
  walls.add(new Wall(width, 0, width, height));
  walls.add(new Wall(width, height, 0, height));
  walls.add(new Wall(0, height, 0, 0));
  
  walls.add(new Wall(100, 100, 300, 400));
  walls.add(new Wall(100, 300, 300, 100));

  walls.add(new Wall(width/2, 0, width/2 + 200, 350));

  walls.add(new Wall(400, 550, 500.1, 550));
  walls.add(new Wall(500, 550, 500, 650.1));
  walls.add(new Wall(500, 650, 399.9, 650));
  walls.add(new Wall(400, 650, 400, 549.9));

  walls.add(new Wall(width, 500, width -100, 590));
  walls.add(new Wall(1079,height,1137,646));

  walls.add(new Wall(999.9, 100, 1200.1, 100));
  walls.add(new Wall(1200, 100, 1099.9, 300.1));
  walls.add(new Wall(1100, 300, 999.9, 99.9));
  
  walls.add(new Wall(348,182,328,296));

  part = new Particle(0, 0, walls);
}

void draw() {
  background(0);

  part.setPos(mouseX, mouseY);
  part.update(walls);

  mask = part.getMask();

  cropped = sourceImage.get(width - mouseX, width - mouseY, width, height);
  cropped.mask(mask);

  image(cropped, 0, 0);

  displayWalls();
}

//DISPLAY WALLS
void displayWalls() {
  for (Wall wall : walls) {
    wall.display();
  }
}
