class Player {
  Body body;
  float w;
  float h;
  boolean up = false, down = false, left = false, right = false;
  Vec2 upV, downV, leftV, rightV, totalV;
  int f = 15; //increment speed

  Vec2 pos;
  float a;

  public Player(float w_, float h_, float x_, float y_) {
    w = w_;
    h = h_;
    upV = new Vec2(0, 0);
    downV = new Vec2(0, 0);
    leftV = new Vec2(0, 0);
    rightV = new Vec2(0, 0);
    totalV = new Vec2(0, 0);

    pos = new Vec2(x_, y_);
    makeBody(pos);
  }

  void defineAngle(float a_) {
    body.setTransform(body.getPosition(), a_);
    //System.out.println(a_ + " " + a);
  }

  void display() {
    if (up) upV = new Vec2(0, f);
    else upV = new Vec2(0, 0);
    if (down) downV = new Vec2(0, -f);
    else downV = new Vec2(0, 0);
    if (left) leftV = new Vec2(-f, 0);
    else leftV = new Vec2(0, 0);
    if (right) rightV = new Vec2(f, 0);
    else rightV = new Vec2(0, 0);
    totalV = upV.add(downV.add(leftV.add(rightV)));
    if (totalV.x != 0 && totalV.y != 0) { //if moving diagonally
      totalV.x /= sqrt(2);
      totalV.y /= sqrt(2);
    }
    //System.out.println(totalV);
    body.setLinearVelocity(totalV);


    pos = box2d.getBodyPixelCoord(body);
    a = body.getAngle();
    rectMode(CENTER); 
    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255);
    stroke(0);
    ellipse(0, 0, w, h);
    line(0, 0, 0, -h/2);
    popMatrix();
  }

  void move(char c) {
    switch (c) {
    case 'w':
      up = true;
      break;
    case 'a':
      left = true;
      break;
    case 's':
      down = true;
      break;
    case 'd':
      right = true;
      break;
    }
    //body.setLinearVelocity(new Vec2(0, 10));
    //body.applyLinearImpulse(new Vec2(0,20), box2d.getBodyPixelCoord(body), true);
  }
  void stopMove(char c) {
    switch (c) {
    case 'w':
      up = false;
      break;
    case 'a':
      left = false;
      break;
    case 's':
      down = false;
      break;
    case 'd':
      right = false;
      break;
    }
    //body.setLinearVelocity(new Vec2(0, 0));
    //body.applyLinearImpulse(new Vec2(0,-20), box2d.getBodyPixelCoord(body), true);
  }

  void makeBody(Vec2 center) { //Shiffman Code
    // (sd is for square player)
    /*
    PolygonShape sd = new PolygonShape();
     float box2dW = box2d.scalarPixelsToWorld(w/2);
     float box2dH = box2d.scalarPixelsToWorld(h/2);
     sd.setAsBox(box2dW, box2dH);
     */
    CircleShape cs = new CircleShape();
    //cs.m_p.set(0, 0); 
    cs.m_radius = box2d.scalarPixelsToWorld(w/2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs; //change to sd if switch back to square
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 0.3;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    //body.setLinearVelocity(new Vec2(random(-5, 5), random(-5, 5)));
    //body.setAngularVelocity(random(-5, 5));
  }
}
