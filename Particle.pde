class Particle { //<>// //<>// //<>// //<>//
  float x;
  float y;
  ArrayList<Ray> rays;

  Particle(float x, float y, ArrayList<Wall> walls) {
    this.x = x;
    this.y = y;
    rays = new ArrayList<Ray>();
    for (Wall wall : walls) {
      rays.add(new Ray(this.x, this.y, wall.x1, wall.y1));
      rays.add(new Ray(this.x, this.y, wall.x2, wall.y2));
    }
  }

  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update(ArrayList<Wall> walls) {
    rays.clear();

    //ADD RAYS ON EVERY WALL END
    for (int i = 0; i < walls.size()*2; i+=2) {
      rays.add(new Ray(x, y, walls.get(floor(i/2)).x1, walls.get(i/2).y1));
      rays.add(new Ray(x, y, walls.get(floor(i/2)).x2, walls.get(i/2).y2));
    }

    //ADDING NEW RAYS ON WALLS INTERSECTIONS
    for (int i = 0; i < walls.size()-1; i++) {
      for (int j = i; j < walls.size(); j++) {
        if (i != j) {
          Wall w1 = walls.get(i);
          Wall w2 = walls.get(j);
          Vector pt = w1.intersection(w2);
          if (pt != null) {
            rays.add(new Ray(x, y, pt.x, pt.y));
          }
        }
      }
    }

    //CREATE TRIPLE RAYS TO DEAL WITH EDGE DETECTION
    ArrayList<Ray> newRays = new ArrayList<Ray>();
    for (Ray ray : rays) {
      Vector n = ray.direction().getNormal();
      Vector n2 = ray.direction().getNormal2();
      newRays.add(ray);
      
      newRays.add(new Ray(new Vector(x, y), ray.direction().add(n)));
      newRays.add(new Ray(new Vector(x, y), ray.direction().add(n.getInverse())));
      
      newRays.add(new Ray(new Vector(x, y), ray.direction().add(n2)));
      newRays.add(new Ray(new Vector(x, y), ray.direction().add(n2.getInverse())));
    }

    rays = newRays;

    //CASTING RAYS DEFINED PREVIOUSLY
    int count = 0;
    for (Ray ray : rays) {
      Vector closest = null;
      float record = 500000000;

      for (Wall wall : walls) {
        Vector pt = ray.cast(wall);
        if (pt != null) {
          float d = pt.distance(new Vector(this.x, this.y));
          if (d < record) {
            closest = pt;
            record = d;
          }
        }
      }

      //DRAWING FINAL RAYS
      if (closest != null) {
        //stroke(255, 20);
        stroke(count, 100, 100);
        count += 255/rays.size();
        ray.x2 = closest.x;
        ray.y2 = closest.y;
      }
      ray.calcAngle();
    }

    sort();
  }

  void displayRays() {
    int count = 0;
    for (Ray ray : rays) {
      stroke(count, 100, 100);
      count += 255/rays.size();
      line(ray.x1, ray.y1, ray.x2, ray.y2);
    }
  }

  void displayMask() {
    noFill();
    stroke(0, 255, 0);
    beginShape();
    for (int i = 0; i < rays.size(); i++) {
      vertex(rays.get(i).x2, rays.get(i).y2);
    }
    vertex(rays.get(0).x2, rays.get(0).y2);
    endShape();
  }

  PGraphics getMask() {
    PGraphics mask = createGraphics(width, height);

    fill(255);
    mask.beginDraw();
    mask.beginShape();
    for (int i = 0; i < rays.size(); i++) {
      mask.vertex(rays.get(i).x2, rays.get(i).y2);
    }
    mask.vertex(rays.get(0).x2, rays.get(0).y2);
    mask.endShape();
    mask.endDraw();

    return mask;
  }

  void sort() {
    ArrayList<Ray> newRays = new ArrayList<Ray>();
    for (int i = rays.size()-1; i > 0; i--) {
      Ray lower = rays.get(i);
      for (Ray ray : rays) {
        if (ray.angle < lower.angle) {
          lower = ray;
        }
      }
      newRays.add(lower.copy());
      rays.remove(lower);
    }
    rays = newRays;
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(x, y, 16, 16);
  }
}
