float scale=2;

int year=1597;
int month=0;
String m="";

float g=2*scale;

int pt = 0; //pixels traveled

float gl;

int wx=0;
int tx=0;

float when=0;

float ws=5*scale;

boolean[] keys = new boolean[4];

Player c;

float txx=0;

PImage img;

ArrayList<Sword> swords = new ArrayList<Sword>();


void setup() {
  fullScreen();
  gl=height-(200)*scale;
  c=new Player(width/2,0,42*scale);
  
  img=loadImage("Sword.png");
  
  swords.add(new Sword());
}

void draw() {
  
  txx=-ws;
  
  if(tx>365) {
    tx=0;
    month++;
  }
  if(month>11) {
    month=0;
    year++;
    when=255;
  }
  
  if(when>0) {
    when-=2;  
  }
  
  switch(month) {
    case 0:
      m="January";
    break;
    case 1:
      m="February";  
    break;
    case 2:
      m="March";
    break;
    case 3:
      m="April"; 
    break;
    case 4:
      m="May";
    break;
    case 5:
      m="June"; 
    break;
    case 6:
      m="July";  
    break;
    case 7:
      m="August"; 
    break;
    case 8:
      m="September";  
    break;
    case 9:
      m="October";  
    break;
    case 10:
      m="November";  
    break;
    case 11:
      m="December";  
    break;
  }
  
  //gl+=random(-10,10);
  wx+=ws;
  tx+=ws;
  
  if(c.x>width/2) {
    c.x-=ws;
    wx+=ws;
    tx+=ws;
  }
  
  if(c.x<width/2) {
    //c.x+=ws;
    //wx-=ws;
  }
  
  background(0,0,240);
  fill(0);
  line(width-wx,height,width-wx,0);
  textSize(42*scale);
  text(year,width/2-45*scale,42*scale);
  fill(80);
  textSize(22*scale);
  text(m,width/2-38*scale,60*scale);
  fill(100);
  rect(0,gl,width,height);
  
  
  
  fill(0,0,240-when);
  switch(year) {
    case 1598:
      text("Japan's invasion with Korea ends.",width/2-160*scale,height/2-52*scale);  
    break;
    case 1603:
      text("The Edo period starts and samurias begin.",width/2-220*scale,height/2-52*scale);  
    break;
  }
  noTint();
  
  c.d();
  c.u();
  c.m();
  
  for(Sword sword : swords) {
    sword.d();  
  }
}

class Player {
  float x;
  float y;
  float s;
  float xs;
  float ys;
  float mxs=10*scale;
  int j=0;
  float health;

  Player(float xx, float yy, float size) {
    x=xx;
    y=yy;
    s=size;
  }
  
  void d() {
    fill(0);
    rect(x,y,s,s);
  }
  
  void u() {
    if(x+s>width) {
      x=width-s;
    }
    if(x<0) {
      x=0;
    }
    
    x+=xs*scale;
    y+=ys*scale;
    
    xs/=1.1;
    
    if(y+s>gl) {
      j=0;
      ys=0;
      y=gl-s;    
    }
    else {
      ys+=g;  
    }
    
    if(xs>mxs) {
      xs--;  
    }
    if(xs<-mxs) {
      xs++;
    }
    
    for(Sword sword : swords) {
      if(x>sword.x && x<(sword.x+s) && y>sword.y) {
        background(255,0,0);
        //stop();
      }
    }
  }
  
  void m() {
    if(keys[0]) {
      xs--;
    }
    if(keys[1]) {
      xs++;
    }
    if(keys[2]) {
      jump();
    }
    if(keys[3]) {
      ys++;
    }
  }

  void jump() {
    if(j<1) {
      ys-=g*15;  
    }
    j++;      
  }
}

void keyPressed() {
  switch(key) {
    case 'a':
      keys[0]=true;  
    break;
    case 'd':
      keys[1]=true;
    break;
    case 'w':
      keys[2]=true;
    break;
    case 's':
      keys[3]=true;
    break;
  }  
}

void keyReleased() {
  switch(key) {
    case 'a':
      keys[0]=false;  
    break;
    case 'd':
      keys[1]=false;
    break;
    case 'w':
      keys[2]=false;
    break;
    case 's':
      keys[3]=false;
    break;
  }
}

class Sword {
  int x;
  int y;
  int s;
  Sword() {
    x=width;
    s=30;
    y=round(gl-s*4.7);
  }
  
  void d() {
    image(img,x,y,s,s*6.64);  
    
    if(x<-20) {
      if(random(0,1)>0.98) {
        x=width;  
      }
    }
    x+=txx;  
  }
}