public class DNA {
	Matrix hiddenLayer;
	Matrix outPutLayer;
	double mutRate;
	public DNA(double mutRate) {
		this.hiddenLayer = new Matrix(5,5);
		this.outPutLayer = new Matrix(1,5);
		this.mutRate = mutRate;
	}

	public DNA(Matrix hiddenLayer, Matrix outPutLayer,double mutRate) {
		this.hiddenLayer = hiddenLayer;
		this.outPutLayer = outPutLayer;
		this.mutRate = mutRate;
	}

  public DNA(double[][] hl, double[][] ol, double mutRate) {
    this.mutRate = mutRate;
    this.hiddenLayer = new Matrix(hl, 6,6);
    this.outPutLayer = new Matrix(ol, 1,6);
  }

	// public DNA(Matrix hiddenLayer, mutRate) {
	// 	this.hiddenLayer = hiddenLayer;
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
		System.out.println("\noutPutLayer:");
		outPutLayer.print();
	}

	public int getNextMove(Matrix input) {
		Matrix newI = hiddenLayer.multiply(input);
		newI.sigFunc();
		Matrix output = outPutLayer.multiply(newI);
		output.sigFunc();
		return (int) output.getElement(0,0);
	}
}