#include <OneWire.h>
#include <DallasTemperature.h>
#include <Stepper.h>

#define Rx 7
float idealtemp = 59;
int error = 0;
const int stepsxRev = 32;  // 360/11.25 
// change this to fit the number of steps per revolution for your motor

const int gearReduction = 64;
const int stepsPerOutRev = stepsxRev * gearReduction;

int stepsRequired;
int rotdir;

OneWire oneWire(Rx);


DallasTemperature sensor(&oneWire);


// initialize the stepper library on pins 2 through 5:
Stepper DB3_Stepper(stepsPerOutRev, 8, 10, 9, 11);
//1-> pin 8, 2-> pin 9, 3-> pin 10, 4-> pin 11 on Arduino
float Temp=0;

void setup() {
  // put your setup code here, to run once:
  pinMode(7, INPUT_PULLUP);
  Serial.begin(9600);
  Serial.print(" Starting... ");
  sensor.begin();
}

void loop() {
  // put your main code here, to run repeatedly:
  readtemp();
  error = Temp - idealtemp;
  if(abs(error)>1)
  { readtemp();
  if(error > 0 )
  {
  // step one revolution in one direction:
  readtemp();
  DB3_Stepper.setSpeed(2);
  stepsRequired = stepsPerOutRev;
  DB3_Stepper.step(stepsRequired);
  delay(2000);
  DB3_Stepper.step(0);
  }
  else 
  {
  // step one revolution in the other direction:
  readtemp();
  DB3_Stepper.setSpeed(2);
  stepsRequired = -1*stepsPerOutRev;
  DB3_Stepper.step(stepsRequired);
  delay(1000);
  DB3_Stepper.step(0);
  }
  }
  else
  {
    readtemp();
    DB3_Stepper.step(0);
  }
  }

void readtemp()
{
  sensor.requestTemperatures();
  Temp=sensor.getTempCByIndex(0);
  Serial.print(Temp);
  Serial.println();
  
}
