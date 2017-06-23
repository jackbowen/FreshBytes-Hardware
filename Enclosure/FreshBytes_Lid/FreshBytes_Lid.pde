import controlP5.*;

ControlP5 cp5;
MyControlListener redrawListener;

int frameWidth = 500;
int frameHeight = 700;

int controlX = 30;
int controlY = 20;
int controlInc = 30;

ArrayList<Agent> agents = new ArrayList<Agent>();
int agentNum = 40;

int frameStartX = 0;
int frameStartY = 0;
int minRadius = 20;
int maxRadius = 75;

void setup () {
  fullScreen();
  cp5 = new ControlP5(this);
  redrawListener = new MyControlListener();
  
  cp5.addSlider("frameWidth")
   .setPosition(controlX, controlY += controlInc)
   .setRange(400, 850)
   .setCaptionLabel("Frame Width")
   .addListener(redrawListener);
  
  cp5.addSlider("frameHeight")
   .setPosition(controlX, controlY += controlInc)
   .setRange(300, 800)
   .setCaptionLabel("Frame Height")
   .addListener(redrawListener);
  
  cp5.addSlider("minRadius")
   .setPosition(controlX, controlY += controlInc)
   .setRange(0, 50)
   .setCaptionLabel("Min Agent Radius")
   .addListener(redrawListener);
   
  cp5.addSlider("maxRadius")
   .setPosition(controlX, controlY += controlInc)
   .setRange(30, 200)
   .setCaptionLabel("Max AgentRadius")
   .addListener(redrawListener);
   
  cp5.addSlider("agentNum")
   .setPosition(controlX, controlY += controlInc)
   .setRange(10, 200)
   .setCaptionLabel("Number of Agents")
   .addListener(redrawListener);
   
  initializeSketch();
  
  background(0);
}

void draw() {
  background(0);
  
  updateAgents();
  drawAgents();
  
  drawFrame();
}

void initializeSketch() {
  frameStartX = width / 2 - frameWidth / 2;
  frameStartY = height / 2 - frameHeight / 2;
  agents.clear();
  populateAgents();
}

class MyControlListener implements ControlListener {
  public void controlEvent(ControlEvent theEvent) {
    initializeSketch();
  }
}

void drawFrame() {
  noStroke();
  fill(0);
  rect(0, 0, width, (height - frameHeight) / 2);
  rect(0, 0, (width - frameWidth) / 2, height);
  rect(0, frameHeight + ((height - frameHeight) / 2), width, (height - frameHeight) / 2);
  rect(frameWidth + ((width - frameWidth) / 2), 0, (width - frameWidth) / 2, height);
  
  stroke(255);
  noFill();
  rect(frameStartX, frameStartY, frameWidth, frameHeight);
}

class Agent {
  PVector pos;
  PVector vel;
  float radius;
  
  public Agent() {
    this.pos = new PVector(random(frameStartX, frameStartX + frameWidth), random(frameStartY, frameStartY + frameHeight));
    this.radius = random(minRadius, maxRadius);
    this.vel = new PVector(random(-1, 1), random(-1, 1));
  }
}

void updateAgents() {
  for (int i = 0; i < agents.size(); i++) {
    Agent tempAgent = agents.get(i);
    tempAgent.pos.add(tempAgent.vel);
  }
}

void drawAgents() {
  for (int i = 0; i < agents.size(); i++) {
    Agent tempAgent = agents.get(i);
    ellipse(tempAgent.pos.x, tempAgent.pos.y, tempAgent.radius, tempAgent.radius);
    
    //TODO: add overflow
    //if (agent.pos.x 
  }
}

void populateAgents() {
  for (int i = 0; i < agentNum; i++) {
    agents.add(new Agent());
  }
}