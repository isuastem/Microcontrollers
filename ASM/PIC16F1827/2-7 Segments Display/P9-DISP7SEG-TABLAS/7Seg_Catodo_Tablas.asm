	; ING. ROBERTO ISAAC SUASTE MARTINEZ
	; 03/05/2013
	; CONFIGURACION GENERAL DEL PIC16F1827


	#INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE


	__config	_CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__config	_CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _LVP_OFF 
	

	ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302

	CBLOCK	0X120							;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR (VARIABLES)
	NUM1,NUM2,NUM3, APUNTADOR
	ENDC

	ORG	0X00
	GOTO INICIO						;DECLARO EL VECTOR DE INICIO O RESET

	ORG	0X04	
	RETFIE							; DECLARO EL VECTOR DE INTERRUPCION

INICIO:		
					BANKSEL	OSCCON		
				MOVLW		B'11110000'	;CONFIGURO EL REGISTRO OSCCON
				MOVWF		OSCCON


					BANKSEL	APFCON0
				MOVLW		B'01111111'		;CONFIGURO LOS REGISTROS	APFCON0 Y APFCON1
				MOVWF		APFCON0
			
					BANKSEL	APFCON1
				MOVLW		B'00000000'
				MOVWF		APFCON1
		
					BANKSEL ANSELB
				CLRF ANSELB 				;DESHABILITO LOS CANALES ANALOGICOS
				CLRF ANSELA 

					BANKSEL	TRISB	
				CLRF TRISB		;CONFIGURO PORTB,0 COMO SALIDA
				
					BANKSEL LATB
					CLRF LATB

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; P R O G R A M A   P R I N C I P A L
PROGRAMA:				CLRF	APUNTADOR
CONTINUA				MOVF	APUNTADOR,W
						CALL	TABLA
						BANKSEL	LATB
						MOVWF	LATB
						CALL	RETARDO_1S
						INCF	APUNTADOR
						MOVF	APUNTADOR,W
						SUBLW	.16	
						BTFSS	STATUS,Z
						GOTO	CONTINUA		
						GOTO	PROGRAMA			;SALTO A LA ETIQUETA PROGRAMA
				
				
TABLA	        
	BRW
	RETLW	B'00111111' ;0 ; 
	RETLW	B'00000110' ;1 ; 
	RETLW	B'01011011' ;2 ; 
	RETLW	B'01001111' ;3 ; 
	RETLW	B'01100110' ;4 ; 
	RETLW	B'01101101' ;5 ; 
	RETLW	B'01111101' ;6 ; 
	RETLW	B'00000111' ;7 ; 
	RETLW	B'01111111' ;8 ; 	
	RETLW	B'01100111' ;9 ; 
	RETLW	B'01110111' ;A ; 
	RETLW	B'01111100' ;B ; 
	RETLW	B'00111001' ;C ; 
	RETLW	B'01011110' ;D ; 
	RETLW	B'01111001' ;E ;
	RETLW	B'01110001' ;F ; 
	

RETARDO_1S
			MOVLW	.80 ;80	
			MOVWF	NUM3

OTRA1		
			MOVLW	.201
			MOVWF	NUM2

OTRAR			
			MOVLW	.165
			MOVWF	NUM1
			DECFSZ	NUM1,F
			GOTO	$-1
			DECFSZ	NUM2
			GOTO	OTRAR

			DECFSZ	NUM3
			GOTO	OTRA1
			RETURN


END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A