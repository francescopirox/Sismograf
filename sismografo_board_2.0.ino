#include <Servo.h>
int x=0; //z axis variable
//int n=0;
//int z=0;
//loat a; // rx serial number
//int d=0;
//int c[700];

Servo myservo;
void setup()
{ 
 pinMode(13,OUTPUT);
   myservo.attach(9);
  Serial.begin(9600); // opens serial port, sets data rate to 9600 bps
  myservo.write(90);
}
void loop()
{
   
  digitalWrite(13,LOW);
  x = analogRead(5); // read A5 input pin
  Serial.println(x);//print to serial a5
  
   if (Serial.available()) //check if serial com aveble
   {
    digitalWrite(13,HIGH);
   // riproduci(); //call riproduci
    
   }
  delay(2);
  }

/*void riproduci()
{
int b=0;
int j=0; 
{
  while(Serial.available()||n!=0)
    {
      //Serial.println("1");
      
    if(Serial.available())
      {n=1;
        a= Serial.parseFloat();
        d=a;
      
        
        if(d==1030)
        { 
         //Serial.println("3");
         
          for(int i=0;i<700 ;i++)
         {
          //Serial.println("4");
            if(c[i]!=0)
            {
            myservo.write(c[i]);
            delay(100);             
            } 
                     
          }
          
          j=0;
         Cancella();
         d=0;
         } 

         if(d != 0)
         {
         Serial.println("ricevuto");
         digitalWrite(13,LOW);
         }
         if(d==1040)
         {
            myservo.write(90); 
            j=0;
            d=0;                
         }
           //function for numbers
           if(d<=700&&d>0)
            {
              b= map(d,0,700,60,120);
              c[j]= b;
              //Serial.println(c[j]);
              j++;
            //  Serial.println("5");
            }
            else
            {
              d=0;
            }        
            }
      }
    }
  }


void Cancella(){
  
  for(int i=0;i<700 ;i++)
   {
    
    c[i]=0;                          
   }
   Serial.println(1050);
}*/



