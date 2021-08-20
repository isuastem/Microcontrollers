;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	INCLUDE <P16F1827.INC> ;DECLARO LA LIBRERIA DEL MICROCONTROLADOR CORRESPONDIENTE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;P A L A B R A D E C O N F I G U R A C I O N

	__CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
	__CONFIG _CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _LVP_OFF

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;E L I M I N A C I O N D E M E N S A J E S D E C O M P I L A C I O N

	ERRORLEVEL -207 ; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 207
	ERRORLEVEL -302 ; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 302
	ERRORLEVEL -305 ; ELIMINO DE LA VENTANA DE COMPILACION EL ERROR 305

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;D E C L A R A C I O N D E R E G I S T R O S D E P R O P O S I T O G E N E R A L

;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR EN SECCION DE ESPEJEADOS

	CBLOCK 0X70
	DATO, FLAG
	ANCIC, COPANCIC
	CICTRA1, COPCICTRA1
	CICTRA2, COPCICTRA2
	ENDC

;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR EN SECCION DE BANCO 2 (LATB)
	CBLOCK 0X120
	NUM1,NUM2,NUM3
	ENDC

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;D E C L A R A C I O N D E E N T R A D A S Y S A L I D A S E N C O D I G O

	#DEFINE B_ARRANQUE 	PORTA,0
	#DEFINE B_PARO 		PORTA,1
	#DEFINE B_IZQUIERDA PORTA,2
	#DEFINE B_DERECHA 	PORTA,3
	
	#DEFINE PWM1 LATB,0
	#DEFINE PWM2 LATB,1

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;V E C T O R D E I N I C I A L I Z A C I O N
	ORG 0X00
	GOTO CONFIGURACION ;DECLARO EL VECTOR DE INICIO O RESET

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;V E C T O R D E I N T E R R U P C I O N
	ORG 0X04 ; DECLARO EL VECTOR DE INTERRUPCION
	GOTO INTERR

INTERR
	BANKSEL LATA
	BTFSC FLAG,0
	GOTO PROCESO
	
CARGA
	MOVF ANCIC,W
	MOVWF COPANCIC
	
	MOVF CICTRA1,W
	MOVWF COPCICTRA1
	
	MOVF CICTRA2,W
	MOVWF COPCICTRA2
	
	BANKSEL LATB
	BSF PWM1
	BSF PWM2
	
	BSF FLAG,0
	
PROCESO
	DECFSZ COPANCIC,F
	GOTO DECRE
	BCF FLAG,0
	GOTO FIN
	
DECRE
	BANKSEL LATB
	DECFSZ COPCICTRA1,F
	GOTO NEXT
	BCF PWM1

NEXT
	BANKSEL LATB
	DECFSZ COPCICTRA2,F
	GOTO FIN
	BCF PWM2

FIN
	BCF INTCON,TMR0IF
	RETFIE

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;C O N F I G U R A C I O N D E E N T R A D A S Y S A L I D A S

CONFIGURACION:
	BANKSEL OSCCON
	MOVLW B'11110000' ;CONFIGURO EL REGISTRO OSCCON
	MOVWF OSCCON ;B7=SPLLEN:4xPLL ON/ B6-3=ICRF:32MHz/ B2:0/ B1-0=SCS: CLOCK DETER BY FOSC
	
	
	BANKSEL APFCON0
	MOVLW B'01111111' ;CONFIGURO LOS REGISTROS APFCON0 Y APFCON1
	MOVWF APFCON0
	
	BANKSEL APFCON1
	MOVLW B'00000000'
	MOVWF APFCON1
	
	BANKSEL ANSELB
	CLRF ANSELB ;DESHABILITO LOS CANALES ANALOGICOS
	CLRF ANSELA
	
	BANKSEL TRISB
	CLRF TRISB ;CONFIGURO TRISB COMO SALIDA PARA EL MOTOR
	
	MOVLW B'11111111'
	MOVWF TRISA ;CONFIGURO TRISA COMO ENTRADA PARA LOS BOTONES
	
	
	BANKSEL INTCON
	MOVLW B'11100000' ;B7=GIE:GLOBAL INTERR ENABLED/ B6=PEIE:DISABLE PERIPH INTERR/ B5=TMR0IE:ENABLE TMR0 INTERR/ B4=INTE:DISABLES EXT INTERR
	MOVWF INTCON ;B3=IOCIE:DISABLE INTERR-ON-CHANGE/ B2=TMR0IF:TMR0 OVERFLOW FLAG/ B1=INTF:EXT INTERR FLAG/ B0=IOCIF: INTERR-ON-CHANGE FLAG
	
	BANKSEL OPTION_REG
	MOVLW B'10001000' ;B7=WPUEN:PULL UPS DISABLED/ B6=INTEDG:INTER IN FALLING / B5=TMR0CS:SOURCE FOSC/4
	MOVWF OPTION_REG ;B4=TMR0SE: INCREMENT LOW TO HIGH / B3=PSA: PRESCALER NOT ASIGNED TO TRM0 / B2-0=PREESCALER 1:2
	
	BANKSEL LATB
	CLRF LATA ;LIMPIO LOS REGISTROS A UTILIZAR PARA EVITAR LATCH
	CLRF LATB
	CLRF ANCIC
	CLRF CICTRA1
	CLRF CICTRA2
	CLRF FLAG
	CLRF DATO

	GOTO INICIO

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; C O N T R O L  D E  U N  M O T O R R E D U C T O R  P O R  P W M
;--------------------------------------------------------------
; INICIALIZACION DE VALORES PARA MODULACION POR ANCHO DE PULSO

INICIO
		MOVLW D'200'
		MOVWF ANCIC

		MOVLW D'1'
		MOVWF CICTRA1

		MOVLW D'1'
		MOVWF CICTRA2

		CALL RETARDO_5MS
		
		GOTO ARRANQUE_D

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; P R O G R A M A   P R I N C I P A L

ARRANQUE_D
		BANKSEL PORTA
		BTFSS	B_ARRANQUE
		GOTO	$-1
		BANKSEL LATB
		GOTO	SEC_DER

ARRANQUE_I
		BANKSEL PORTA
		BTFSS	B_ARRANQUE
		GOTO	$-1
		BANKSEL LATB
		GOTO	SEC_IZQ


;----------------------------------------------------------
; R U T I N A  D E  G I R O   A  L A  D E R E C H A

SEC_DER:
		MOVLW	D'200'
		MOVWF	CICTRA1


		MOVLW	D'1'
		MOVWF	CICTRA2

PARO_DER
		BANKSEL PORTA
		BTFSS	B_PARO
		GOTO	GIRO_IZQ
		BANKSEL LATB

		MOVLW D'1'
		MOVWF CICTRA1

		MOVLW D'1'
		MOVWF CICTRA2

		CALL RETARDO_5MS
		GOTO ARRANQUE_D

GIRO_IZQ
		BANKSEL PORTA
		BTFSS	B_IZQUIERDA
		GOTO	PARO_DER
		BANKSEL LATB

		MOVLW D'1'
		MOVWF CICTRA1

		MOVLW D'1'
		MOVWF CICTRA2

		CALL RETARDO_5MS
		GOTO SEC_IZQ

;----------------------------------------------------------
; R U T I N A  D E  G I R O   A  L A  I Z Q U I E R D A

SEC_IZQ:
		MOVLW	D'1'
		MOVWF	CICTRA1


		MOVLW	D'200'
		MOVWF	CICTRA2

PARO_IZQ
		BANKSEL PORTA
		BTFSS	B_PARO
		GOTO	GIRO_DER
		BANKSEL LATB

		MOVLW D'1'
		MOVWF CICTRA1

		MOVLW D'1'
		MOVWF CICTRA2

		CALL RETARDO_5MS
		GOTO ARRANQUE_I

GIRO_DER
		BANKSEL PORTA
		BTFSS	B_DERECHA
		GOTO	PARO_IZQ
		BANKSEL LATB

		MOVLW D'1'
		MOVWF CICTRA1

		MOVLW D'1'
		MOVWF CICTRA2

		CALL RETARDO_5MS
		GOTO SEC_DER

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; S U B R U T I N A S

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; S U B R U T I N A D E R E T A R D O

RETARDO_5MS:
	MOVLW .5
	MOVWF NUM3

OTRA1M:
	MOVLW .8
	MOVWF NUM2

OTRA0M:
	MOVLW .46
	MOVWF NUM1
	
	DECFSZ NUM1,F
	GOTO $-1
	
	DECFSZ NUM2,F
	GOTO OTRA0M
	
	
	DECFSZ NUM3,F
	GOTO OTRA1M

	RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	END ;D I R E C T R I Z D E F I N A L D E P R O G R A M A