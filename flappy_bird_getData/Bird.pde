import java.io.FileWriter;

public class Bird {
  
  PVector location = new PVector();
  PVector velocity = new PVector(0,0);
  PVector deadVelocity = new PVector(-1,0);
  PVector acceleration = new PVector(0,1);
  PVector jumpAcc = new PVector(0,-30);
  int r = 20;
  int clr = 0;
  boolean dead;
  double fitness;
  int numSensors = 5;
  Line[] sensors = new Line[numSensors];
  double[] sensorValues = new double[numSensors + 1];
  int jump;
  FileWriter fileWriter;
  String fileName = "fourthTry.csv";
  char COMMA_DELIMITER = ',';
  char NEW_LINE_SEPARATOR = '\n';
  int count;
  public Bird() {
    //location.x = 350;
    location.x = 620;
    location.y = 50;
    dead = false;
    fitness = 0;
    //up
    sensors[0] = new Line(location.x, location.y, location.x + 20, location.y + 180,1);
    // down
    sensors[1] = new Line(location.x, location.y, location.x + 20, location.y - 180,1);
    // right
    sensors[2] = new Line(location.x, location.y, location.x + 200, location.y,1);
    // TopRight
    sensors[3] = new Line(location.x, location.y, location.x + 141, location.y + 141,1);
    // BottomRight
    sensors[4] = new Line(location.x, location.y, location.x + 141, location.y - 141,1);
    try {
      fileWriter = new FileWriter(fileName);
    } catch(Exception e) {
      System.out.println("Error opening file");
      exit();
    }
    count = 0;
  }

  public void reInitialize() {
    location.x = 620;
    location.y = 50;
    dead = false;
    fitness = 0;
    //up
    sensors[0] = new Line(location.x, location.y, location.x + 20, location.y + 180,1);
    // down
    sensors[1] = new Line(location.x, location.y, location.x + 20, location.y - 180,1);
    // right
    sensors[2] = new Line(location.x, location.y, location.x + 200, location.y,1);
    // TopRight
    sensors[3] = new Line(location.x, location.y, location.x + 141, location.y + 141,1);
    // BottomRight
    sensors[4] = new Line(location.x, location.y, location.x + 141, location.y - 141,1);
    clr = 0;
  }

  // public Bird(double mutRate) {
  //   this.mutRate = mutRate;
  //   location.x = 350;
  //   location.y = 50;
  //   dead = false;
  //   fitness = 0;
  //   dna = new DNA(mutRate);
  //   //up
  //   sensors[0] = new Line(location.x, location.y, location.x + 10, location.y + 90,1);
  //   // down
  //   sensors[1] = new Line(location.x, location.y, location.x + 10, location.y - 90,1);
  //   // right
  //   sensors[2] = new Line(location.x, location.y, location.x + 100, location.y,1);
  //   // TopRight
  //   sensors[3] = new Line(location.x, location.y, location.x + 70, location.y + 70,1);
  //   // BottomRight
  //   sensors[4] = new Line(location.x, location.y, location.x + 70, location.y - 70,1);
  // }

  // public Bird(DNA dna, double mutRate) {
  //   this.mutRate = mutRate;
  //   location.x = 350;
  //   location.y = 50;
  //   dead = false;
  //   fitness = 0;
  //   this.dna = dna;
  //   //up
  //   sensors[0] = new Line(location.x, location.y, location.x + 10, location.y + 90,1);
  //   // down
  //   sensors[1] = new Line(location.x, location.y, location.x + 10, location.y - 90,1);
  //   // right
  //   sensors[2] = new Line(location.x, location.y, location.x + 100, location.y,1);
  //   // TopRight
  //   sensors[3] = new Line(location.x, location.y, location.x + 70, location.y + 70,1);
  //   // BottomRight
  //   sensors[4] = new Line(location.x, location.y, location.x + 70, location.y - 70,1);
  // }
  
  public void update(ArrayList<Pipe> pipes) {
    if (!dead) {
      fitness = fitness + 1;
      velocity = velocity.add(acceleration);
      velocity.limit(10);
      location = location.add(velocity);
      for (int i = 0; i < numSensors; i++) {
        sensors[i].add(velocity);
      }
    } else {
      deadVelocity.limit(10);
      location = location.add(deadVelocity);
      for (int i = 0; i < numSensors; i++) {
        sensors[i].add(deadVelocity);
      }
    }
    fill(0,0,clr);
    stroke(0);
    ellipse(location.x,location.y,r,r);
    
    //CHECK INTERSECTION
    for (Pipe p: pipes) {
      this.checkIntersection(p);
    }

    this.checkIntersection(new Line(0,0,width,0,0));
    this.checkIntersection(new Line(0, height, width, height, 0));

    for (int i = 0; i < numSensors; i++) {
      sensors[i].show();
      // System.out.printf("The value of Sensor %d is %f\n", i, sensors[i].getSensorDist());
    }
    
    // if (count == 14) {
    //   for (int i = 0; i < numSensors; i++) {
    //     sensorValues[i] = sensors[i].getSensorDist();
    //   }
    //   sensorValues[numSensors] = velocity.y;
    //   Matrix input = new Matrix(sensorValues);
    //   double o = dna.getNextMove(input);
    //   // System.out.printf("o is : %f\n", o);
    //   if (o > 0) {
    //     this.jump();
    //   }
    //   count = 0;
    // }
    try {
      for (int i = 0; i < numSensors; i++) {
        // System.out.printf("S%d: %f  ",i+1, sensors[i].getSensorDist());
        fileWriter.append(String.valueOf(sensors[i].getSensorDist()));
        fileWriter.append(COMMA_DELIMITER);
      }
      // System.out.printf("velocity: %f  Jump: %d\n", velocity.y, jump);
      fileWriter.append(String.valueOf(velocity.y));
      fileWriter.append(COMMA_DELIMITER);
      fileWriter.append(String.valueOf(jump));
      fileWriter.append(NEW_LINE_SEPARATOR);
    } catch(Exception e) {
      System.out.println("Could not print data to file");
      exit();
    }
    
    jump = 0;
    count++;
  }

  // public Bird crossOver(Bird wife) {
  //   DNA childDNA = dna.crossOver(wife.getDNA());
  //   return new Bird(childDNA, mutRate);
  // }

  public double getFitness() {
    return (Math.pow(1.5, Math.sqrt(fitness)));
  }
  
  public void jump() {
    if (!dead) {
      jump = 1;
      velocity = velocity.add(jumpAcc);
    }
  }

  public boolean getDead() {
    return dead;
  }

  // public DNA getDNA() {
  //   return dna;
  // }

  public void checkIntersection(Pipe p) {
    ArrayList<Line> lines = p.getLines();
    for (int i = 0; i < sensors.length; i++) {
      for (Line l: lines) {
        if (sensors[i].checkIntersectionn(l)) {
          //dead = true;
          sensors[i].setColorMode(2);
        } else {
          sensors[i].setColorMode(1);
        }
      }
    }
  }

  public void checkIntersection(Line l) {
    for (int i = 0; i < sensors.length; i++) {
      if (sensors[i].checkIntersectionn(l)) {
        sensors[i].setColorMode(2);
      } else {
        sensors[i].setColorMode(1);
      }
    }
  }
  
  public void isDead(Pipe p) {
    PVector edges[] = p.getEdges();

    PVector upTopLeft = edges[0];
    PVector upBottomRight = edges[1];
    PVector botTopleft = edges[2];
    PVector botBottomRight = edges[3];
    if (location.x > upTopLeft.x && location.x < upBottomRight.x) {
      if (location.y < upBottomRight.y && location.y > upTopLeft.y) {
        clr = 240;
        dead = true;
      } else {
        if (location.y < botBottomRight.y && location.y > botTopleft.y) {
          clr = 140;
          dead = true;
        }
      }
    } else {
      if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
        clr = 50;
        dead = true;
      }
    }
  }
  
}