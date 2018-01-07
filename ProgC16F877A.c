// **** Circuito Max com PIC 16F877A *****
// **** Lab Atomo - Controlador de Temperatura *****
// **  Ajuste set point  via botoes *****

// ####  Definiçoes de variáveis   ####
#define DIGIT1 PORTD.F0
#define DIGIT2 PORTD.F1
#define DIGIT3 PORTD.F2
#define DIGIT4 PORTD.F3
#define DIGITNG PORTC.F7
#define MAIS PORTD.F6
#define MENOS PORTD.F7

// Definicao de variaveis
int Mil,Cen,Msd,Lsd,Cnt = 0;

int Display(int no);
void changeCount();

void main()            // Inicio do programa principal
{
     CMCON = 0x07;
     TRISD=0b11000000; // RD6 e RD7 são configuradas como entradas botoes mais e menos
     TRISC=0b00000000; // PORTC configurado como saidas
     DIGIT2=0;    //Desabilita Digito2
     DIGIT3=0;    //Desabilita Digito3
     DIGIT4=0;    //Desabilita Digito4
     DIGITNG=0;   //Digito do sinal em zero, desabilitado.
     
 while(1)  //loop infinito
 {
  changeCount();
  
  Mil = (Cnt/1000)-((Cnt%1000)/1000); //Digito dos milhares
  PORTC=Display(Mil);       // Envia para PORTC
  DIGIT1=1;
  delay_ms(5);
  DIGIT1=0;
  
  Cen = (Cnt%1000);
  Cen = (Cen/100) - (Cen%100/100); //Digito das Centenas
  PORTC=Display(Cen);   //Envia para o PORTC
  DIGIT2=1;
  delay_ms(5);
  DIGIT2=0;
  
  Msd = (Cnt%100);
  Msd = (Msd%10)- ((Msd%10)/10);
  PORTC=Display(Msd);
  DIGIT3=1;
  delay_ms(5);
  DIGIT3=0;
  
  Lsd=Cnt%10;
  PORTC=Display(Lsd);
  DIGIT4=1;
  delay_ms(5);
  DIGIT4=0;
 } // end while

}  // end void main

// Esta função acha o bit pattern(matrix de bits) para ser enviado
// para o PORTC e mostrar um numero no Display de 7 segmentos. O numero
// é passado como um arqumento para função.

int Display(int no)
{
  int Pattern;
  int SEGMENTO[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67};
  Pattern=SEGMENTO[no];  // para retornoar o Pattern
  return (Pattern);
}    //end função
  
  void changeCount()
    {
  
       while(MAIS == 1)
       {
        Cnt = Cnt +1;
        delay_ms(250);
        if(Cnt >80) Cnt=80;
        if (Cnt > 0) DIGITNG=1;
       }
       
       while(MENOS == 1)
       {
        Cnt = Cnt - 1;
        delay_ms(250);
        if (Cnt <1 ) Cnt =0;
        if (Cnt <1) DIGITNG =0;
        
       }
       
  }