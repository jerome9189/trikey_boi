import java.awt.Point;
import java.util.*;

Trike trikey;
//Obstacle collision;
Obstacle[] o;
void setup() {
  size(1024,650);
  background(255);
  trikey = new Trike();
  o = new Obstacle[3];
  for(int i = 0; i < o.length; i++) {
    o[i] = new Obstacle();
  }
  //collision = new Obstacle(width/2 - 20, 100, 60, 60);
  println(trikey.getPos());
}

void draw() {
  
  trikey.display();
  for(int i = 0; i < o.length; i++) {
    o[i].display();
  }
  //collision.display();
}

void mouseClicked() {
  
  background(255);
  trikey.update(0, 30);
  //List<Point> edgePoints = new ArrayList<Point>();

  for(int i = 0; i < o.length; i++) {
    int xPos = o[i].getX();
    int yPos = o[i].getY();
    int oWidth = o[i].getWidth();
    int oHeight = o[i].getHeight();
    List<Point> edgePoints = new ArrayList<Point>();
    //bottom edge
    for(int x = xPos; x < xPos + oWidth; x++) {
      edgePoints.add(new Point(x, yPos + oHeight));
    }
    //left edge and right edge
    for(int y = yPos; y < yPos + oHeight; y++) {
      edgePoints.add(new Point(xPos, y));
      edgePoints.add(new Point(xPos + oWidth, y));
    }
    //println(edgePoints.size());
    List<Float> slopes = calculateSlopes(edgePoints, trikey.getPos()[0], trikey.getPos()[1]);
    //println((edgePoints.get(0).getY() - yPos) + " " + (edgePoints.get(0).getX() - xPos));
    //Float slope = new Float((float)(edgePoints.get(0).getY() - yPos)/((float)edgePoints.get(0).getX() - xPos));
    //println(slope);
    println(slopes);
    
  }
  //println(trikey.getPos());
}

List<Float> calculateSlopes(List<Point> edgePoints, int xPos, int yPos) {
  List<Float> slopes = new ArrayList<Float>();
  for(Point p : edgePoints) {
    slopes.add(new Float((float)(p.getY() - yPos)/(p.getX() - xPos)));
    
  }
  //println(slopes);
  return slopes;
}

void keyPressed() {
  
  background(255);
  trikey.update(0, 30);
  println(trikey.getPos());
}

class Trike {
  int xPos, yPos;
  int sonarRange;
  PVector direction;
  Trike() {
    this(width/2, height - 80, new PVector(1,1).normalize(), 800);
  }
  Trike(int x, int y, PVector dir, int range) {
    xPos = x;
    yPos = y;
    direction = dir;
    sonarRange = range;
  }
  void display() {
    fill(#FFA500);
    rect(xPos - 20, yPos, 40, 100);
    fill(#ff0000);
    ellipse(xPos, yPos, 10,10);
    noFill();
    arc(xPos, yPos, sonarRange, sonarRange, -PI, 0);
    for(int i = 0; i < 8; i++) {
      line(xPos, yPos, xPos + cos(i*PI/7)*sonarRange/2, yPos - sin(i*PI/7)*sonarRange/2);
    }
  }
  
  void update(int x, int y) {
    xPos += x;
    yPos -= y;
  }
  
  int[] getPos() {
    return new int[] {xPos, yPos};
  }
}

class Obstacle {
  int xPos, yPos, oWidth, oHeight;
  
  Obstacle() {
    this((int)random(1024),(int) random(500), 30, 30);
  }
  Obstacle(int x, int y, int oWidth, int oHeight) {
    xPos = x;
    yPos = y;
    this.oWidth = oWidth;
    this.oHeight = oHeight;
  }
  
  void display() {
    fill(0);
    rect(xPos, yPos, oWidth, oHeight);
  }
  
  int getX() {
    return xPos;
  }
  
  int getY() {
    return yPos;
  }
  
  int getWidth() {
    return oWidth;
  }
  
  int getHeight() {
    return oHeight;
  }
}
