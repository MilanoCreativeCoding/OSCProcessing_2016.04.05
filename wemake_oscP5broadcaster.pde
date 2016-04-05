import oscP5.*;
import netP5.*;

int nbr_circles = 32;
int chiaro = 237;
int scuro = 100;

OscP5 oscP5;
NetAddressList myNetAddressList = new NetAddressList();
/* listeningPort is the port the server is listening for incoming messages */
int myListeningPort = 7172;
/* the broadcast port is the port the clients should listen for incoming messages from the server*/
int myBroadcastPort = 7172;

String myConnectPattern = "/qc";
String myDisconnectPattern = "/server/disconnect";


void setup() {
  oscP5 = new OscP5(this, myListeningPort);
  frameRate(25);
  size(600, 600);
  smooth();
}

void draw() {
  background(240);
  retino_01();
}

void oscEvent(OscMessage theOscMessage) {
  print("gino");
  println(theOscMessage);
}

void retino_01(){
    float cx = width/2.0;
    float cy = height/2.0;
    int lg_diam = width/2;
    int lg_rad = lg_diam / 2;
    float lg_circ = PI * lg_diam;
  
   for (int i = 1; i <= nbr_circles; ++i) {
    float angle = i * TWO_PI / nbr_circles;
    float x = cx + cos(angle) * lg_rad;
    float y = cy + sin(angle) * lg_rad;
    stroke(scuro, scuro, scuro, scuro-i);
    if(angle < PI){
     stroke(chiaro, chiaro, chiaro, scuro-i);
     //line(x, y, cx-lg_rad, cy);
     //line(x, y, cx+lg_rad, cy);
    }else{
      stroke(scuro, scuro, scuro, scuro-(i*2));
      //line(x, y, cx, cy-lg_rad);
      //line(x, y, cx, cy+lg_rad);
    }
    line(x, y, cx-lg_rad, cy);
    line(x, y, cx+lg_rad, cy);
    line(x, y, cx, cy-lg_rad);
    line(x, y, cx, cy+lg_rad);
    //line(x, y, cx, cy);
    noStroke();
    fill(scuro);
    ellipse(x, y, 3, 3);
  }
}


 private void connect(String theIPaddress) {
     if (!myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
       myNetAddressList.add(new NetAddress(theIPaddress, myBroadcastPort));
       println("### adding "+theIPaddress+" to the list.");
     } else {
       println("### "+theIPaddress+" is already connected.");
     }
     println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
 }



private void disconnect(String theIPaddress) {
if (myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
		myNetAddressList.remove(theIPaddress, myBroadcastPort);
       println("### removing "+theIPaddress+" from the list.");
     } else {
       println("### "+theIPaddress+" is not connected.");
     }
       println("### currently there are "+myNetAddressList.list().size());
 }