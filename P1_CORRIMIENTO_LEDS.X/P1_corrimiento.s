;------------------------------------------------------------------------------
;@file	    P1_Corrimiento_leds.s
;@brief	    Desarrollar un programa que permita realizar un
;           corrimiento de leds conectados al puerto C, con
;           un retardo de 500 ms en un numero de
;           corrimientos pares y un retardo de 250ms en un
;           numero de corrimientos impares. El corrimiento
;           inicia cuando se presiona el pulsador de la placa
;           una vez y se detiene cuando se vuelve a
;           presionar. Agregar dos leds en los pines RE0 y
;           RE1, para visualizar cuando se da el corrimiento
;           par o impar.
;@date	    15/01/23
;@author    Castillo Masias Eswin Andres
;------------------------------------------------------------------------------
    
       
processor 18F57Q84
#include "Bet-config.inc"// config statements should precede project file includes.
#include <xc.inc>
#include "Retardos.inc"
PSECT resetvect,class=CODE,reloc=2
resetvect:
    GOTO main
PSECT CODE  
main:
    CALL config_osc,1
    CALL config_port,1
    
corrimiento:
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO corrimiento  ;instruccion de etiqueta desiganada
LED_1:
    BCF LATE,1,1      ;desactiva el led de corrimiento par 
    BSF LATE,0,1      ;me activa el led de corrimiento impar 
    BCF LATC,7,1      ;desactiva el led de corrimiento par 
    BSF LATC,0,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms  
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_2        ;instruccion de etiqueta desiganada
estop_1:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_1      ;instruccion de etiqueta desiganada
LED_2: 
    BCF LATC,0,1      ;desactiva el led de corrimiento par
    BSF LATC,1,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms  
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_3        ;instruccion de etiqueta desiganada
estop_2:
    CALL Delay_250ms  
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_2      ;instruccion de etiqueta desiganada
LED_3:
    BCF LATC,1,1      ;desactiva el led de corrimiento par
    BSF LATC,2,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_4        ;instruccion de etiqueta desiganada
estop_3:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_3      ;instruccion de etiqueta desiganada
LED_4:
    BCF LATC,2,1      ;desactiva el led de corrimiento par
    BSF LATC,3,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_5        ;instruccion de etiqueta desiganada
estop_4:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_4      ;instruccion de etiqueta desiganada
LED_5:
    BCF LATC,3,1      ;desactiva el led de corrimiento par
    BSF LATC,4,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_6        ;instruccion de etiqueta desiganada
estop_5:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_5        ;instruccion de etiqueta desiganada
LED_6:
    BCF LATC,4,1      ;desactiva el led de corrimiento par
    BSF LATC,5,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_7        ;instruccion de etiqueta desiganada
estop_6:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_6        ;instruccion de etiqueta desiganada
LED_7:
    BCF LATC,5,1      ;desactiva el led de corrimiento par
    BSF LATC,6,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_8        ;instruccion de etiqueta desiganada
estop_7:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_7        ;instruccion de etiqueta desiganada
LED_8:
    BCF LATC,6,1      ;desactiva el led de corrimiento par
    BSF LATC,7,1      ;me activa el led de corrimiento impar
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED1        ;instruccion de etiqueta desiganada
estop_8:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop_8      ;instruccion de etiqueta desiganada 
LED1:
    BCF LATE,0,1    ;desactiva el led de corrimiento impar
    BSF LATE,1,1    ;activa el led de corrimiento par
    BCF LATC,7,1    ;desactiva el led de corrimiento impar
    BSF LATC,0,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED2      ;instruccion de etiqueta desiganada 
estop1:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop1       ;instruccion de etiqueta desiganada 
LED2: 
    CALL Delay_250ms
    BCF LATC,0,1         ;desactiva el led de corrimiento impar
    BSF LATC,1,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED3      ;instruccion de etiqueta desiganada 
estop2:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop2      ;instruccion de etiqueta desiganada 
LED3:
    CALL Delay_250ms
    BCF LATC,1,1    ;desactiva el led de corrimiento impar
    BSF LATC,2,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED4      ;instruccion de etiqueta desiganada 
estop3:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop3      ;instruccion de etiqueta desiganada 
LED4:
    CALL Delay_250ms
    BCF LATC,2,1     ;desactiva el led de corrimiento impar
    BSF LATC,3,1         ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED5      ;instruccion de etiqueta desiganada 
estop4:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop4         ;instruccion de etiqueta desiganada 
LED5:
    CALL Delay_250ms
    BCF LATC,3,1    ;desactiva el led de corrimiento impar
    BSF LATC,4,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED6      ;instruccion de etiqueta desiganada 
estop5:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop5      ;instruccion de etiqueta desiganada 
LED6:
    CALL Delay_250ms
    BCF LATC,4,1    ;desactiva el led de corrimiento impar
    BSF LATC,5,1    ;activa el led de corrimiento par
    CALL Delay_250ms 
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    CALL Delay_250ms
    GOTO LED7      ;instruccion de etiqueta desiganada 
estop6:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop6      ;instruccion de etiqueta desiganada 
LED7:
    CALL Delay_250ms
    BCF LATC,5,1    ;desactiva el led de corrimiento impar
    BSF LATC,6,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED8      ;instruccion de etiqueta desiganada 
estop7:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop7      ;instruccion de etiqueta desiganada 
LED8:
    CALL Delay_250ms
    BCF LATC,6,1    ;desactiva el led de corrimiento impar
    BSF LATC,7,1    ;activa el led de corrimiento par
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO LED_1      ;instruccion de etiqueta desiganada 
estop8:
    CALL Delay_250ms
    BTFSC PORTA,3,0   ;es una pregunta el cual le vamos a preguntar a nuestro puerto de entrada si es 1 o 0
    GOTO estop8      ;instruccion de etiqueta desiganada 
    GOTO LED_1
config_osc:
    BANKSEL OSCCON1
    MOVLW 0X60h ;seleccionamos el bloque del oscilador interno con un DIV:1
    MOVWF OSCCON1,1
    BANKSEL OSCFRQ
    MOVLW 0x02h       ;seleccionamos una frecuencia de 4MHZ
    MOVWF OSCFRQ,1
    RETURN
config_port:
    BANKSEL PORTE  ; seleccionamos el banco
    SETF PORTE,1  ;porte<7:0>=1
    CLRF LATE,1    ;porte<7:0>=1
    CLRF ANSELE,1  ;limpiamos nuestro puerto ANSELE
    CLRF TRISE,1   ;limpiamos nuestro puerto TRISE
    
    BANKSEL PORTC  ; seleccionamos el banco
    SETF PORTC,1  ;portc<7:0>=1
    CLRF LATC,1    ;limpiamos nuestro puerto LATC
    CLRF ANSELC,1  ;limpiamos nuestro puerto ANSELC
    CLRF TRISC,1   ;limpiamos nuestro puerto TRISC
;configurando boton 
    BANKSEL PORTA   ;seleccionamos el banco
    CLRF PORTA,1     ;;porta<7:0>=1
    CLRF ANSELA,1    ;PORTA DIGITAL <>
    BSF TRISA,3,1    ;RA3 COMO ENTRADA
    BSF WPUA,3,1     ;ACTIVAMOS LA RESISTENCIA PULL-UP DEL PIN RA3
    RETURN

END resetvect





