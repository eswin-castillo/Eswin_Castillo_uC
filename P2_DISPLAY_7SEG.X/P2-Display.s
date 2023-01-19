;------------------------------------------------------------------------------
;@file	    P2_Display_SEG.s
;@brief	    Desarrollar un programa que permita mostrar los
;           valores alfanuméricos(0-9 y A-F) en un display de
;           7 segmentos ánodo común, conectados al puerto
;           D. Los valores a mostrar serán seleccionados por
;           la siguiente condición:
;           ? Si el botón de la placa no esta presionado,
;           se muestran los valores numéricos del 0
;            al 9.
;           ? Si el botón de la placa se mantiene
;           presionado, se muestran los valores de A
;           hasta F.
;@date	    15/01/23
;@author    Castillo Masias Eswin Andres
;------------------------------------------------------------------------------
    
processor 18F57Q84
#include "BET-Config.inc"// config statements should precede project file includes.
#include <xc.inc>
#include "Retardo.inc"
PSECT resetvect,class=CODE,reloc=2
resetvect:
    GOTO main
PSECT CODE
main:
    CALL config_osc,1
    CALL config_port,1
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta0:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01000000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta1:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01111001B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta2:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00100100B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta3:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00110000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta4:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00011001B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta5:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00010010B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta6:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVlW 00000010B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta7:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01111000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta8:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
cuenta9:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00011000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO CONTA
    GOTO cuenta0
CONTA:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00001000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
cuentaB:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000011B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
cuentaC:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01000110B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
cuentad:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00100001B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
cuentae:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000110B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
cuentaf:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00001110B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO cuenta0
    GOTO CONTA
config_osc:
    BANKSEL OSCCON1
    MOVLW 0X60 ;SELECIONAMOS EL BLOQUE DEL OSCILADOR INTERNO CON UN DIV:1
    MOVWF OSCCON1,1
    BANKSEL OSCFRQ
    MOVLW 0x02;SELECIONAMOS UNA FRECUENCIA DE 8MHZ
    MOVWF OSCFRQ,1
    RETURN
config_port:
    BANKSEL PORTD
    CLRF PORTD,1
    SETF LATD,1 
    CLRF ANSELD,1
    CLRF TRISD,1 
;configurando boton 
    BANKSEL PORTA 
    CLRF PORTA,1 
    CLRF ANSELA,1    
    BSF TRISA,3,1    
    BSF WPUA,3,1    
    RETURN
END resetvect





