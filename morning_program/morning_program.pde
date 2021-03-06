//import ddf.minim.*;

//Minim minim;
//AudioPlayer message;

int marker = -1;
float durration;
int pad = 20;
int times = 15;
float time[] = new float[times];
String words[] = new String[times];
int change = -1;
int repeat = -1;

PFont font;

void setup(){
  size(963,513);
  
  //minim = new Minim(this);
  
  time[0] = 0; words[0] = "Wake up and\nget to kitchen";
  time[1] = 5; words[1] = "Drink breakfast/coffee";

  time[2] = 10; words[2] = "Get to the shower";
  time[3] = 12; words[3] = "Start and enter\nthe shower";
  time[4] = 14; words[4] = "Use the amber\nbar soap";
  time[5] = 16; words[5] = "Rinse off";
  time[6] = 18; words[6] = "Turn the water\noff and dry";
  time[7] = 20; words[7] = "Get to the kitchen";
  time[8] = 22; words[8] = "Get dressed and\napply deodorant";
  time[9] = 27; words[9] = "Mess with face";
  time[10] = 33; words[10] = "Mess with hair";
  time[11] = 40; words[11] = "Brush teeth ready";
  time[12] = 41; words[12] = "Brush teeth start";
  time[13] = 44; words[13] = "Brush teeth end";
  time[14] = 45; words[14] = "get: folders, laptop,\ncharger, phone, lunch,\ndrink, else"; 
  
  durration = floor(time[times-1]+1);
  
  
  font = loadFont("Monospaced.bold-48.vlw");
  
  
}
  
void draw(){
  
  if(lastPoint(marker) != change){
    change = lastPoint(marker);
    repeat = 10;
    
  }
  
  if(repeat == 10 || repeat == 5 || repeat == 0){
    //message = minim.loadFile("http://interactivecomputing2013.globalblogs.org/files/2013/10/boing.mp3");//change+".mp3");
    //message = minim.loadFile("http://radiotech.github.io/Morning/morning_program/data/"+change+".mp3");
    
    //message.play();
  }
  if(repeat > -1){
    repeat-=1;
  }
  
  if(marker==-1){
    frameRate(1);
  }
  
  if(marker<durration*60){
    marker++;
  }
  
  background(0);
  strokeWeight(2);
  noFill();
  stroke(255);
  rect(2,2,width-5,height-5);
  strokeWeight(pad/10);
  stroke(255);
  line(pad,height-pad,width-pad,height-pad);
  line(pad+float(marker)/60*(width-pad*2)/durration,height-pad*.75,pad+float(marker)/60*(width-pad*2)/durration,height-pad*1.25);
  noStroke();
  fill(255);
  
  for(int i = 0; i < times; i++){
    ellipse(pad+time[i]*(width-pad*2)/durration,height-pad,pad/4,pad/4);
  }
  
  if(marker<time[times-1]*60){
    rect(pad,height-pad*2.5,(marker-time[lastPoint(marker)]*60)*(width-pad*2)/(time[lastPoint(marker)+1]*60-time[lastPoint(marker)]*60),pad/2);
  }
  
  textFont(font, 70);
  textAlign(CENTER,CENTER);
  text(words[lastPoint(marker)],width/2,height/2);
  
  textFont(font, 48);
  textAlign(LEFT);
  if(marker%60<10){
    text("0"+marker%60,width-width/10+pad/4,height/10);
  } else {
    text(marker%60,width-width/10+pad/4,height/10);
  }
  textAlign(RIGHT);
  text(floor(marker/60),width-width/10-pad/4,height/10);
  textAlign(CENTER);
  text(":",width-width/10,height/10);
}

int lastPoint(int position){
  for(int i = 0; i < times; i++){
    if(time[i]>position/60) {
      return i-1;
    }
  }
  if(position/60>=time[times-1]){
    return times-1;
  } else {
    return 0;
  }
  
  
}

void mousePressed(){
  if(mouseX>width*.75){
    next();
  }
  if(mouseX<width*.25){
    back();
  }
}

void next(){
  marker = ceil(60*time[median(lastPoint(marker)+1,0,times-1)]);
}

void back(){
  marker = ceil(60*time[median(lastPoint(marker-10),0,times-1)]);
}

int median(int a, int b, int c){
  if(a>=b && a>=c){
    if(b>=c){
      return b;
    } else {
      return c;
    }
  } else if(b>=a && b>=c){
    if(a>=c){
      return a;
    } else {
      return c;
    }
  } else if(c>=a && c>=b){
    if(a>=b){
      return a;
    } else {
      return b;
    }
  }
  return 0;
}

