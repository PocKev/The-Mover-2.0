class Wall {

  float x, y, w, h;
  Body b;

  public Wall(float x_, float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    b = box2d.createBody(bd);

    b.createFixture(sd, 1);
  }

  void display() {
    float angle = b.getAngle();

    pushMatrix();
    rectMode(CENTER);
    fill(100, 65, 95);
    translate(x, y);
    rotate(-angle);
    rect(0, 0, w, h);
    popMatrix();
  }
}
