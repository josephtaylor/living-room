import java.util.List;
import processing.net.*;

Client client;

boolean recording = false;
List<PVector> points = new ArrayList<PVector>();

private final int NUM_POINTS = 1000;
private final int NUM_LINES = 100;

void setup() {
  size(800, 600);
  background(0);
  stroke(255,0,0);
  
  client = new Client(this, "10.1.10.103", 5002);
  
  PVector center = new PVector(width/2,height/2);
  float r = height/2.2;
  for (int i = 0; i < NUM_POINTS; i++) {
    float x = center.x + r * cos(TWO_PI * i / NUM_POINTS);
    float y = center.y + r * sin(TWO_PI * i / NUM_POINTS);
    PVector p = new PVector(x, y);
    points.add(p);
  }
}

void draw() {
  if (client.available() > 0) {
    String command = client.readString();
    if(command.contains("on")) {
      recording = true;
    } else if (command.contains("off")) {
      recording = false;
    } 
  }
  fill(0,0,0,20);
  rect(-1,-1,width+1,height+1);
  if (recording) {
    //ellipse(width/2,height/2,width/1.1,width/1.1);
    for(int i = 0; i < NUM_LINES; i++) {
      PVector a = points.get((int) random(points.size()));
      PVector b = points.get((int) random(points.size()));
      line(a.x, a.y, b.x, b.y);  
    }
  }
}
