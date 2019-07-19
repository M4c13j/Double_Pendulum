int l1 = 200;
int l2 = 200;
int m1 = 20;
int m2 = 40;
float teta1 = PI/2;
float teta2 = PI/4;

float teta1_v = 0;
float teta2_v = 0;
float g = 2;
float cx,cy;
float smugax = -1;
float smugay = -1;

float szybkosc = 1; // 1 - bez strat energii , im mniej tym więcej

PGraphics plansza;

void setup() {
  size(900, 900); 
  cx = width/2;
  cy = (l1+l1)*1.1;
  plansza = createGraphics(width, height);
  plansza.beginDraw();
  plansza.background(255);
  plansza.endDraw();
}

void draw() {
  background(255);
  imageMode(CORNER);
  image(plansza, 0, 0, width, height);
  
  float dziel1 = l1*(2*m1+m2-m2*cos(2*teta1-2*teta2));
  float cz1 = -g*(2*m1+m2)*sin(teta1);
  float cz2 = -m2*g*sin(teta1-2*teta2);
  float cz3 = -2*sin(teta1-teta2)*m2;
  float cz4 = teta2_v*teta2_v*l2+teta1_v*teta1_v*l1*cos(teta1-teta2);
  float nteta1 = (cz1+cz2+cz3*cz4) / dziel1;
  
  cz1 = 2*sin(teta1-teta2);
  cz2 = teta1_v*teta1_v*l1*(m1+m2);
  cz3 = g*(m1+m2)*cos(teta1);
  cz4 = teta2_v*teta2_v*l2*m2*cos(teta1-teta2);
  float dziel2 = l2*(2*m1+m2-m2*cos(2*teta1-2*teta2));
  float nteta2 = cz1*(cz2+cz3+cz4) / dziel2;
  
  translate(cx, cy);
  stroke(0);
  strokeWeight(2);
  
  float x1 = l1*sin(teta1);
  float y1 = l1*cos(teta1);
  
  float x2 = x1+l2*sin(teta2);
  float y2 = y1+l2*cos(teta2);
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);
  
  teta1_v += nteta1;
  teta2_v += nteta2;
  teta1 += teta1_v;
  teta2 += teta2_v;
  
  teta1_v*= szybkosc;
  teta2_v*= szybkosc;
  
  plansza.beginDraw();
  plansza.translate(cx, cy);
  plansza.stroke(0);
  if (frameCount > 1) {
    plansza.line(smugax, smugay, x2, y2);
  }
  
  plansza.endDraw();
  smugax = x2;
  smugay = y2;
}
