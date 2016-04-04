class Boundary{

float x,y;
float w,h;

Body b;

Boundary(float x_,float y_,float w_, float h_){
x = x_;
y = y_;
w = w_;
h = h_;


BodyDef bd = new BodyDef();

bd.type=BodyType.STATIC;

bd.position.set(box2d.coordPixelsToWorld(x,y));

b = box2d.createBody(bd);

float bow2dW = box2d.scalarPixelsToWorld(w);
float bow2dH = box2d.scalarPixelsToWorld(h);

PolygonShape ps = new PolygonShape();
ps.setAsBox(bow2dW,bow2dH);

b.createFixture(ps,1);





}

void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x,y,w,h);
  }


}
