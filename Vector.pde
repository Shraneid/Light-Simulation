class Vector {
  float x, y;

  Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }

  float distance(Vector v) {
    return sqrt(pow(v.x-this.x, 2) + pow(v.y-this.y, 2));
  }

  Vector getNormal() {
    float len = sqrt(pow(x, 2) + pow(y, 2));
    return new Vector((y/len)*2, (-x/len)*2);
  }
  
  Vector getNormal2() {
    float len = sqrt(pow(x, 2) + pow(y, 2));
    return new Vector((y/len)*2, (-x/len)*2);
  }

  Vector getInverse() {
    return new Vector(-x, -y);
  }
  
  Vector add(Vector v){
    return new Vector(x+v.x, y+v.y);
  }
}
