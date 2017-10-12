import java.util.Random;
public class Matrix {
  double[][] values;
  int m; // this is y
  int n; // this is x
  Random rand = new Random();
  public Matrix(int m, int n) {
    this.m = m;
    this.n = n;
    values = new double[m][n];
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        values[y][x] = ((rand.nextDouble() * 100) - 50);
      }
    }
    // this.sigFunc();
  }

  public Matrix(double[][] values,int m,int n) {
    this.values = values;
    this.m = m;
    this.n = n;
  }

  public Matrix(double[] arr) {
    this.m = arr.length;
    this.n = 1;
    values = new double[m][n];
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        values[y][x] = (arr[y] - 50); // To normalize values between -50 and 50
      }
    }
  }

  public int getM() {
    return m;
  }

  public int getN() {
    return n;
  }


  public Matrix multiply(Matrix other) {
    if (n == other.getM()) {
      double result[][] = new double[m][other.getN()];
      for (int x2 = 0; x2 < other.getN(); x2++) {
        for (int y1 = 0; y1 < m; y1++) {
          double temp = 0;
          for (int i = 0; i < n; i++) {
            temp = temp + ((values[y1][i]) * other.getElement(i, x2));
          }
          result[y1][x2] = temp;
        }
      }
      return new Matrix(result, m, other.getN());
    }
    return null;
  }
  
  public void sigFunc() {
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        values[y][x] = (2.0/(1.0 + Math.exp(values[y][x]))) - 1;
      }
    }
  }

  public double sigFunc(double v) {
    return (2.0/(1.0 + Math.exp(v))) - 1;
  }

  public double getElement(int y, int x) {
    return values[y][x];
  }

  public void print() {
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        System.out.printf("%f  ", values[y][x]);
      }
      System.out.printf("\n");
    }
  }



  public Matrix crossOver(Matrix other, double mutRate) {
    double[][] childMatrix = new double[m][n];
    for (int y = 0; y < m; y++) {
      for (int x = 0; x < n; x++) {
        if (rand.nextDouble() > 0.5) {
          childMatrix[y][x] = values[y][x];
        } else {
          childMatrix[y][x] = other.getElement(y,x);
        }
        if ((rand.nextDouble()*100) < mutRate) {
          // childMatrix[y][x] = sigFunc((rand.nextDouble() * 100) - 50);
          childMatrix[y][x] = ((rand.nextDouble() * 100) - 50);
        }
      }
    }

    return new Matrix(childMatrix, m, n);
  }



}