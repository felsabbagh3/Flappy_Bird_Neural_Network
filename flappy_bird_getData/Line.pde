public class Line {
  
  int x0;
  int y0;
  int x1;
  int y1;
  int colorMode;
  PVector pointIntersec = null;
  double pointIntersecDist = 200;
  boolean intersect = false;
  
  public Line(int x0, int y0, int x1, int y1, int colorMode) {
    this.x0 = x0;
    this.y0 = y0;
    this.x1 = x1;
    this.y1 = y1;
    this.colorMode = colorMode;
  }
  
  public Line(float x0, float y0, float x1, float y1, int colorMode) {
    this.x0 = (int) x0;
    this.y0 = (int) y0;
    this.x1 = (int) x1;
    this.y1 = (int) y1;
    this.colorMode = colorMode;
  }


  public void show() {
    if (colorMode == 0) {
      stroke(0,255,0);
    } else {
      if (colorMode == 1) {
        stroke(250, 0, 0);
      } else {
        stroke(0, 0, 255);
      }
    }
    line(x0, y0, x1, y1);
    if (pointIntersec != null) {
      noFill();
      ellipse((int) pointIntersec.x, (int) pointIntersec.y, 10, 10);
    }
    intersect = false;
  }

  public void setPointIntersec(PVector curr, double dist) {
    pointIntersec = curr;
    pointIntersecDist = dist;
  }

  public int getIntersect() {
    if (intersect) {
      return 1;
    } else {
      return 0;
    }
  }

  public double getSensorDist() {
    return 200 - pointIntersecDist;
  }

  public boolean checkIntersectionn(Line o) {
    PVector tempIntersect =  get_line_intersection(x0,y0,x1,y1,o.getX0(),o.getY0(),o.getX1(),o.getY1());
    if (tempIntersect != null) {
      double tempDist = this.calculateDist(tempIntersect);
      //System.out.printf("tempDist: %f\n", tempDist);
      if (pointIntersec != null) {
        if (pointIntersecDist > tempDist) {
          setPointIntersec(tempIntersect, tempDist);
        }
      } else {
        setPointIntersec(tempIntersect, tempDist);
      }
      intersect = true;
      // return true;
    } else {
      if (!intersect) {
        setPointIntersec(null, 200);
        intersect = false;
      }
    }
    return false;
  }

// Returns 1 if the lines intersect, otherwise 0. In addition, if the lines 
// intersect the intersection point may be stored in the floats i_x and i_y.
  public PVector get_line_intersection(float p0_x, float p0_y, float p1_x, float p1_y, 
    float p2_x, float p2_y, float p3_x, float p3_y) {

    float s1_x;
    float s1_y;
    float s2_x;
    float s2_y;
    s1_x = p1_x - p0_x;
    s1_y = p1_y - p0_y;
    s2_x = p3_x - p2_x;
    s2_y = p3_y - p2_y;

    float s, t;
    s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

    if (s >= 0 && s <= 1 && t >= 0 && t <= 1) {
        // Collision detected
        //if (i_x != null)
        double i_x = p0_x + (t * s1_x);
        //if (i_y != null)
        double i_y = p0_y + (t * s1_y);
        return new PVector( (int) i_x, (int) i_y);
    }
    return null;
  }

  private double calculateDist(PVector poin) {
    return Math.sqrt((x0-poin.x)*(x0-poin.x) + (y0-poin.y)*(y0-poin.y));
  }



  public void setColorMode(int i) {
    colorMode = i;
  }
  
  public int getX0() {
    return x0;
  }

  public int getX1() {
    return x1;
  }
  
  public int getY1() {
    return y1;
  }
  
  public int getY0() {
    return y0;
  }

  public boolean isOut() {
    if (x0 < 0 || x1 < 0) {
      return true;
    } else {
      return false;
    }
  }

  public void add(PVector other) {
    x0 = x0 + (int) other.x;
    x1 = x1 + (int) other.x;
    y0 = y0 + (int) other.y;
    y1 = y1 + (int) other.y;
  }

  
  
}