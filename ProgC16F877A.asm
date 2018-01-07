
_main:

;ProgC16F877A.c,20 :: 		void main()            // Inicio do programa principal
;ProgC16F877A.c,22 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;ProgC16F877A.c,23 :: 		TRISD=0b11000000; // RD6 e RD7 são configuradas como entradas botoes mais e menos
	MOVLW      192
	MOVWF      TRISD+0
;ProgC16F877A.c,24 :: 		TRISC=0b00000000; // PORTC configurado como saidas
	CLRF       TRISC+0
;ProgC16F877A.c,25 :: 		DIGIT2=0;    //Desabilita Digito2
	BCF        PORTD+0, 1
;ProgC16F877A.c,26 :: 		DIGIT3=0;    //Desabilita Digito3
	BCF        PORTD+0, 2
;ProgC16F877A.c,27 :: 		DIGIT4=0;    //Desabilita Digito4
	BCF        PORTD+0, 3
;ProgC16F877A.c,28 :: 		DIGITNG=0;   //Digito do sinal em zero, desabilitado.
	BCF        PORTC+0, 7
;ProgC16F877A.c,30 :: 		while(1)  //loop infinito
L_main0:
;ProgC16F877A.c,32 :: 		changeCount();
	CALL       _changeCount+0
;ProgC16F877A.c,34 :: 		Mil = (Cnt/1000)-((Cnt%1000)/1000); //Digito dos milhares
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Mil+0
	MOVF       R0+1, 0
	MOVWF      _Mil+1
;ProgC16F877A.c,35 :: 		PORTC=Display(Mil);       // Envia para PORTC
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;ProgC16F877A.c,36 :: 		DIGIT1=1;
	BSF        PORTD+0, 0
;ProgC16F877A.c,37 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;ProgC16F877A.c,38 :: 		DIGIT1=0;
	BCF        PORTD+0, 0
;ProgC16F877A.c,40 :: 		Cen = (Cnt%1000);
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Cen+0
	MOVF       R0+1, 0
	MOVWF      _Cen+1
;ProgC16F877A.c,41 :: 		Cen = (Cen/100) - (Cen%100/100); //Digito das Centenas
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Cen+0, 0
	MOVWF      R0+0
	MOVF       _Cen+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Cen+0
	MOVF       R0+1, 0
	MOVWF      _Cen+1
;ProgC16F877A.c,42 :: 		PORTC=Display(Cen);   //Envia para o PORTC
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;ProgC16F877A.c,43 :: 		DIGIT2=1;
	BSF        PORTD+0, 1
;ProgC16F877A.c,44 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;ProgC16F877A.c,45 :: 		DIGIT2=0;
	BCF        PORTD+0, 1
;ProgC16F877A.c,47 :: 		Msd = (Cnt%100);
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Msd+0
	MOVF       R0+1, 0
	MOVWF      _Msd+1
;ProgC16F877A.c,48 :: 		Msd = (Msd%10)- ((Msd%10)/10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Msd+0, 0
	MOVWF      R0+0
	MOVF       _Msd+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Msd+0
	MOVF       R0+1, 0
	MOVWF      _Msd+1
;ProgC16F877A.c,49 :: 		PORTC=Display(Msd);
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;ProgC16F877A.c,50 :: 		DIGIT3=1;
	BSF        PORTD+0, 2
;ProgC16F877A.c,51 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
	NOP
;ProgC16F877A.c,52 :: 		DIGIT3=0;
	BCF        PORTD+0, 2
;ProgC16F877A.c,54 :: 		Lsd=Cnt%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Lsd+0
	MOVF       R0+1, 0
	MOVWF      _Lsd+1
;ProgC16F877A.c,55 :: 		PORTC=Display(Lsd);
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;ProgC16F877A.c,56 :: 		DIGIT4=1;
	BSF        PORTD+0, 3
;ProgC16F877A.c,57 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;ProgC16F877A.c,58 :: 		DIGIT4=0;
	BCF        PORTD+0, 3
;ProgC16F877A.c,59 :: 		} // end while
	GOTO       L_main0
;ProgC16F877A.c,61 :: 		}  // end void main
	GOTO       $+0
; end of _main

_Display:

;ProgC16F877A.c,67 :: 		int Display(int no)
;ProgC16F877A.c,70 :: 		int SEGMENTO[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67};
	MOVLW      63
	MOVWF      Display_SEGMENTO_L0+0
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+1
	MOVLW      6
	MOVWF      Display_SEGMENTO_L0+2
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+3
	MOVLW      91
	MOVWF      Display_SEGMENTO_L0+4
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+5
	MOVLW      79
	MOVWF      Display_SEGMENTO_L0+6
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+7
	MOVLW      102
	MOVWF      Display_SEGMENTO_L0+8
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+9
	MOVLW      109
	MOVWF      Display_SEGMENTO_L0+10
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+11
	MOVLW      125
	MOVWF      Display_SEGMENTO_L0+12
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+13
	MOVLW      7
	MOVWF      Display_SEGMENTO_L0+14
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+15
	MOVLW      127
	MOVWF      Display_SEGMENTO_L0+16
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+17
	MOVLW      103
	MOVWF      Display_SEGMENTO_L0+18
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+19
;ProgC16F877A.c,71 :: 		Pattern=SEGMENTO[no];  // para retornoar o Pattern
	MOVF       FARG_Display_no+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_no+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      Display_SEGMENTO_L0+0
	MOVWF      FSR
;ProgC16F877A.c,72 :: 		return (Pattern);
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
;ProgC16F877A.c,73 :: 		}    //end função
	RETURN
; end of _Display

_changeCount:

;ProgC16F877A.c,75 :: 		void changeCount()
;ProgC16F877A.c,78 :: 		while(MAIS == 1)
L_changeCount6:
	BTFSS      PORTD+0, 6
	GOTO       L_changeCount7
;ProgC16F877A.c,80 :: 		Cnt = Cnt +1;
	INCF       _Cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _Cnt+1, 1
;ProgC16F877A.c,81 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_changeCount8:
	DECFSZ     R13+0, 1
	GOTO       L_changeCount8
	DECFSZ     R12+0, 1
	GOTO       L_changeCount8
	DECFSZ     R11+0, 1
	GOTO       L_changeCount8
	NOP
	NOP
;ProgC16F877A.c,82 :: 		if(Cnt >80) Cnt=80;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Cnt+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__changeCount16
	MOVF       _Cnt+0, 0
	SUBLW      80
L__changeCount16:
	BTFSC      STATUS+0, 0
	GOTO       L_changeCount9
	MOVLW      80
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_changeCount9:
;ProgC16F877A.c,83 :: 		if (Cnt > 0) DIGITNG=1;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Cnt+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__changeCount17
	MOVF       _Cnt+0, 0
	SUBLW      0
L__changeCount17:
	BTFSC      STATUS+0, 0
	GOTO       L_changeCount10
	BSF        PORTC+0, 7
L_changeCount10:
;ProgC16F877A.c,84 :: 		}
	GOTO       L_changeCount6
L_changeCount7:
;ProgC16F877A.c,86 :: 		while(MENOS == 1)
L_changeCount11:
	BTFSS      PORTD+0, 7
	GOTO       L_changeCount12
;ProgC16F877A.c,88 :: 		Cnt = Cnt - 1;
	MOVLW      1
	SUBWF      _Cnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _Cnt+1, 1
;ProgC16F877A.c,89 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_changeCount13:
	DECFSZ     R13+0, 1
	GOTO       L_changeCount13
	DECFSZ     R12+0, 1
	GOTO       L_changeCount13
	DECFSZ     R11+0, 1
	GOTO       L_changeCount13
	NOP
	NOP
;ProgC16F877A.c,90 :: 		if (Cnt <1 ) Cnt =0;
	MOVLW      128
	XORWF      _Cnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__changeCount18
	MOVLW      1
	SUBWF      _Cnt+0, 0
L__changeCount18:
	BTFSC      STATUS+0, 0
	GOTO       L_changeCount14
	CLRF       _Cnt+0
	CLRF       _Cnt+1
L_changeCount14:
;ProgC16F877A.c,91 :: 		if (Cnt <1) DIGITNG =0;
	MOVLW      128
	XORWF      _Cnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__changeCount19
	MOVLW      1
	SUBWF      _Cnt+0, 0
L__changeCount19:
	BTFSC      STATUS+0, 0
	GOTO       L_changeCount15
	BCF        PORTC+0, 7
L_changeCount15:
;ProgC16F877A.c,93 :: 		}
	GOTO       L_changeCount11
L_changeCount12:
;ProgC16F877A.c,95 :: 		}
	RETURN
; end of _changeCount
