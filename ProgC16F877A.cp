#line 1 "C:/Git/local/ProgCmax01/ProgC16F877A.c"
#line 15 "C:/Git/local/ProgCmax01/ProgC16F877A.c"
int Mil,Cen,Msd,Lsd,Cnt = 0;

int Display(int no);
void changeCount();

void main()
{
 CMCON = 0x07;
 TRISD=0b11000000;
 TRISC=0b00000000;
  PORTD.F1 =0;
  PORTD.F2 =0;
  PORTD.F3 =0;
  PORTC.F7 =0;

 while(1)
 {
 changeCount();

 Mil = (Cnt/1000)-((Cnt%1000)/1000);
 PORTC=Display(Mil);
  PORTD.F0 =1;
 delay_ms(5);
  PORTD.F0 =0;

 Cen = (Cnt%1000);
 Cen = (Cen/100) - (Cen%100/100);
 PORTC=Display(Cen);
  PORTD.F1 =1;
 delay_ms(5);
  PORTD.F1 =0;

 Msd = (Cnt%100);
 Msd = (Msd/10)- ((Msd%10)/10);
 PORTC=Display(Msd);
  PORTD.F2 =1;
 delay_ms(5);
  PORTD.F2 =0;

 Lsd=Cnt%10;
 PORTC=Display(Lsd);
  PORTD.F3 =1;
 delay_ms(5);
  PORTD.F3 =0;
 }

}





int Display(int no)
{
 int Pattern;
 int SEGMENTO[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67};
 Pattern=SEGMENTO[no];
 return (Pattern);
}

 void changeCount()
 {

 while( PORTD.F6  == 1)
 {
 Cnt = Cnt +1;
 delay_ms(250);
 if(Cnt >8000) Cnt=8000;
 if (Cnt > 0)  PORTC.F7 =0;
 }

 while( PORTD.F7  == 1)
 {
 Cnt = Cnt - 1;
 delay_ms(250);
 if (Cnt <1) Cnt =0;
 if (Cnt <1)  PORTC.F7  =1;

 }

 }
