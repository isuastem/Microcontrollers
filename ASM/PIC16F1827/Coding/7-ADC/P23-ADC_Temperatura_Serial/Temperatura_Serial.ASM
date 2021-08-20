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
;D E C L A R A C I O N  D E  R P G ' S
CBLOCK 0X70                                 ; DECLARO MIS REGISTROS DE PROPOSITO GENERAL COMO ESPEJEADOS
NUM1,NUM2,NUM3
UNIDADES,DECENAS,CENTENAS,MILLARES
DATOL,DATOH, APUNTADOR
ENDC

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; V E C T O R  D E  I N I C I O	
		ORG	0X00                ;DECLARO EL VECTOR DE INICIO O RESET
			GOTO INICIO						
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; V E C T O R  D E  I N T E R R U P C I O N
	ORG	0X04						
			RETFIE
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
;TABLAS DE DATOS PARA LA SUBRUTINA BINBCD
TABLAU	                                  ;TABLA DE DATOS PARA UNIDADES
			MOVF APUNTADOR,W
			BRW
			RETLW	D'2'
			RETLW	D'6'
			RETLW	D'8'
			RETLW	D'4'
			RETLW	D'2'
			RETLW	D'6'
			RETLW	D'8'
			RETLW	D'4'
			RETLW	D'2'
			RETLW	D'1'

TABLAD									   ;TABLA DE DATOS PARA DECENAS
			MOVF APUNTADOR,W
			BRW
			RETLW	D'1'
			RETLW	D'5'
			RETLW	D'2'
			RETLW	D'6'
			RETLW	D'3'
			RETLW	D'1'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'

TABLAC	                                  ;TABLA DE DATOS PARA CENTENAS
			MOVF APUNTADOR,W
			BRW
			RETLW	D'5'
			RETLW	D'2'
			RETLW	D'1'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
TABLAM                                  ;TABLA DE DATOS PARA MILLARES
			MOVF APUNTADOR,W
			BRW
			RETLW	D'1'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
			RETLW	D'0'
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; C O N F I G U R A C I O N  P R I N C I P A L
INICIO:			
			BANKSEL	OSCCON		; ME CAMBIO DE BANCO A DONDE SE ENCUENTRA EL REGISTRO OSCCON
		MOVLW		B'11110000'	; CONFIGURO EL REGISTRO OSCCON PARA UN OSCILADOR INTERNO 
		MOVWF		OSCCON      ; DE 8 MHZ CON UN PLL X 4 = 32 MHZ (8 MIPS)

			BANKSEL	APFCON0
		MOVLW		B'01111111'		;CONFIGURO LOS REGISTROS PARA LOS PINES INTERCAMBIABLES	
		MOVWF		APFCON0
			
			BANKSEL	APFCON1	        ;CONFIGURO LOS REGISTROS PARA LOS PINES INTERCAMBIABLES	
		MOVLW		B'00000000'
		MOVWF		APFCON1

			BANKSEL ANSELA     
		MOVLW		B'00011111'    ; HABILITO LOS PINES ANALOGICOS DEL PUERTO A (AN0 - AN4)
		MOVWF		ANSELA		
		
			CLRF ANSELB            ; HABILITO LOS PINES ANALOGICOS DEL PUERTO A (AN5 - AN11)
		MOVLW		B'11111110'
		MOVWF		ANSELB		 	
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-			

			BANKSEL TRISA     
		MOVLW		B'00011111'    ; HABILITO LOS PINES  DEL PUERTO A COMO ENTRADAS (RA0 - RA4)
		MOVWF		TRISA		
		
			BANKSEL TRISB           ; HABILITO LOS PINES  DEL PUERTO A COMO ENTRADAS (RB1 - RB7)
		MOVLW		B'11111110'
		MOVWF		TRISB
				 	

    	CLRF DATOH                  ; LIMPIO EL REGISTRO DE RESPALDO DE LA PARTE ALTA DEL RESULTADO DE LA CONVERSION
		CLRF DATOL					; LIMPIO EL REGISTRO DE RESPALDO DE LA PARTE BAJA DEL RESULTADO DE LA CONVERSION

		CALL INIT_UART              ; LLAMO A LA SUBRUTINA DE INICIALIZACION DEL MODULO UART

		CALL INIT_ADC               ; LLAMO A LA SUBRUTINA DE INICIALIZACION DEL MODULO ADC

	

		
START 	

100%=472
x=74.7

x=15.826%

511=100%
x=15.826

x=

		
		CALL ADQUI

		CALL BINBCD
	
		CALL DESPLIEGA

		GOTO START

		
ADQUI	
				 
			CALL 		RETARDO_100MS	;RETARDO DE ADQUISICION	CALL 			SAMPLETIME	;RETARDO DE ADQUISICION
				BANKSEL		ADCON0
			BSF 		ADCON0,ADGO 	;INICIA LA CONVERSION
			BTFSC 		ADCON0,ADGO	;YA SE TERMINO LA CONVERSION?
			GOTO 		$-1 		;NO? PREGUNTA DE NUEVO
				BANKSEL 	ADRESH 		;SI, CONTINUA
			MOVF 		ADRESH,W 	;LEE LA PARTE MAS SIGNIFICATIVA
			MOVWF 		DATOH		;GUARDALO EN DATOH
				BANKSEL 	ADRESL 		;CAMBIO A BANCO1
			MOVF 		ADRESL,W 	;LEE LA PARTE MENOS SIGNIFICATIVA
			MOVWF 		DATOL 		;GUARDALO EN DATOL

		;	BCF STATUS,C
		;	RRF DATOH,F
		;	RRF DATOL,F
	
	
			RETURN

		
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A   D E   C O N V E R S I O N   D E  B I N A R I O   A  B C D

BINBCD 

	CLRF MILLARES
	CLRF UNIDADES
	CLRF DECENAS
	CLRF CENTENAS
	CLRF APUNTADOR
OTRA 
	BTFSS DATOH,7
	GOTO ROTA
	CALL TABLAU
	ADDWF UNIDADES,F
	CALL TABLAD
	ADDWF DECENAS,F
	CALL TABLAC
	ADDWF CENTENAS,F

	MOVF UNIDADES,W
	SUBLW D'10'
	BTFSS STATUS,C
	GOTO MAYOR
	GOTO MENOR
MAYOR 
	INCF DECENAS,F
	MOVLW D'10'
	SUBWF UNIDADES,F
	GOTO DECE
MENOR
	 MOVLW D'10'
	SUBWF UNIDADES,W
	BTFSS STATUS,Z
	GOTO DECE
	GOTO MAYOR

DECE 
	MOVF DECENAS,W
	SUBLW D'10'
	BTFSS STATUS,C
	GOTO MAYORD
	GOTO MENORD
MAYORD
	 INCF CENTENAS,F
	MOVLW D'10'
	SUBWF DECENAS,F
	GOTO CENTE
MENORD
	 MOVLW D'10'
	SUBWF DECENAS,W
	BTFSS STATUS,Z
	GOTO CENTE
	GOTO MAYORD

CENTE
	 MOVF CENTENAS,W
	SUBLW D'10'
	BTFSS STATUS,C
	GOTO MAYORC
	GOTO MENORC

MAYORC
	 INCF MILLARES,F
	MOVLW D'10'
	SUBWF CENTENAS,F
	GOTO MILLA
MENORC
	 MOVLW D'10'
	SUBWF CENTENAS,W
	BTFSS STATUS,Z
	GOTO MILLA
	GOTO MAYORC

MILLA
	 MOVF MILLARES,W
	SUBLW D'10'
	BTFSS STATUS,C
	GOTO MAYORM
	GOTO MENORM
MAYORM 
	MOVLW D'10'
	SUBWF MILLARES,F
	GOTO ROTA
MENORM
	 MOVLW D'10'
	SUBWF MILLARES,W
	BTFSS STATUS,Z
	GOTO ROTA
	GOTO MAYORM

ROTA 
	RLF DATOL,F
	RLF DATOH,F
	INCF APUNTADOR,F
	MOVF APUNTADOR,W
	SUBLW D'10'
	BTFSS STATUS,Z
	GOTO OTRA

BCD_ASCII
	MOVLW 0X30
	ADDWF UNIDADES,F

	MOVLW 0X30
	ADDWF DECENAS,F

	MOVLW 0X30
	ADDWF CENTENAS,F

	MOVLW 0X30
	ADDWF MILLARES,F

	RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A S  D E  V I S U A L I Z A C I O N  D E  D A T O S  S E R I A L
DESPLIEGA

		MOVF MILLARES,W
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

		MOVF CENTENAS,W
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

		MOVF DECENAS,W
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

		MOVLW "."
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS


		MOVF UNIDADES,W
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

		MOVLW " "
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

		MOVLW "*"
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS

	   MOVLW "C"
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS
		MOVLW 0X0D
		BANKSEL TXREG
		MOVWF TXREG
		CALL RETARDO_5MS
	
		CALL RETARDO_1S
	
		RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A   D E   I N I C I A	L I Z A C I O N   D E L   A D C
INIT_ADC:
				
				BANKSEL ADCON0           ; CONFIGURO EL CANAL ANALOGICO - CHS ( BITS 2:6 )
		MOVLW		B'00000001'          ; CONFIGURO EL BIT DE ESTADO DE LA CONVERSIÓN - GO/DONE ( BIT 1)
		MOVWF		ADCON0			 	 ; HABILITO EL BIT DEL MODULO ADC - ADON ( BIT 0)

				BANKSEL ADCON1           ; CONFIGURO EL VREF POSITIVO (VDD) - ADPREF ( BITS 0:1 )
		MOVLW		B'01110000'          ; CONFIGURO EL VREF NEGATIVO (VSS) - ADNREF ( BIT 2 )
		MOVWF		ADCON1			 	 ; SELECCIONO LA FUENTE DE RELOJ (FRC) - ADCS ( BITS 4:6 )
										 ; SELECCIONO EL RESULTADO JUSTIFICADO A LA IZQUIERDA - ADFM ( BIT 7 )
		RETURN
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A   D E   I N I C I A	L I Z A C I O N   D E  L A  U A R T
INIT_UART		
				
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

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A S  D E  R E T A R D O S
RETARDO_1S
			BANKSEL	PORTB
			MOVLW	.10
			MOVWF	NUM3

OTRA1		MOVLW	.200
			MOVWF	NUM2

OTRAR		MOVLW	.166
			MOVWF	NUM1
			DECFSZ	NUM1,F
			GOTO	$-1
			DECFSZ	NUM2
			GOTO	OTRAR

			DECFSZ	NUM3
			GOTO	OTRA1
			RETURN
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		 
RETARDO_100MS
				MOVLW	D'1'
				MOVWF	NUM3

OTRO2			MOVLW	D'4'
				MOVWF	NUM2


OTRO1			MOVLW	D'40' ;16
				MOVWF	NUM1
OTRO			DECFSZ	NUM1,F
				GOTO  	OTRO

				DECFSZ	NUM2,F
				GOTO  	OTRO1

				DECFSZ	NUM3,F
				GOTO  	OTRO2
				RETURN
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		 
RETARDO_5MS 
			BANKSEL PORTB
			MOVLW	D'1'
			MOVWF	NUM3

OTRA25		MOVLW	D'50'
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


    END
