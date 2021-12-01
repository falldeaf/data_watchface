PImage logoimg;
PFont font;
int font_size = 42;
String pcolor = "FF00FF00";
JSONArray settings_json = new JSONArray();
JSONArray progress_json = new JSONArray();

void setup() {
  //fullScreen();
  frameRate(1);
  size(360, 360);
  logoimg = loadImage("leaf.png", "png");
  
  font = createFont("blackout.ttf", 42);
  textFont(font, font_size);
}

void draw() {
  background(0);
  
  noFill();
  //stroke(150);
  
  int ring_width_total = 40;
  int total_rings = progress_json.size();

  for (int i = 0; i < total_rings; i = i+1) {
    float ring_width = ring_width_total/total_rings;
    strokeWeight(ring_width);
    JSONObject progress_obj = progress_json.getJSONObject(i);
    float prog = float(progress_obj.getString("percent"));
    String rcolor = progress_obj.getString("color");
    float percent = prog/100;
    stroke(unhex("FF" + rcolor));
    arc(width/2, height/2, width-(i*ring_width*3)-ring_width, height-(i*ring_width*3)-ring_width, 0, PI*2*percent);  
  }
  
  stroke(unhex("FFDDDDDD"));
  strokeWeight(8);
  line(width/2-10, height*0.2, width/2-10, height*0.8);
  
  image(logoimg, width/5.2, height/2.4);
  
  ////FONT COLOR////////
  fill(unhex("FF" + pcolor));
  
  //textSize(24);
  textAlign(LEFT);
  //for (int i = 0; i < settings_json.size(); i++) {
  
  for (int i = 0; i < settings_json.size(); i++) {
    JSONObject settings_obj = settings_json.getJSONObject(i);
    String name = settings_obj.getString("name");
    String value = settings_obj.getString("hex");
    text(name.charAt(0) + value, width/2, height/2.75+(i*font_size));
  }
    
  int h = hour();
  String hour12 = "";
  if (h >12) {
    hour12 = str(h-12);
  } else {
    hour12 = str(h);
  }
   
  String time = hour12 + ":" + nf(minute(), 2);// + ":" + nf(second(), 2);
  textAlign(RIGHT);
  text(time, width/2.3, height/2.5);
  
  // Every 30 frames request new data
  if (frameCount % 5 == 0) {
    thread("requestData");
  }
}

void requestData() {
  JSONObject color_json = loadJSONObject("https://falldeaf.xyz/getsetting/HVaMfGkqxUUx7JMQ5QK5uQ2RrXxN4fLxwLwbwCzd/primary_color");
  pcolor = color_json.getString("hex");
  
  settings_json = loadJSONArray("https://falldeaf.xyz/getbytag/HVaMfGkqxUUx7JMQ5QK5uQ2RrXxN4fLxwLwbwCzd/watch");
  progress_json = loadJSONArray("https://falldeaf.xyz/getprogress/HVaMfGkqxUUx7JMQ5QK5uQ2RrXxN4fLxwLwbwCzd");
}
