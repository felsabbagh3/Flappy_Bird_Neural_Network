public class DNA {
  Matrix hiddenLayer;
  Matrix hiddenLayer2;
  Matrix outPutLayer;
  double mutRate;
  static double total = 0;
  static double correctJump = 0;
  static double correct = 0;
  public DNA(double mutRate) {
    this.hiddenLayer = new Matrix(6,6);
    this.hiddenLayer2 = new Matrix(6,6);
    this.outPutLayer = new Matrix(1,6);
    this.mutRate = mutRate;
  }

  public DNA(Matrix hiddenLayer, Matrix outPutLayer,double mutRate) {
    this.hiddenLayer = hiddenLayer;
    this.outPutLayer = outPutLayer;
    this.mutRate = mutRate;
  }

  // public DNA(Matrix hiddenLayer, mutRate) {
  //  this.hiddenLayer = hiddenLayer;
  // }

  public DNA crossOver(DNA wife) {
    Matrix childHL = hiddenLayer.crossOver(wife.getHiddenLayer(), mutRate);
    Matrix childOL = outPutLayer.crossOver(wife.getOutPutLayer(), mutRate);
    return new DNA(childHL, childOL, mutRate);
  }

  public Matrix getHiddenLayer() {
    return hiddenLayer;
  }

  public Matrix getOutPutLayer() {
    return outPutLayer;
  }

  public void print() {
    System.out.println("HiddenLayer:");
    hiddenLayer.print();
    System.out.println("\nHiddenLayer2:");
    hiddenLayer2.print();
    System.out.println("\noutPutLayer:");
    outPutLayer.print();
    System.out.printf("\n\nPercent correct: %f\n", correct/total);
    System.out.printf("\nPercent correct Jumps: %f\n", (1 - correctJump/total));
    correct = 0;
    total = 0;
    correctJump = 0;
  }

  public void train(Matrix input, double target) {
    // System.out.printf("Input:\n");
    // input.print();
    // System.out.printf("HIdden layer:\n");
    // hiddenLayer.print();
    Matrix newI = hiddenLayer.multiply(input);
    // System.out.println("\n\nnewI:\n");
    // newI.sigFunc();
    // newI.print();
    Matrix newI2 = hiddenLayer2.multiply(newI);
    // newI2.sigFunc();
    // System.out.println("newI2:\n");
    // newI2.print();
    Matrix j = outPutLayer.multiply(newI2);
    // System.out.println("Final:\n");
    j.sigFunc();
    // j.print();
    double output = j.getElement(0,0);
    if (output <= 0) {
      output = 0.0;
    } else {
      output = 1;
    }
    // System.out.printf("Output: %f, Target: %f\n", output, target);
    if (output == 1 && target == 1) {
      correctJump++;
    }

    double error = (target - output);
    if (error == 0) {
      correct++;
      // System.out.println("Hoooorrraaayyy");
    }
    // System.out.printf("error: %f\n", error);
    // j.derSigFunc();
    // newI.derSigFunc();
    // newI2.derSigFunc();


    // newI.doubleMultiplication(error);
    // newI2.doubleMultiplication(error);
    // j.doubleMultiplication(error);

    // outPutLayer.elementAddition(j);
    // hiddenLayer2.elementAddition(newI2);
    // hiddenLayer.elementAddition(newI);
    total++;
  }

  public boolean getCorrectJumps() {
    if (correctJump/total >= 0.04) {
      return true;
    } else {
      return false;
    }
  }

  public double getNextMove(Matrix input) {
    // input.print();
    // hiddenLayer.print();
    Matrix newI = hiddenLayer.multiply(input);
    // newI.sigFunc();
    Matrix output = outPutLayer.multiply(newI);
    double o = output.getElement(0,0);
    // output.sigFunc();
    if (o >= 0) {
      o = 1.0;
    } else {
      o = 0;
    }
    // System.out.printf("Output %f\n", o);
    // o = o - 1;
    if (o > 0) {
      return 1.0;
    } else {
      return 0.0;
    }
  }
}