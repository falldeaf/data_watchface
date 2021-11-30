PImage logoimg;
PFont font;
int font_size = 42;

void setup() {
  size(320, 320);
  logoimg = loadImage("leaf.png", "png");
  
  font = createFont("blackout.ttf", 42);
  textFont(font, font_size);
}

void draw() {
  background(0);
  
  noFill();
  //stroke(150);
  
  int ring_width_total = 30;
  int total_rings = 4;
  float ring_width = ring_width_total/total_rings;
  strokeWeight(ring_width);
  for (int i = 0; i < total_rings; i = i+1) {
    float percent = 1;
    stroke(unhex("FF0000FF"));
    arc(width/2, height/2, width-(i*ring_width*3)-ring_width, height-(i*ring_width*3)-ring_width, 0, PI*2*percent);  
  }
  
  stroke(unhex("FFDDDDDD"));
  strokeWeight(8);
  line(width/2-10, height*0.2, width/2-10, height*0.8);
  
  image(logoimg, width/5.2, height/2.4);
  
  fill(unhex("FFFF0000"));
  
  //textSize(24);
  textAlign(LEFT);
  for (int i = 0; i < 4; i = i+1) {
    text("WL900", width/2, height/2.75+(i*font_size));
  }
  
  int h = hour();
  String hour12 = "";
  if (h >12) {
    hour12 = str(h-12);
  } else {
    hour12 = str(h);
  }
   
  String time = hour12 + ":" + nf(minute(), 2);
  textAlign(RIGHT);
  text(time, width/2.3, height/2.5);
}
