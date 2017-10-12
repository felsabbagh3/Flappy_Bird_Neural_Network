import java.util.ArrayList;

// Bird flappy;
// ArrayList<Pipe> toRemove = new ArrayList<Pipe>();
// ArrayList<Pipe> pipes = new ArrayList<Pipe>();
// int timer;
// boolean dead;
int timerMax;
int lenPop;
double mutRate;
Population population;
boolean done;
void setup() {
  frameRate(500);
  done = false;
  //timerMax = 120;
  timerMax = 120;
  mutRate = 0.009;
  lenPop = 50;
  population = new Population(lenPop, mutRate, timerMax);
  size(700,400); //<>//
} //<>//

void draw() {

  background(144);
  population.update();

  if (population.checkAllDead()) {
    population.naturalSelection();
  }
}

// void mousePressed() {
//   flappy.jump();
// }

// void keyPressed() {
//   if (key == ' ') {
//     flappy.jump();
//   }
// }