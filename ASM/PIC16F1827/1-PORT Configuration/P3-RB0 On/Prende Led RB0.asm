	; NOMBRE DEL PROGRAMADOR
	; FECHA
	; ESTE PROGRAMA PRENDE UN LED EN RB0


	#INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE


	__config	_CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__config	_CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _LVP_OFF 
	

	ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302

	CBLOCK	0X20						;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR (VARIABLES)
	ENDC

	ORG	0X00
	GOTO INICIO						;DECLARO EL VECTOR DE INICIO O RESET

	ORG	0X04	
	RETFIE							; DECLARO EL VECTOR DE INTERRUPCION

							

INICIO:		
					BANKSEL	OSCCON		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				MOVLW		B'11110000'	;CONFIGURO EL REGISTRO OSCCON A 8MHZ CON PLLX4 = 32MHZ
				MOVWF		OSCCON


					BANKSEL	APFCON0		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				MOVLW		B'01111111'	;CONFIGURO EL REGISTRO APFCON0 
				MOVWF		APFCON0         ;PARA LOS PINES INTERCAMBIABLES DEJARLOS COMO DEFAULT
			
					BANKSEL	APFCON1         ;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				MOVLW		B'00000000'	;CONFIGURO EL REGISTRO APFCON1 
				MOVWF		APFCON1		;PARA LOS PINES INTERCAMBIABLES DEJARLOS COMO DEFAULT
		
					BANKSEL ANSELA		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				CLRF ANSELA                     ;CONFIGURO EL REGISTRO ANSELA EN "0"
								;PARA HABILITAR LOS PINES DEL PUERTO A COMO DIGITALES 

					BANKSEL ANSELB		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				CLRF ANSELB                     ;CONFIGURO EL REGISTRO ANSELB EN "0"
								;PARA HABILITAR LOS PINES DEL PUERTO A COMO DIGITALES 

					BANKSEL	TRISB		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
				CLRF TRISB			;CONFIGURO EL PIN RB0 COMO SALIDA
				
					BANKSEL LATB		;ME DIRECCIONO EN EL BANCO DEL REGISTRO A CONFIGURAR
					

PROGRAMA

				BSF LATB,0                      ;PONGO EN ALTO "1" EL BIT 0 DEL REGISTRO LATB
				GOTO PROGRAMA                   ;REGRESO A PROGRAMA

END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A