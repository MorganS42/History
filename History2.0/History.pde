float scale=1;

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
ArrayList<Bug> bugs = new ArrayList<Bug>();
ArrayList<Food> food = new ArrayList<Food>();

boolean dead=false;

boolean ear = false;

PImage img2; 

void setup() {
  fullScreen();
  gl=height-(200)*scale;
  c=new Player(width/2,0,42*scale);
  
  img=loadImage("Sword.png");
  img2=loadImage("burger.png");
  swords.add(new Sword());
}

void draw() {  
  if(dead) {
    background(255,0,0);
    textSize(32);
    text("You're Dead!", width/2-100,height/2-32);
  }
  else {
    dd();  
  }
}

void dd() {
  txx=-ws;
  
  if(tx>365) {
    tx=0;
    month++;
  }
  if(month>11) {
    month=0;
    year++;
    if(year>1900) {
      bugs.add(new Bug());
      food.add(new Food());
    }
    else {
      swords.add(new Sword());  
    }
    when=500;
  }
  
  if(when>=0) {
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
    for(Sword sword : swords) {
      sword.x-=ws;  
    }
  }
  
  if(c.x<width/2) {
    //c.x+=ws;
    //wx-=ws;
  }
  
  background(0,0,240);
  fill(255);
  //line(width-wx,height,width-wx,0);
  textSize(42*scale);
  text(year,width/2-45*scale,42*scale);
  fill(180);
  textSize(22*scale);
  text(m,width/2-38*scale,60*scale);
  fill(100);
  rect(0,gl,width,height);
  
  
  
  fill(when,when,255-when);
  switch(year) {
    case 1598:
      text("Japan's invasion with Korea ends.",width/2-160*scale,height/2-52*scale);  
    break;
    case 1603:
      text("The Edo period starts and samurais begin.",width/2-220*scale,height/2-52*scale);  
    break;
    case 1605:
      text("Japan has an earthquake and tsunami!",width/2-220*scale,height/2-52*scale);
      ear=true;
    break;
    case 1606:
      ear=false;
    break;
    case 1609:
      text("Japan invades Ryukyu, and they fight.",width/2-220*scale,height/2-52*scale);
    break;
    case 1611:
      text("Japan has another earthquake and tsunami!",width/2-220*scale,height/2-52*scale);
      ear=true;
    break;
    case 1612:
      ear=false;
    break;
    case 1613:
      text("Time skips 350 years! You're a programming trying to escape glitches.",width/2-350*scale,height/2-52*scale);
      year+=350;
    break;
  }
  noTint();
  
  if(ear) {
    gl+=random(-5,5);  
  }
  
  c.d();
  c.u();
  c.m();
  
  for(Sword sword : swords) {
    sword.d();  
  }
  for(Bug bug : bugs) {
    bug.d();  
  }  
  for(Food fo : food) {
    fo.d();  
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
  float health=100;

  boolean c=false;

  Player(float xx, float yy, float size) {
    x=xx;
    y=yy;
    s=size;
  }
  
  void d() {
    fill(0);
    if(c==true) {
      fill(100,0,0);  
    }
    rect(x,y,s,s);
    
    textSize(20*scale);
    text("Health: "+health,10*scale,30*scale);
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
    
    if(health<1) {
      dead=true;  
    }
    
    for(Sword sword : swords) {
      if(x+s>sword.x && x<sword.x && y+s>sword.y) {
        c=true;
        health-=2.5;
      }
      else {
        c=false;  
      }
    }
    
    for(Bug bug : bugs) {
      if(x+s>bug.x && x<bug.x && y+s>bug.y) {
      c=true;
        health-=4;
      }
      else {
        c=false;  
      }
    }
    
    for(Food fo : food) {
      if(x+s>fo.x && x<fo.x && y+s>fo.y) {
        health+=8;
        fo.x=-width;
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
    s=15*round(scale);
  }
  
  void d() {
    y=round(gl-s*4.7);
    image(img,x,y,s,s*6.64);  
    
    if(x<-s*scale) {
      if(round(random(0,year/2))==1) {
        x=width;  
      }
    }
    x-=ws;  
    
    if(year>1900) {
      x=-s*5;  
    }
  }
}

class Bug {
  int x;
  int y;
  int s;
  Bug() {
    x=-width;
    s=60*round(scale);
  }  
  
  void d() {
    y=round(gl-s*0.2);
    fill(0,180,0);
    textSize(s);
    text(round(random(0,1)),x,y); 
    
    if(x<-s*scale) {
      if(round(random(0,year/2))==1) {
        x=width;  
      }
    }
    x-=ws;
  }
}

class Food {
  int x;
  int y;
  int s;
  Food() {
    x=-width;
    s=90*round(scale);
  }    
  
  void d() {
    y=round(gl-s*2.5);
    image(img2,x,y,s,s);  
    
    if(x<-s*scale) {
      if(round(random(0,year/2))==1) {
        x=width;  
      }
    }
    x-=ws;
  }
}