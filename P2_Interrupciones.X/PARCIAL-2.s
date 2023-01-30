;------------------------------------------------------------------------------
;@file	    P2_interrupciones
;@brief	    Se inicia el encendido de leds cuando se preciona el pulsador de la placa
;            inician prendiendo los de los extremos hasta en medio luego se apagan y prenden
;            de los de enmedio hacia afuera teniendo dos pulsadores externo 
;            uno nos ayuda a parar el ensendimiento de leds y el otro reinicia
;@date	    29/01/23
;@author    Castillo Masias Eswin Andres
;------------------------------------------------------------------------------
    
PROCESSOR 18F57Q84
#include "Bit_config.inc.inc"   /config statements should precede project file includes./
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 

PSECT ISRalta,class=CODE,reloc=2
ISRalta:
    BTFSC   PIR6,0,0	;Comsulta si se produce la INT1
    GOTO    Next_top
INT2:
    BTFSC   PIR10,0,0	;Comsulta si se produce la INT2
    BCF	    PIR10,0,0	;limpiamos el flag
    CLRF    LATC,1
    SETF    Detener_2,0 
Exit:
    RETFIE    
    
PSECT ISRbaja,class=CODE,reloc=2
ISRbaja:
    BTFSS  PIR1,0,0	;Comsulta si se produce la INT0
    GOTO    Exit1
INT0:
    BCF	    PIR1,0,0	;limpiamos el flag 
    GOTO    TOOGLE
Exit1:
    RETFIE
    
PSECT udata_acs		    ;Acces RAM
Contador_1:      DS 1
Contador_2:      DS 1
Detener_1:       DS 1
Detener_2:       DS 1
offset:		 DS 1	      
Offset_1:	 DS 1 
counter:	 DS 1
Counter_1:	 DS 1 
        
PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0_INT1,1
LED_ON:
    BANKSEL LATF
    BCF	    LATF,3,1	;Led on
    CALL    delay_250ms,1
    CALL    delay_250ms,1
    BSF	    LATF,3,1	;Led of
    CALL    delay_250ms,1
    CALL    delay_250ms,1
    goto    LED_ON
TOOGLE:
    MOVLW   5
    MOVWF   Offset_1,0	;Se repetira 5 veces
    MOVLW   0
    MOVWF   Detener_1,0	
    MOVWF   Detener_2,0
    GOTO    reload2    
LOOP: 
    BANKSEL PCLATU
    MOVLW   low highword(Table)
    MOVWF   PCLATU,1
    MOVLW   high(Table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
    CALL    Table
    BTFSC   Detener_2,1,0
    GOTO    Exit1
    BTFSC   Detener_1,1,0
    GOTO    Exit1
    MOVWF   LATC,0
    MOVWF   Counter_1,0
    CALL    delay_250ms   
    DECFSZ  counter,1,0
    GOTO    RELOAD1
    GOTO    LED_OF    
RELOAD1:
    INCF    offset,1,0  
    GOTO    LOOP  
LED_OF:
    DECFSZ  Offset_1,1,0
    GOTO    reload2
    GOTO    Exit1
reload2: 
    BSF	    LATF,3,1	;Led on
    MOVLW   10
    MOVWF   counter,0	;definimos counter
    MOVLW   0x00
    MOVWF   offset,0	;offset inicial
    GOTO    LOOP
Next_top:
    BCF	    PIR6,0,0	;limpiamos el flag
    MOVF    Counter_1,0,0
    MOVWF   LATC,1
    SETF    Detener_1,0
    GOTO    Exit
    
    
Table:
    ADDWF   PCL,1,0
    RETLW   10000001B	;0
    RETLW   01000010B	;1
    RETLW   00100100B	;2
    RETLW   00011000B	;3
    RETLW   00000000B	;4
    RETLW   00011000B	;5
    RETLW   00100100B	;6
    RETLW   01000010B	;7
    RETLW   10000001B	;8
    RETLW   00000000B	;9
    
Config_OSC:     ;Oscilador Interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60    ;osc interno(HFINTOSC)
    MOVWF   OSCCON1,1 
    MOVLW   0x02    ;Frecuencia = 4MHz
    MOVWF   OSCFRQ,1
    RETURN
    
Config_Port:	
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1	
    BSF	    LATF,3,1
    CLRF    ANSELF,1
    CLRF    ANSELF,1
    BCF	    TRISF,3,1
    BSF     TRISF,2,1
    BSF	    WPUF,2,1
    
    ;Config DE LEDS
    BANKSEL PORTC   
    CLRF    PORTC,1	;PORTC = 0
    CLRF    LATC,1	;LATC = 0 -- Leds apagado
    CLRF    ANSELC,1	;ANSELC = 0 -- Digital
    CLRF    TRISC,1
    
    ;Config de button del uC
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	
    BSF	    TRISA,3,1	
    BSF	    WPUA,3,1
    
    ;Config, button externo
    BANKSEL PORTB
    BSF    PORTB,4,1
    BCF    ANSELB,4,1
    BSF     TRISB,4,1     ; Puerto Entrada 
    BSF	    WPUB,4,1
    RETURN 
    
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	; INT0 = RA3
    
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x0C
    MOVWF   INT1PPS,1	; INT1 = RB4
    
    BANKSEL INT2PPS
    MOVLW   0x2A
    MOVWF   INT2PPS,1	; INT2 = RF2
    RETURN
    

Config_INT0_INT1:
;Pasos para implementar Computed_GOTO 
; 1.Escribir el byte superior en PCLATU
; 2.Escribir el byte alto en PCLATH
; 3.Escribir el byte bajo en PCL
; NOTA:El offset debe ser multiplicado por "2" para el alineamiento en memoria.
    ;Configuracion de prioridades
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 1 -- Habilitamos las prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de baja prioridad
    BSF	IPR6,0,1    ; IPR6<INT1IP> = 1 -- INT1 de alta prioridad
    BSF IPR10,0,1   ;IPR6<INT1IP> = 1 -- INT1 de alta prioridad
    ;Config INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext0
    
    ;Config INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de subida
    BCF	PIR6,0,0    ; PIR6<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT0IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Config INT2
    BCF	INTCON0,2,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de subida
    BCF	PIR10,0,0    ; PIR6<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE10,0,0    ; PIE6<INT0IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Habilitacion de interrupciones
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global y de alta prioridad
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN
    
delay_250ms:               ;2Tcy -- Call
    MOVLW 250              ; 1Tcy -- k2
    MOVWF Contador_2,0      ; 1Tcy
Ext_Loop:
    MOVLW 249              ; 1Tcy -- k1
    MOVWF Contador_1,0      ; 1Tcy
Int_Loop:
    NOP                    ; k1*Tcy
    DECFSZ Contador_1,1,0   ; (k1-1)+ 3Tcy
    GOTO Int_Loop          ; (k1-1)*2Tcy
    DECFSZ Contador_2,1,0   ;  (K2-1)*1Tcy + 3Tcy
    GOTO Ext_Loop           ;  (K2-1)*2Tcy
    RETURN                  ; 2Tcy
    
    
END resetVect