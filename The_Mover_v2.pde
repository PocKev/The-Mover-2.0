import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
Vec2 s;
Player player;
PImage map;
Map mapBound;

void setup() {
  size(600, 400); //3:2
  smooth();
  noCursor();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0); //top view down
  player = new Player(25, 25, width/2, height/2);
  map = loadImage("mapExampleImage.jpg");
  mapBound = new Map("mapFile.txt");
  //map.resize(map.width, map.height);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2 - player.pos.x, height/2 - player.pos.y);
  //image(map, 0, 0); //it's too laggy on mac
  mapBound.display();
  player.display();
  popMatrix();

  /* OverLay Canvas
   rectMode(CENTER);
   rect(width/2, 350, 0.9*width, 40);
   */

  drawCrosshair();

  box2d.step();
}

void keyPressed() {
  player.move(key);
}

void keyReleased() {
  player.stopMove(key);
}

void drawCrosshair() {
  ellipseMode(CENTER);
  noFill();
  stroke(255);
  ellipse(mouseX, mouseY, 25, 25);
  ellipse(mouseX, mouseY, 1, 1);
  //Handle box2d rotation here:
  Vec2 sight = new Vec2(mouseX - width/2, height/2 - mouseY);
  float sightAngle = PI/2 + atan(sight.y / sight.x);
  if (mouseX >= width/2) { //account for domain error for atan() in quandrant I and IV
    sightAngle += PI;
  }
  player.defineAngle(sightAngle);
}
