//James Doyle - CS171 Final Project - December 2019
//Venus and Earth Orbit Simulation with interactivity

// cx and cy are the coordinates of the center of all the orbits
  int cx = 500;
  int cy = 500;

//Radius of the Earths orbit used to calculate other orbit radii
  float eRadius = 300; 
//Time taken by earth to perform one orbit, used to calculate other orbits
  float eTime = 500.0f;
//Radius of Venus' orbit
  float r2 = 217; 

//This variable is used to have the lines drawn a 
//certain distance apart from each other
  int count = 0;

//Initialise the intlists for the line coordinates
  IntList listx;
  IntList listy;
  IntList listx2;
  IntList listy2;

//Initialise the intlists for the star coordinates
  IntList starx;
  IntList stary;
//These variables choose the x and y points for the stars
  int ranx = 0;
  int rany = 0;
//These variables are used to draw the stars
  int sx = 0;
  int sy = 0;

//These variables are for the "Interactivity" button
  boolean interact = false;
  boolean clicked;
//x and y points for the button and its diameter
  int buttonx = 50;
  int buttony = 30;
  float buttonDiameter = 50;
//Colour of the button in 'off' state
  int rcol = 123;
  int gcol = 123;
  int bcol = 40;




void setup()
{

  size(1020, 1020);
  frameRate(60);
  
//New instances for the intlists for the line coordinates
  listx = new IntList();
  listy = new IntList();
  listx2 = new IntList();
  listy2= new IntList();
  
//Initialise the intlists for the star coordinates
 starx = new IntList();
 stary = new IntList();
  
//Pick 100 random x and y values and add them to 
//the inlists
  for(int i=0; i<100;i++){
    ranx = floor(random(width));
    rany = floor(random(height));
    starx.append(ranx);
    stary.append(rany);
  }
}






void draw()
{
  
//Set the background to black
  background(0);
  
//Draw the stars at the points chosen
  for(int i = 0;i<starx.size();i++){
    strokeWeight(2);
    stroke(255);
    sx = starx.get(i);
    sy = stary.get(i);
    point(sx,sy);
  } 
  
   
//Draw the text under the button
  fill(0);
  fill(255);
  textSize(18);
  text("Interactivity", 5, 80);
  
//Draw the button in the top corner
  noStroke();
  fill(rcol,gcol,bcol);
  ellipse(buttonx,buttony,buttonDiameter,buttonDiameter);
  
//Draw the Sun in the center
  stroke(0);
  fill(255,255,0);
  ellipse(cx,cy,50,50);
  stroke(255);
  
//t and t2 are the times taken for each
//'planet' to complete 1 orbit
  float t = millis()/eTime;
  float t2 = millis()/calculateTimePeriod(r2);

  
  
  
 //Below are the calculations used to move the planets in a circle path
 //Retrieved from https://processing.org/discourse/beta/num_1264000877.html
 
 int x = (int)(cx+eRadius*cos(t));
 int y = (int)(cy+eRadius*sin(t));

   
 int x2 = (int)(cx+r2*cos(t2));
 int y2 = (int)(cy+r2*sin(t2));

//Add each value to their respective intlist
  listx.append(x);
  listy.append(y);
  listx2.append(x2);
  listy2.append(y2);
  
//Draw Earth planet
  strokeWeight(0);
  fill(0,128,255);
  ellipse(x, y, 20,20);
  noFill();
  fill(0);
  strokeWeight(0);
  
//Draw Venus planet
  strokeWeight(0);
  fill(198, 140, 83);
  ellipse(x2, y2, 20,20);
  noFill();
  strokeWeight(1);
  
//Draw mapped Venus orbit
  ellipse(cx,cy,eRadius*2,eRadius*2);
  
//Draw mapped Earth orbit
  ellipse(cx,cy,r2*2,r2*2);
  
  
//This resets the stroke weight so
//that the planets and orbit paths arent
//affected by the change meant for the lines
  strokeWeight(1);
  
  
  
//This code create the spacing between the lines drawn
//and then redraws the lines every time the if condition is true
  count++; 
  for(int i = 0;i<listx.size();i++){
    
    if(count % 1 == 0){
      
   int x_ = listx.get(i);
   int y_ = listy.get(i);
   int x2_ = listx2.get(i);
   int y2_ = listy2.get(i);
    strokeWeight(0.1);
    line(x_,y_,x2_,y2_);

  }
  }
  
  
    
}




//This calculate the speed that the planet 
//should move around its orbit based on its 
//distance to the sun in the center
float calculateTimePeriod(float r1){
  float ratio = (r1)/(eRadius);
  float f = sqrt(pow(ratio,3.0));
   return(f*eTime);
}




//This code checks to see if the "Interactivity" button is 
//clicked so that the user can add another orbit
void mouseClicked(){
    if (clicked == false && circleHover(buttonx,buttony,buttonDiameter)== true) {
    clicked = true;
    rcol = 255;
    gcol = 255;
    bcol = 0;
    interact = true;
  }else{
    rcol = 123;
    gcol = 123;
    bcol = 40;
    clicked = false;
    interact = false;
  }
  
  
}

//if the mouse is pressed while "interact" is true,
//create a new orbit at the mouse position
void mousePressed(){
  if(interact == true){
    background(0);
  r2=sqrt(sq(mouseX-cx) +sq(mouseY-cy));
  
//Also clear the intlists so that the old pattern isnt drawn again
  listx.clear();
  listy.clear();
  listx2.clear();
  listy2.clear();
  }
  
}




//This code is to detect if the mouse is hovering over the button
//by getting the distance from the button to the mouse
boolean circleHover(int buttonx, int buttony, float buttonDiameter) {
  float disX = buttonx - mouseX;
  float disY = buttony - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < buttonDiameter/2 ) {
    return true;
  } else {
    return false;
  }
}
