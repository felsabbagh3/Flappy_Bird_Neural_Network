import java.util.ArrayList;
import java.util.Random;
public class Population {

	Bird[] flappy;
	ArrayList<Pipe> toRemove = new ArrayList<Pipe>();
	ArrayList<Pipe> pipes = new ArrayList<Pipe>();
	int timer;
	boolean dead;
	double mutRate;
	int timerMax;
	int lenPop;
	int generation;
	ArrayList<Bird> parents;
	double totalFitness;
  double compMaxFitness;
  DNA compMaxDNA;
	double maxFitness;
	DNA bestDNA;
	Random rand = new Random();
double[][] hiddenLayer = {{-131.724547,  -197.772397,  -286.338091,  -114.522966,  -132.052384,  -44.773379},  
                              {-131.727395,  -197.316632,  -286.682545,  -112.911505,  -131.707375,  -45.568664}, 
                              {-130.665256,  -198.310057,  -285.574670,  -114.579482,  -130.524214,  -45.721954},
                              {-130.815692,  -198.555040,  -285.180199,  -112.852148,  -132.080392,  -44.624316},  
                              {-131.184256,  -198.091632,  -286.241913,  -113.659786,  -131.975132,  -44.296152},  
                              {-131.419030,  -198.757728,  -285.573640,  -113.798239,  -130.893530,  -44.664738}};
double[][] outPutLayer = {{-0.182690,  0.358222,  -0.726870,  -0.015811,  -0.677495,  0.766806}};
	public Population(int lenPop, double mutRate, int timerMax) {
		this.lenPop = lenPop;
		this.mutRate = mutRate;
		this.timerMax = timerMax;
		this.generation = 1;
		this.totalFitness = 0;
		this.maxFitness = 0;
		this.parents = new ArrayList<Bird>();
	    timer = 0;
		flappy = new Bird[lenPop];
		for (int i = 0; i < lenPop; i++) {
			flappy[i] = new Bird(mutRate);
      //flappy[i].setDNA(hiddenLayer, outPutLayer);
		}
	    pipes.add(new Pipe(flappy));
	}

	public void update() {
		timer++;
		for (Bird f: flappy) {
			f.update(pipes);
		}

		toRemove.clear();
		for (Pipe p : pipes) {
			if (!p.isOut()) {
				p.update();
				for (Bird f: flappy) {
					f.isDead(p);
				}
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

		calculateFitnessStuff();
	}

	public void calculateFitnessStuff() {
		maxFitness = 0;
		totalFitness = 0;
		for (int i = 0; i < lenPop; i++) {
			if (flappy[i].getFitness() > maxFitness) {
				maxFitness = flappy[i].getFitness();
				bestDNA = flappy[i].getDNA();
			}
			totalFitness = totalFitness + flappy[i].getFitness();
		}
    if (maxFitness > compMaxFitness) {
      compMaxFitness = maxFitness;
      compMaxDNA = bestDNA;
    }
	}

	public void naturalSelection() {
		this.makeParents();
		Bird child;
		Bird one;
		Bird two;
		for (int i = 0; i < lenPop; i++) {
			int oneRand = rand.nextInt(parents.size());
			int twoRand = rand.nextInt(parents.size());
			one = parents.get(oneRand);
			two = parents.get(twoRand);
			child = one.crossOver(two);
			flappy[i] = child;
		}
		this.printGen();
		pipes.clear();
		generation++;
	}

	public void makeParents() {
		parents.clear();
		Double weight;
		Integer n;
		for (int i = 0; i < lenPop; i++) {
			weight = (flappy[i].getFitness() / totalFitness) * 100;
			n =  weight.intValue();
			//System.out.printf("Weight: %d\n", n);
			for (int z = 0; z < n; z++) {
				parents.add(flappy[i]);
			}
		}

//  if (parents.size() == 0) {
//    Bird b = null;
//    double maxFit = -1;
//    for (int i = 0; i < lenPop; i++) {
//        if (flappy[i].getFitness() > maxFit) {
//          b = flappy[i];
//        }
//    }
//    parents.add(b);
//  }
  
	}

	public void printGen() {
		System.out.printf("Current Generation is: %d\n", generation);
		System.out.printf("maxFitness: %f\n", maxFitness);
		System.out.printf("totalFitness: %f\n", totalFitness);
		System.out.printf("mutRate: %f\n", mutRate);
		bestDNA.print();
		System.out.printf("\n\n");
    System.out.println("Overall best DNA\n");
    compMaxDNA.print();

	}

	public boolean checkAllDead() {
		for (int i = 0; i < lenPop; i++) {
			if (!flappy[i].getDead()) {
				return false;
			}
		}
		return true;
	}

}