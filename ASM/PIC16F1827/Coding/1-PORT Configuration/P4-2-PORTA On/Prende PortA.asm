	; ING. ROBERTO ISAAC SUASTE MARTINEZ
	; 03/05/2013
	; CONFIGURACION GENERAL DEL PIC16F1827


	#INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE


	__config	_CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__config	_CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _LVP_OFF 
	

	ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302

	CBLOCK	0X120							;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR (VARIABLES)
	NUM1,NUM2,NUM3
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

					BANKSEL	TRISA	
				CLRF TRISA		;CONFIGURO PORTB,0 COMO SALIDA
				
					BANKSEL LATA
					

PROGRAMA

				MOVLW B'11101111'
				MOVWF LATA
				
				GOTO PROGRAMA

END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A