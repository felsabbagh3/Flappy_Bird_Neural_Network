import java.util.ArrayList;
public class Pipe {
  Bird flappy;
  ArrayList<Line> lines = new ArrayList<Line>();
  int h; // This is going to be the height of the pipes
  int w = 20;
  int delta = 150; // Distence between the 
  PVector velocity = new PVector(-1,0);
  public Pipe(Bird flappy) {
    this.flappy = flappy;
    h = round(random(0,height) / 2);

    //Upper Left
    lines.add(new Line(width - w, 0, width - w, h,0));
    // Upper Right
    lines.add(new Line(width, h, width, 0,0));
    //Upper Bottom
    lines.add(new Line( width - w, h, width, h,0));

    //Bottom Left
    lines.add(new Line(width - w, h + delta, width - w, height,0));
    // Bottom Right
    lines.add(new Line(width, height, width, h + delta,0));
    //Bottom Bottom
    lines.add(new Line( width - w, h + delta, width, h + delta,0));
  }
  
  public void update() {
    for (Line l: lines) {
      l.add(velocity);
      l.show();
    }
  }

  public ArrayList<Line> getLines() {
    return lines;
  }

  public PVector[] getEdges() {
    PVector[] edges = new PVector[4];

    // upTopLeft 
    edges[0] = new PVector(lines.get(0).getX0(), lines.get(0).getY0());
    // upBottomRight
    edges[1] = new PVector(lines.get(1).getX0(), lines.get(1).getY0());
    // botTopLeft
    edges[2] = new PVector(lines.get(3).getX0(), lines.get(3).getY0());
    // botBottomRight
    edges[3] = new PVector(lines.get(4).getX0(), lines.get(4).getY0());

    return edges;
  }
  
  
  public boolean isOut() {
    for (Line l: lines) {
      if (l.isOut()) {
        return true;
      }
    }
    return false;
  }
  
}