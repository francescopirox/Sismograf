// Graphing sketch

// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

import processing.serial.*;

Serial myPort;        // The serial port
int boot=0;
int xPos =10; // horizontal position of the graph
float inByte = 0;
int i=0 ;  //contatore
float rec=0;

String g0 = "1,5 G";  //text 
String g1= "1 G";
String g2="0 G";
String g3="-1 G";
String g4="-1,5 G";

String inString;
PrintWriter output;

int s = 0;  // Values from 0 - 59
int m = 0; // Values from 0 - 59
int h = 0; // Values
int ms = 0;//


void setup () {
String[] a=new String[8];  // strings used for output name file 
String recName;  //final name string

  size(600, 600); // set the window size:
  textSize(20);   // set text size
  background(0);  // set inital background:
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  if(Serial.list()[0]==null)
  {
  myPort = new Serial(this, Serial.list()[0], 9600); // List all the available serial ports
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  }
  else
  {
   stroke(255);
    fill(255);
   text("Benvenuto, questa è la mia applicazione \n per la gestione di un sismografo utilizzante un Arduino Uno \n collegatto in serliale (assicurati di collegarlo) \n ed un accellerometro.\n Realizzato da Francescopirox",10,200);
   delay(6000);
   exit(); 
  }
  
  a[0]="registrazione";
  a[1]=nf(day());
  a[2]=nf(month());
  a[3]="at";
  a[4]=nf(hour());
  a[5]=nf( second());  // Values from 0 - 59
  a[6] = nf(minute());  // Values from 0 - 59
  a[7]=".txt";
recName=join(a,"");
output = createWriter(recName); 
}
void draw () {
  stroke(255);
  fill(50);
  
  rect(0,0,200,170);   //the 3 button
  rect(200,0,400,170);
  rect(400,0,600,170);
  fill (255);
  text("REGISTRA",50,100);
  text("RIPRODUCI",250,100);
  text("STOP",470,100);
  
  text(g0, 1, 210);  //draw the *G
  text(g1, 1, 340);
  text(g2, 1, 430);
  text(g3, 1, 530);
  text(g4,1,600);
  fill(50);
  
  if(boot==0)  // boot text
  {
  boot();
  }
                      // draw the line:
  stroke(127, 34, 255);
  line(xPos, height , xPos, height - inByte);
  
   
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
    rec= inByte;
    inByte = map(inByte, 0, 1023, 0,height);
  
  }
  
  }
  void rec(){
 s = second();  // Values from 0 - 59
 m = minute();  // Values from 0 - 59
 h = hour();// Values from 0 - 23
 ms= millis();
    i = 1;
    fill(255);
      text("REGISTRA",200,400);
      int z=int(rec);
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
  String[] rip= new String[2];
  String[] text; 
  int y=0;
     fill(255);
     text("RIPRODUCI",200,400);
     text =loadStrings("/home/francesco/sismograf/riproduci.txt");

        for ( y=0;y<text.length; y++)
     {
      rip=split(text[y],' ');     
      myPort.write(rip[0]);
      println(rip[0]);
      delay(100);
     
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
boot=1;
 text("Benvenuto, questa è la mia applicazione \n per la gestione di un sismografo utilizzante un Arduino Uno \n collegatto in serliale (assicurati di collegarlo) \n ed un accellerometro.\n Realizzato da Francescopirox",10,200);
draw();  
}