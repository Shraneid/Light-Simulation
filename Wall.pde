class Wall {
  float x1;
  float y1;
  float x2;
  float y2;
  
  float t;
  float u;

  Wall(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  Vector intersection(Wall wall) {
    Vector pt = cast(wall);
    return pt;
  }
  
  boolean doesCast(Wall wall) {
    float denom = (x1-x2)*(wall.y1 - wall.y2) - (y1-y2)*(wall.x1-wall.x2);
    if (denom != 0) {
      t = ((x1-wall.x1)*(wall.y1 - wall.y2) - (y1-wall.y1)*(wall.x1-wall.x2))/denom;
      u = -((x1-x2)*(y1-wall.y1) - (y1-y2)*(x1-wall.x1))/denom;
      if (t > 0 && t < 1 && u > 0 && u < 1) {
        return true;
      }
    }
    return false;
  }
  
  Vector cast(Wall wall){
    if (doesCast(wall)) {
      float xInter = x1 + t*(x2-x1);
      float yInter = y1 + t*(y2-y1);
      return new Vector(xInter, yInter);
    } else {
      return null;
    }
  }

  void display() {
    stroke(255, 0, 0);
    strokeWeight(4);
    line(x1, y1, round(x2), round(y2));
  }
}
