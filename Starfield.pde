import java.util.*;

ArrayList<Star> stars = new ArrayList<Star>();
static int numStars = 300;
public Boolean isOddShown = true;

void setup() {
  size(800, 800);
  noStroke();
  
  stars.add(new OtherParticle());
  
  for(int i = 0; i < numStars; i++) {
    stars.add(new InitialStar());
  }
}

void draw() {
  background(0, 0, 0, 255);
  /*while (stars.size() < numStars) {
    stars.add(new Star());
  }*/
  stars.add(new NonInitialStar());
  
  
  for(int i = stars.size() - 1; i >= 0; i--) {
    Star tempStar = stars.get(i);
    if (tempStar.x + tempStar.size/2 > 0 && tempStar.x - tempStar.size/2 < width && tempStar.y + tempStar.size/2 > 0 && tempStar.x - tempStar.size/2 < height) {
      tempStar.step();
      tempStar.show();
    }
    else {
      stars.remove(i);
    }
  }
}

void mouseClicked() {
  isOddShown = !isOddShown;
}

public class Star {
  int distance;
  float x;
  float y;
  float direction;
  float velocity;
  float brightness;
  float size;
  boolean right;
  boolean up;
  
  Star() {
    distance = (int)(Math.random() * 100) + 1;
    direction = (float)(Math.random() * 2 * PI);
    velocity = (float)Math.cbrt(101 - distance) / 60;
    x = width/2 + velocity * ((int)(Math.random() * 300)) * cos(direction);
    y = height/2 + velocity * ((int)(Math.random() * 300) + 1) * sin(direction);
    brightness = 230 + 3 * sqrt(100 - distance);
    size = 0;
  }
  
  void step() {
    x += velocity * cos(direction);
    y += velocity * sin(direction);
    size += 0.04;
    velocity += 0.04;
  }
  
  void show() {
    fill(brightness);
    ellipse(x, y, size, size);
  }
}

public class InitialStar extends Star {
  public InitialStar() {
    super();
    size = 4;
    velocity = sqrt(101 - distance)/30;
  }
}
public class NonInitialStar extends Star {
  public NonInitialStar() {
    super();
  } 
}

public class OtherParticle extends Star {
  OtherParticle() {
    x = 400;
    y = 400;
  }
  
  void step() {
    x += (float)((Math.random() - 0.5) * 9);
    y += (float)((Math.random() - 0.5) * 9);
  }
  
  void show() {
    if (isOddShown) {
      fill(255);
      rect(x - 5, y - 5, 10, 10);
    }
  }
}
