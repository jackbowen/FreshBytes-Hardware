import controlP5.*;

ControlP5 cp5;
MyControlListener redrawListener;

// Initial size of the frame in which the drawing is actually done
int frameWidth = 500;
int frameHeight = 700;
// These will be coordinates for where to draw the frame.
// They will be calculated in the drawFrame function
int frameStartX = 0;
int frameStartY = 0;

// These control the position of the UI elements
int controlX = 30;
int controlY = 20;
int controlInc = 30;

// These are the basic agents that are drawing is based off of
ArrayList<Agent> agents = new ArrayList<Agent>();
int agentNum = 40;

// Min and max diameters of the agents
int mindiameter = 20;
int maxdiameter = 75;

// Controls how much the agents will wander
float noiseInc = .01;
float noiseScale = .1;

// Sometimes when we make changes to the UI, we'll want to wipe the background of the sketch
boolean wipeSketch = false;

// Display the process driving the sketh's behavior
boolean displayProcess = false;



void setup () {
  fullScreen();
  
  // cp5 is our UI
  cp5 = new ControlP5(this);
  
  // Listens for changes in the UI
  redrawListener = new MyControlListener();
  
  final int MIN_WIDTH = 400;
  final int MAX_WIDTH = width - 450;
  cp5.addSlider("frameWidth")
   .setPosition(controlX, controlY += controlInc)
   .setRange(MIN_WIDTH, MAX_WIDTH)
   .setCaptionLabel("Frame Width")
   .addListener(redrawListener);
  
  final int MIN_HEIGHT = 300;
  final int MAX_HEIGHT = height - 100;
  cp5.addSlider("frameHeight")
   .setPosition(controlX, controlY += controlInc)
   .setRange(MIN_HEIGHT, MAX_HEIGHT)
   .setCaptionLabel("Frame Height")
   .addListener(redrawListener);
  
  cp5.addSlider("mindiameter")
   .setPosition(controlX, controlY += controlInc)
   .setRange(0, 50)
   .setCaptionLabel("Min Agent diameter")
   .addListener(redrawListener);
   
  cp5.addSlider("maxdiameter")
   .setPosition(controlX, controlY += controlInc)
   .setRange(30, 200)
   .setCaptionLabel("Max Agent diameter")
   .addListener(redrawListener);
   
  cp5.addSlider("agentNum")
   .setPosition(controlX, controlY += controlInc)
   .setRange(10, 200)
   .setCaptionLabel("Number of Agents")
   .addListener(redrawListener);
   
  cp5.addSlider("noiseInc")
   .setPosition(controlX, controlY += controlInc)
   .setRange(.001, 1)
   .setCaptionLabel("Noise")
   .addListener(redrawListener);
  
  cp5.addSlider("noiseScale")
   .setPosition(controlX, controlY += controlInc)
   .setRange(.01, 1)
   .setCaptionLabel("Wander")
   .addListener(redrawListener);
   
  cp5.addToggle("displayProcess")
   .setPosition(controlX, controlY += controlInc)
   .setCaptionLabel("Display Process")
   .addListener(redrawListener);
   
  initializeSketch();
  
  background(0);
}




void initializeSketch() {
  drawFrame();
  agents.clear();
  populateAgents();
  wipeSketch = false;
}





// Draws the frame around the actual sketch. 
// Also fills in the border surrounding the sketch to cover up and overflow
void drawFrame() {
  noStroke();
  fill(75);
  rect(0, 0, width, (height - frameHeight) / 2);
  rect(0, 0, (width - frameWidth) / 2, height);
  rect(0, frameHeight + ((height - frameHeight) / 2), width, (height - frameHeight) / 2);
  rect(frameWidth + ((width - frameWidth) / 2), 0, (width - frameWidth) / 2, height);
  
  
  stroke(255);
  noFill();
  if(wipeSketch) {
    fill(0);
  }
  frameStartX = width / 2 - frameWidth / 2;
  frameStartY = height / 2 - frameHeight / 2;
  rect(frameStartX, frameStartY, frameWidth, frameHeight);
}


// 
void populateAgents() {
  for (int i = 0; i < agentNum; i++) {
    agents.add(new Agent());
  }
}


void draw() {
  if (displayProcess) {
    background(0);
  }
  
  if (wipeSketch) {
    initializeSketch();
  }
  
  updateAgents();
  //drawAgents();
  drawProcess();
  
  drawFrame();
}



class MyControlListener implements ControlListener {
  public void controlEvent(ControlEvent theEvent) {
    //initializeSketch();
    wipeSketch = true;
  }
}





void drawAgents() {  
  stroke(255, 1);
  for (int i = 0; i < agents.size(); i++) {
    Agent tempAgent = agents.get(i);
    ellipse(tempAgent.pos.x, tempAgent.pos.y, tempAgent.diameter, tempAgent.diameter);
  }
  stroke(255);
}

void drawProcess() {
  //stroke(255, 190);
  for (int i = 0; i < agents.size(); i++) {
    Agent agent = agents.get(i);
    for (int j = 0; j < agents.size(); j++) {
      Agent tempAgent = agents.get(j);
      if (tempAgent != agent && dist(agent.pos.x, agent.pos.y, tempAgent.pos.x, tempAgent.pos.y) < (tempAgent.diameter + agent.diameter)/2) {
        stroke(255, 3);
        strokeWeight(3);
        line(agent.pos.x, agent.pos.y, tempAgent.pos.x, tempAgent.pos.y);
      }
    }
  }
  stroke(255);
}