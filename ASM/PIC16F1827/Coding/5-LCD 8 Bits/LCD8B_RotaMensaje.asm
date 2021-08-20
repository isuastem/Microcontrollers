

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
#INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;P A L A B R A   D E   C O N F I G U R A C I O N
	__config	_CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__config	_CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON  & _LVP_OFF 
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	CBLOCK	0X120
	NUM1,NUM2,NUM3,SHIFT
	ENDC

#DEFINE	RS LATA,6		
#DEFINE	EN LATA,7

LIMPIAR		EQU B'00000001'	;LIMPIA TODA LA PANTALLA
RENGLON1	EQU	B'10000000'	;COLOCA EN EL RENGLON 1
RENGLON2	EQU	B'11000000'	;COLOCA EN EL RENGLON2
DISON		EQU	B'00001100'	;ENCIENDE EL DISPLAY
HOME		EQU	B'00000010'	;VA A LA DIDERCCION 0
SHIFTDL		EQU	B'00011100'	;ROTA EL LCD A LA IZQUIERDA
SHIFTDR		EQU	B'00011000'	;ROTA EL LCD A LA DERECHA
SHIFTCL		EQU	B'00010100'	;ROTA EL CURSOR A LA IZQUIERDA
SHIFTCR		EQU	B'00010000'	;ROTA EL CURSOR A LA DERECHA



;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	ORG	0X00
			GOTO INICIO						;DECLARO EL VECTOR DE INICIO O RESET
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	ORG	0X04	
			RETFIE							; DECLARO EL VECTOR DE INTERRUPCION

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-


INICIO:			
				BANKSEL	OSCCON		
				MOVLW		B'11110000'	;CONFIGURO EL REGISTRO OSCCON
				MOVWF		OSCCON
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

					BANKSEL	APFCON0
				MOVLW		B'01111111'		;CONFIGURO LOS REGISTROS	APFCON0 Y APFCON1
				MOVWF		APFCON0
			
					BANKSEL	APFCON1
			
				MOVLW		B'00000000'
				MOVWF		APFCON1
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-			
					BANKSEL ANSELB
				
				CLRF ANSELB 				;DESHABILITO LOS CANALES ANALOGICOS
				CLRF ANSELA 
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-			

					BANKSEL	TRISB
				CLRF	TRISB			;CONFIGURO PORTB COMO SALIDA
				CLRF	TRISA     		;CONFIGURO PORTA COMO SALIDA
	
				
					BANKSEL	LATB

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; I N I C I A L I Z A C I O N   D E   P E R I F E R I C O S
				CALL	INITLCD		;INICIALIZO LA LCD
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; I N I C I A L I Z A C I O N   D E   R E G I S T R O S
				CLRF	LATB				;PONGO A CEROS PORTB
		
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; P R O G R A M A   P R I N C I P A L

PROGRAMA:

	
	MOVLW LIMPIAR
	CALL CMD
	
	CALL MENSAJE

	MOVLW D'10'
	MOVWF SHIFT

VUELTA 

	CALL RETARDO_1SEG
	MOVLW SHIFTDR ;COMANDO DE ROTACION
	CALL CMD

	DECFSZ SHIFT,F
	GOTO VUELTA

	MOVLW LIMPIAR ;COMANDO DE LIMPIEZA DE PANTALLA
	CALL CMD
	
	GOTO PROGRAMA

	
MENSAJE:	

	MOVLW RENGLON1
	CALL CMD
	
	MOVLW	"S"
	CALL	DATO
	MOVLW	"I"
	CALL	DATO


	MOVLW	RENGLON2
	CALL	CMD

	MOVLW	"F"
	CALL	DATO
	MOVLW	"U"
	CALL	DATO
	MOVLW	"N"
	CALL	DATO
	MOVLW	"C"
	CALL 	DATO
	MOVLW	"I"
	CALL 	DATO
	MOVLW	"O"
	CALL	DATO
	MOVLW	"N"
	CALL	DATO
	MOVLW	"A"
	CALL	DATO
	MOVLW	"!"
	CALL	DATO

	RETURN
	
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
;SUBRUTINA DE INICIALIZACION DE LA PANTALLA DE CRISTAL LIQUIDO
INITLCD:	
			
			CALL 	RETARDO5MS
			CALL 	RETARDO5MS
			CALL 	RETARDO5MS
			
				MOVLW 	B'00110000'		;SE INICIALIZA LA PANTALLA
				CALL 	CMD
				MOVLW 	B'00110000'
				CALL 	CMD
				MOVLW	B'00110000'
				CALL 	CMD
	
;SELECCION DE BITS ( 4 - 8 ) 

;DL = 1 ->  8 BITS   ;   DL = 0 -> 4 BITS
;N  = 1 ->  2 LINEAS ;   N  = 0 -> 1 LINEA
;F  = 1 ->  5X11     ;   F  = 0 -> 5X8
; 0  0  1  DL  N  F  -  -
	
				MOVLW	B'00111100'		;SE SELECCIONA SI LA PANTALLA SERA USADA A 4 O A 8 BITS CON EL BIT4. 
				CALL 	CMD

;SE APAGA LA PANTALLA 

;D = 1 -> DISPLAY-ON  ; D = 0 -> DISPLAY-OFF
;C = 1 -> CURSOR-ON   ; C = 0 -> CURSOR-0FF 
;B = 1 -> PARPADEO-ON ; B = 0 -> PARPADEO-OFF
; 0  0  0  0  1  D  C  B

				MOVLW 	B'00001000' ;SE APAGA LA PANTALLA
				CALL 	CMD

;SE LIMPIA EL DISPLAY 


				MOVLW	B'00000001';SE LIMPIA EL DISPLAY
				CALL 	CMD


;CONFIGURACION DE ESCRITURA DECREMENTAL-INCREMENTAL 

;I/D = 1 -> INCREMENTAL
;SH  = 0 -> NO PARPADE0 DE TODA LA PANTALLA
; 0  0  0  0  0  1  I/D  SH
	
				MOVLW	B'00000110'
				CALL 	CMD


;SE ENCIENDE LA PANTALLA 

;D = 1 -> DISPLAY-ON  ; D = 0 -> DISPLAY-OFF
;C = 1 -> CURSOR-ON   ; C = 0 -> CURSOR-0FF 
;B = 1 -> PARPADEO-ON ; B = 0 -> PARPADEO-OFF
; 0  0  0  0  1  D  C  B
	
				MOVLW 	DISON;SE PRENDE EL DISPLAY SIN HABILITAR EL CURSOR NI EL PARPADEO DEL MISMO
				CALL 	CMD


;SE POSICIONA EN LA PRIMER POSICION DEL DISPLAY

				MOVLW 	HOME;SE 
				CALL 	CMD

				RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
;SUBRUTINA DE ENVIO DE DATOS
DATO:
				BANKSEL LATB
				MOVWF 	LATB			;PARA ENVIAR UN DATO PIRMERO SE MANDA EL DATO AL PUERTO
				BSF 	RS		;LUEGO SE PONE EN UNO RS POR MENOS DE 5MS
				NOP
				NOP
				NOP		
				BSF 	EN		;SE COLOCA UNO EN ENEABLE POR MENOS DE 5MS
				CALL 	RETARDO5MS		;Y POR ULTIMO SE PONE CERO EN ENEABLE
				BCF 	EN
				RETURN			
			
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
;SUBRUTINA DE ENVIO DE COMANDOS		
CMD:
				BANKSEL LATB
				MOVWF 	LATB
				BCF 	RS
				BSF 	EN
				CALL 	RETARDO5MS
				BCF 	EN
				RETURN		
				
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; S U B R U T I N A  D E   R E T A R D O 1 SEGUNDO
RETARDO_1SEG:	
			
			MOVLW	.80 ;80	
			MOVWF	NUM3

OTRA1:		MOVLW	.200
			MOVWF	NUM2

OTRAR:			MOVLW	.166
			MOVWF	NUM1
			DECFSZ	NUM1,F
			GOTO	$-1
			DECFSZ	NUM2
			GOTO	OTRAR

			DECFSZ	NUM3
			GOTO	OTRA1
			RETURN	
			
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	


RETARDO5MS 
			MOVLW	D'1'
			MOVWF	NUM3

OTRA25		MOVLW	D'100'
			MOVWF	NUM2


OTRA15		MOVLW	D'166'
			MOVWF	NUM1
OTRA5		DECFSZ	NUM1,F
			GOTO  	OTRA5

			DECFSZ	NUM2,F
			GOTO  	OTRA15

			DECFSZ	NUM3,F
			GOTO  	OTRA25
			RETURN
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A