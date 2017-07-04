class Agent {
  // Position of agent
  PVector pos;
  
  // Velocity of agent
  PVector vel;
  
  // Diameter of agent
  float diameter;
  
  // These will be used to allow the agents to wander in nonlinear paths
  float xNoise;
  float yNoise;
  
  public Agent() {
    this.pos = new PVector(random(frameStartX, frameStartX + frameWidth), random(frameStartY, frameStartY + frameHeight));
    this.diameter = random(mindiameter, maxdiameter);
    this.vel = new PVector(random(-1, 1), random(-1, 1));
    
    this.xNoise = random(1000);
    this.yNoise = random(1000);
  }
}



void updateAgents() {
  for (int i = 0; i < agents.size(); i++) {
    Agent tempAgent = agents.get(i);
    
    // Wander
    tempAgent.xNoise += noiseInc;
    tempAgent.yNoise += noiseInc;
    
    PVector accel = new PVector((noise(tempAgent.xNoise)-.5)*noiseScale, (noise(tempAgent.yNoise)-.5)*noiseScale);
    tempAgent.vel.add(accel);
    tempAgent.vel.normalize();
    
    tempAgent.pos.add(tempAgent.vel);
    
    // Overflow. If the agent exits the bounds of the frame, have it enter again from the opposite side
    overflow(tempAgent);
  }
}

void overflow(Agent agent) {
  int borderLeft = frameStartX;
  int borderRight = frameStartX + frameWidth;
  int borderTop = frameStartY;
  int borderBottom = frameStartY + frameHeight;
  float radius = agent.diameter / 2;
    
  if (agent.pos.x > borderRight + radius && agent.vel.x >= 0) {
    agent.pos.x = borderLeft - radius;
  }
  if (agent.pos.x < borderLeft - radius && agent.vel.x < 0) {
    agent.pos.x = borderRight + radius;
  }
  if (agent.pos.y > borderBottom + radius && agent.vel.y >= 0) {
    agent.pos.y = borderTop - radius;
  }
  if (agent.pos.y < borderTop - radius && agent.vel.y < 0) {
    agent.pos.y = borderBottom + radius;
  }
}