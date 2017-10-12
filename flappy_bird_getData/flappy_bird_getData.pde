import java.util.ArrayList;

Bird flappy;
ArrayList<Pipe> toRemove = new ArrayList<Pipe>();
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
int timer;
int timerMax;
// int timerMax;
// int lenPop;
// double mutRate;
// Population population;
// boolean done;
void setup() {
  timerMax = 120;
  timer = 0;
  flappy = new Bird();
  pipes.add(new Pipe(flappy));
  size(700,400); //<>//
} //<>//

void draw() {

  background(144);
  timer++;

  flappy.update(pipes);

  toRemove.clear();
  for (Pipe p : pipes) {
    if (!p.isOut()) {
      p.update();
      flappy.isDead(p);
    } else {
      toRemove.add(p);
    }
  }
  for (Pipe r : toRemove) {
    pipes.remove(r);
  }
  if (timer == timerMax) {
    pipes.add(new Pipe(flappy));
    timer = 0;
  }

  if (flappy.getDead()) {
    pipes.clear();
    flappy.reInitialize();
  }
}

// void mousePressed() {
//   flappy.jump();
// }

void keyPressed() {
  if (key == ' ') {
    flappy.jump();
  }
}