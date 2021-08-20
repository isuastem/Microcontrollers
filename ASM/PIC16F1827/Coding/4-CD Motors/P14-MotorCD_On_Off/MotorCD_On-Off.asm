;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	INCLUDE <P16F1827.INC> 					;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;P A L A B R A   D E   C O N F I G U R A C I O N

       __CONFIG   _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
       __CONFIG   _CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON  & _LVP_OFF	

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;E L I M I N A C I O N  D E  M E N S A J E S  D E  C O M P I L A C I O N

	ERRORLEVEL  -207            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 207
	ERRORLEVEL  -302            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302
	ERRORLEVEL  -305            				; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 305

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;D E C L A R A C I O N  D E  R E G I S T R O S  D E  P R O P O S I T O  G E N E R A L


;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR EN  SECCION DE BANCO 2 (LATB)
	CBLOCK	0X120							
	NUM1,NUM2,NUM3
	ENDC

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;D E C L A R A C I O N  D E  E N T R A D A S  Y  S A L I D A S  E N  C O D I G O

   #DEFINE B_ARRANQUE		PORTA,0
   #DEFINE B_PARO		    PORTA,1
 


   #DEFINE SALIDA1     		LATB,0
   #DEFINE SALIDA2     		LATB,1

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;V E C T O R  D E  I N I C I A L I Z A C I O N
	ORG	0X00
	GOTO CONFIGURACION						;DECLARO EL VECTOR DE INICIO O RESET

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;V E C T O R  D E  I N T E R R U P C I O N
	ORG 0X04							; DECLARO EL VECTOR DE INTERRUPCION

	RETFIE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;C O N F I G U R A C I O N  D E  E N T R A D A S  Y  S A L I D A S

CONFIGURACION:		
		BANKSEL	OSCCON		
		MOVLW	B'11110000'		;CONFIGURO EL REGISTRO OSCCON
		MOVWF	OSCCON 			;B7=SPLLEN:4xPLL ON/ B6-3=ICRF:32MHz/ B2:0/ B1-0=SCS: CLOCK DETER BY FOSC

	
		BANKSEL	APFCON0
		MOVLW	B'01111111'		;CONFIGURO LOS REGISTROS	APFCON0 Y APFCON1
		MOVWF	APFCON0
			
		BANKSEL	APFCON1
		MOVLW	B'00000000'
		MOVWF	APFCON1
		
		BANKSEL ANSELB
		CLRF 	ANSELB 			;DESHABILITO LOS CANALES ANALOGICOS
		CLRF 	ANSELA 

		BANKSEL	TRISB	
		CLRF 	TRISB			;CONFIGURO TRISB COMO SALIDA PARA EL MOTOR
				
		MOVLW 	B'11111111'
		MOVWF 	TRISA     		;CONFIGURO TRISA COMO ENTRADA PARA LOS BOTONES

		BANKSEL LATB
	    	CLRF 	LATA			;LIMPIO LOS REGISTROS A UTILIZAR PARA EVITAR LATCH
	    	CLRF 	LATB

		GOTO 	INICIO

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; C O N T R O L  D E  U N  M O T O R D E  C D
; P R O G R A M A  P R I N C I P A L

INICIO
	BANKSEL PORTA
	BTFSS	B_ARRANQUE
	GOTO	$-1
	BANKSEL LATB
	GOTO	ARRANQUE

ARRANQUE
	BSF	SALIDA1
	BCF	SALIDA2

PARO
	BANKSEL	PORTA
	BTFSS	B_PARO
	GOTO	$-1
	BANKSEL	LATB
	BCF	SALIDA1
	BCF	SALIDA2
	GOTO	INICIO

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A S

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; S U B R U T I N A  D E   R E T A R D O

RETARDO_5mS:
			MOVLW	.5 	
			MOVWF	NUM3

OTRA1M:		
			MOVLW	.8
			MOVWF	NUM2

OTRA0M:		
			MOVLW	.46
			MOVWF	NUM1

			DECFSZ	NUM1,F
			GOTO	$-1

			DECFSZ	NUM2,F
			GOTO	OTRA0M

			
			DECFSZ	NUM3,F
			GOTO	OTRA1M

			RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A