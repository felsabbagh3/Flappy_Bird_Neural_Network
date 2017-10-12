import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Test {

	DNA dna;
	String fileName = "LTT.csv";
	BufferedReader fileReader = null;

	public Test() {
		this.dna = new DNA(0.0);
		this.open();
	}

	public void open() {
		try {
			fileReader = new BufferedReader(new FileReader(fileName));
		} catch (Exception e) {
			System.out.println("Could not Open file");
		}
	}

	public void startTesting() {
		try {
			int count = 0;
			String line = "";
			double[] input = new double[6];
			while ((line = fileReader.readLine()) != null) {
				String[] tokens = line.split(",");
				input = new double[6];
				for (int i = 0; i < tokens.length - 2; i++) {
					input[i] = (Double.parseDouble(tokens[i]) - 100) / 100;
				}
				input[tokens.length - 2] = Double.parseDouble(tokens[tokens.length - 2]) / 10;
				Matrix in = new Matrix(input);
				double target = Double.parseDouble(tokens[6]);
				// System.out.println("\n\nInput:");
				// in.print();
				dna.train(in, target);
				count++;
				// break;
			}
			// System.out.printf("Total is: %d\n",count);
		} catch (Exception e) {
			e.printStackTrace(System.out);
		}
		dna.print();
		if (!dna.getCorrectJumps()) {
			this.close();
			this.open();
			this.startTesting();
		}
	}

	public void close() {
	    try {
	        fileReader.close();
	    } catch (IOException e) {
	    	System.out.println("Error while closing fileReader !!!");
	        e.printStackTrace();
	    }
	}

	public static void main(String[] args) {
		Test t = new Test();
		t.startTesting();
		t.close();
	}
} 