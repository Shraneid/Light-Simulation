class Ray { //<>//
  float x1, y1, x2, y2, angle, denom, u, t, xInter, yInter;

  Ray(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  Ray(Vector v, Vector v2) {
    x1 = v.x;
    y1 = v.y;
    x2 = v.x+v2.x;
    y2 = v.y+v2.y;
  }

  Vector direction() {
    return new Vector(x2-x1, y2-y1);
  }

  void set(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  void lookAt(float x, float y) {
    x2 = x;
    y2 = y;
  }

  void calcAngle() {
    float x = x2-x1;
    float y = y2-y1;

    this.angle = atan(y/x);

    this.angle = map(this.angle, 0, TWO_PI, 0, 360);
    if (x < 0) {
      angle += 180;
    }
  }

  boolean doesCast(Wall wall) {
    denom = (x1-x2)*(wall.y1 - wall.y2) - (y1-y2)*(wall.x1-wall.x2);
    if (denom != 0) {
      t = ((x1-wall.x1)*(wall.y1 - wall.y2) - (y1-wall.y1)*(wall.x1-wall.x2))/denom;
      u = -((x1-x2)*(y1-wall.y1) - (y1-y2)*(x1-wall.x1))/denom;
      if (t > 0 && u > 0 && u < 1) {
        return true;
      }
    }
    return false;
  }

  Vector cast(Wall wall) {
    if (doesCast(wall)) {
      xInter = x1 + t*(x2-x1);
      yInter = y1 + t*(y2-y1);
      return new Vector(xInter, yInter);
    } else {
      xInter = -1;
      yInter = -1;
      return null;
    }
  }

  Ray copy() {
    return new Ray(this.x1, this.y1, this.x2, this.y2);
  }

  void display() {
    strokeWeight(1);
    stroke(255);
    line(x1, y1, x2, y2);
  }
}
