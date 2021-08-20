
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
#INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;P A L A B R A   D E   C O N F I G U R A C I O N
	__config	_CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__config	_CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON  & _LVP_OFF 
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	CBLOCK	0X70
	TECLA
	ENDC




;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	ORG	0X00                ;DECLARO EL VECTOR DE INICIO O RESET
			GOTO INICIO						
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	ORG	0X04	 	        ; DECLARO EL VECTOR DE INTERRUPCION
							
			BANKSEL	RCREG

			MOVF	RCREG,W
			MOVWF	TXREG
			MOVWF   TECLA
									
			RETFIE
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

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
	 				
				MOVLW   B'00000010'
				MOVWF	TRISB			;CONFIGURO RB1 COMO ENTRADA PARA QUE FUNCIONE COMO RX/DT
				
				CLRF	TRISA     		;CONFIGURO PORTA COMO SALIDA


				CALL	UART_INI        ; LLAMO A LA INICIALIZACION DEL MODULO UART
	
			    BANKSEL	 LATB
				
				GOTO START
			
			
START
				
				MOVF TECLA,W ;RECUPERO EL VALOR DEL REGISTRO TECLA Y LO MANDO A W
				SUBLW "1" ;CON UNA RESTA, LO COMPARO CON UNA CONSTANTE1
				BTFSS STATUS,Z ;CHECO SI SON TECLA = CONSTANTE1
				
				GOTO NEXT ;SI NO ES IGUAL, VA A LA SIGUIENTE COMPARACION
				
				BANKSEL LATA
				BSF LATA,0

			
				CLRF TECLA ;BORRO EL CONTENIDO DEL REGISTRO TECLA
				GOTO START ;Y REGRESO AL INICIO DEL CODIGO
				
NEXT				
				
				MOVF TECLA,W ;RECUPERO EL VALOR DEL REGISTRO TECLA Y LO MANDO A W
				SUBLW "2" ;CON UNA RESTA, LO COMPARO CON UNA CONSTANTE1
				BTFSS STATUS,Z ;CHECO SI SON TECLA = CONSTANTE1
				
				GOTO APAGA ;SI NO ES IGUAL, VA A LA SIGUIENTE COMPARACION
				
				BANKSEL LATA
				BSF LATA,1 ;SI ES IGUAL, ENCIENDO PORTA,0

			
				CLRF TECLA ;BORRO EL CONTENIDO DEL REGISTRO TECLA
				GOTO START ;Y REGRESO AL INICIO DEL CODIGO
				
APAGA
			
				MOVF TECLA,W ;RECUPERO EL VALOR DEL REGISTRO TECLA Y LO MANDO A W
				SUBLW "A" ;CON UNA RESTA, LO COMPARO CON UNA CONSTANTE1
				BTFSS STATUS,Z ;CHECO SI SON TECLA = CONSTANTE1
				
				GOTO START ;SI NO ES IGUAL, REGRESO AL INICIO DEL CODIGO
				
				BANKSEL LATA
				CLRF LATA ;SI ES IGUAL, ENCIENDO PORTA,0
			
			
				CLRF TECLA ;BORRO EL CONTENIDO DEL REGISTRO TECLA
				
				GOTO START ;Y REGRESO AL INICIO DEL CODIGO

				

	


;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

		
UART_INI  		
				
					BANKSEL	BAUDCON
				MOVLW	B'00000000'
				MOVWF	BAUDCON
				
					BANKSEL	SPBRGL
				MOVLW D'207'		;9600bdps
				MOVWF SPBRGL

				MOVLW D'00'		;9600bdps
				MOVWF SPBRGH
			
				
					BANKSEL RCSTA
				MOVLW B'10010000'
				MOVWF RCSTA
				
					BANKSEL	PIE1
				BSF PIE1,RCIE

					BANKSEL	INTCON
				MOVLW B'11000000'
				MOVWF INTCON

					BANKSEL	TXSTA
				MOVLW B'00100100'
				MOVWF TXSTA
				
				
				RETURN

END