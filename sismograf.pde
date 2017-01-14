// Graphing sketch

// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

import processing.serial.*;

Serial myPort;        // The serial port
String[] lines; /*= new String[10];*/
int z=0;
int xPos =10; // horizontal position of the graph
float inByte = 0;
int rec = 0;
int i=0 ;
float k=0;
String g0 = "1,5 G";
String g1= "1 G";
String g2="0 G";
String g3="-1 G";
String g4="-1,5 G";
String inString;
PrintWriter output;
int s = 0;  // Values from 0 - 59
int m = 0; // Values from 0 - 59
int h = 0; 
int ms = 0;
String[] a=new String[5];
String b;
String[] c= new String[2];
void setup () {
  // set the window size:
  size(600, 600);
  textSize(20);
  background(0);
    // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  //println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  a[0]="registrazione";
  a[1]=nf(hour());
 a[3]=nf( second());  // Values from 0 - 59
a[2] = nf(minute());  // Values from 0 - 59
a[4]=".txt";
b=join(a,"");
    output = createWriter(b); 
}
void draw () {
  stroke(255);
  fill(50);
  rect(0,0,200,170);
  rect(200,0,400,170);
  rect(400,0,600,170);
  fill (255);
  text("REGISTRA",50,100);
  text("RIPRODUCI",250,100);
  text("STOP",470,100);
  text(g0, 1, 210);
  text(g1, 1, 340);
  text(g2, 1, 430);
  text(g3, 1, 530);
  text(g4,1,600);
  fill(50);
  if(z==0)
  {
  boot();
  }
  // draw the line:
  stroke(127, 34, 255);
  line(xPos, height , xPos, height - inByte);
  
 s = second();  // Values from 0 - 59
 m = minute();  // Values from 0 - 59
 h = hour();// Values from 0 - 23
  ms= millis();
   if ((mouseX > 0) && (mouseX < 200) &&
    (mouseY > 0) && (mouseY < 170) || i == 1 ) {
      noStroke();
    fill(200);
     rect(0,0,200,170);
     fill(0);
     text("REGISTRA",50,100);
     if (mousePressed == true|| i==1) 
       {
        if (mouseButton == LEFT|| i == 1) 
          {
            rec();
          }
       }
  } 
  if ((mouseX > 201) && (mouseX < 400) &&
    (mouseY > 0) && (mouseY < 170)) {
      noStroke();
    fill(200);
      rect(200,0,200,170);
     fill(0);
     text("RIPRODUCI",250,100);
     if (mousePressed == true) 
       {
        if (mouseButton == LEFT) 
          {
            riprod();
          }
       }
  } 
   if ((mouseX > 401) && (mouseX < 600) &&
    (mouseY > 0) && (mouseY < 170)) {
      noStroke();
    fill(200);
       rect(400,0,200,170);
     fill(0);
     text("STOP",470,100);
     if (mousePressed == true) 
       {
        if (mouseButton == LEFT) 
          {
            stop();
          }
       }     
  }  

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    // increment the horizontal position:
    xPos++;
  }
}
void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    k= inByte;
    inByte = map(inByte, 0, 1023, 0,height);
   ;
  }
  
  }
  void rec(){
    i = 1;
    fill(255);
      text("REGISTRA",200,400);
      int z=int(k);
      output.print(z);
      println(z);
      output.print(" Orario:");
      output.print(h);
      output.print (m);
      output.print(s);
      output.println(ms);
        output.flush();
      endShape();      
   }
void riprod(){
  int y=0;
  int t=0;
   fill(255);
     text("RIPRODUCI",200,400);
     lines =loadStrings("/home/francesco/sismograf/riproduci.txt");

        for ( y=0;y< 100; y++)
     {
      c=split(lines[y],' ');
     // int(c[0])
     
      myPort.write(c[0]);
      println(c[0]);
      delay(100);
     // println(c[0]);
         if (y%700==0)
         {
            myPort.write(1030);
         }
     
       delay(10);
     }
     myPort.write("1030");
     println(1030);
     y=0;
     endShape();
}
void stop()
{
   output.close();
   exit();
}

void boot()
{
  fill(250);
 z=1;
 text("Benvenuto, questa è la mia applicazione \n per la gestione di un sismografo utilizzante un Arduino Uno \n collegatto in serliale (assicurati di collegarlo) \n ed un accellerometro.\n Realizzato da Francescopirox",10,200);
draw();  
}