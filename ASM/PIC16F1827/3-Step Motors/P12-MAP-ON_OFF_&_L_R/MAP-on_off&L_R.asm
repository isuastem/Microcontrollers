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

	CBLOCK	0X120							;DECLARO LOS REGISTROS DE PROPOSITO GENERAL A USAR (VARIABLES)
	NUM1,NUM2,NUM3,CAMBIO
	ENDC

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;D E C L A R A C I O N  D E  E N T R A D A S  Y  S A L I D A S  E N  C O D I G O

   #DEFINE B_ARRANQUE       PORTA,0
   #DEFINE B_PARO           PORTA,1
 
   #DEFINE B_IZQUIERDA      PORTA,2
   #DEFINE B_DERECHA        PORTA,3
   
   #DEFINE B_INCREMENTAL    PORTA,6
   #DEFINE B_DECREMENTAL    PORTA,7
 

   #DEFINE ROJO     		LATB,0
   #DEFINE CAFE     		LATB,1
   #DEFINE AMARILLO 		LATB,2
   #DEFINE NARANJA  		LATB,3

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

	ORG	0X00
	GOTO CONFIGURACION					;DECLARO EL VECTOR DE INICIO O RESET

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

	ORG	0X04	
	RETFIE							; DECLARO EL VECTOR DE INTERRUPCION

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;C O N F I G U R A C I O N  D E  E N T R A D A S  Y  S A L I D A S

CONFIGURACION:		
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
			    CLRF TRISB		;CONFIGURO TRISB COMO SALIDA PARA LAS BOBINAS
				
				MOVLW B'11111111'
				MOVWF TRISA     ;CONFIGURO TRISA COMO ENTRADA PARA MIS BOTONES

					BANKSEL LATB
                CLRF LATB       ;ELIMINO POSIBLE BASURA EN EL PUERTO B
					
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-		
; C O N T R O L  D E  U N  M O T O R  A  P A S O S
; P R O G R A M A   P R I N C I P A L

INICIO_G_D:
APAGO_MOTOR_D:
				BANKSEL LATB
				CLRF	LATB			;APAGO MOTOR
		
				BANKSEL PORTA
                BTFSS B_ARRANQUE        ;PREGUNTO POR EL BOTON DE ARRANQUE
				GOTO $-1                ; ESPERA HASTA QUE SE PRESIONE
                GOTO SEC_DERECHA  ; BOTON PRESIONADO ---> VE A SECUENCIA DERECHA

INICIO_G_I:
APAGO_MOTOR_I:
				BANKSEL LATB
				CLRF	LATB			;APAGO MOTOR
		
				BANKSEL PORTA           
                BTFSS B_ARRANQUE        ;PREGUNTO POR EL BOTON DE ARRANQUE
				GOTO $-1                ; ESPERA HASTA QUE SE PRESIONE
                GOTO SEC_IZQUIERDA      ; BOTON PRESIONADO ---> VE A SECUENCIA IZQUIERDA


;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; R U T I N A  D E  G I R O   A  L A  I Z Q U I E R D A
SEC_DERECHA:
				BANKSEL LATB

				BSF  AMARILLO		;ENCIENDO EL PIN PORTB,2, BOBINA DE INICIO.
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  AMARILLO		;APAGO EL PIN PORTB,2
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
						
				BSF  CAFE			;ENCIENDO EL PIN PORTB,1
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  CAFE			;APAGO EL PIN PORTB,1
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS

				BSF  ROJO			;ENCIENDO EL PIN PORTB,0
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  ROJO			;APAGO EL PIN PORTB,0
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
 
				BSF  NARANJA		;ENCIENDO EL PIN PORTB,3
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  NARANJA		;APAGO EL PIN PORTB,3
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS

				BANKSEL PORTA
				BTFSC 	B_PARO		    ;PREGUNTO POR EL BOTON DE PARO
				GOTO	APAGO_MOTOR_D   ;VE A PARO DE SECUENCIA DERECHA

				BTFSS	B_DERECHA	    ;PREGUNTO POR EL BOTON DE DERECHA
				GOTO 	SEC_DERECHA     ;SI NO ESTA PRESIONADO CONTINUA CON LA SECUENCIA DERECHA
				GOTO	SEC_IZQUIERDA   ; BOTON PRESIONADO ---> VE A SECUENCIA IZQUIERDA

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; R U T I N A  D E  G I R O   A  L A  D E R E C H A
SEC_IZQUIERDA:
				BANKSEL LATB

				BSF  NARANJA		;ENCIENDO EL PIN PORTB,3, BOBINA DE INICIO.
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  NARANJA		;APAGO EL PIN PORTB,3
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
						
				BSF  ROJO			;ENCIENDO EL PIN PORTB,0
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  ROJO			;APAGO EL PIN PORTB,0
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS

				BSF  CAFE			;ENCIENDO EL PIN PORTB,1
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  CAFE			;APAGO EL PIN PORTB,1
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
 
				BSF  AMARILLO		;ENCIENDO EL PIN PORTB,2
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS
				BCF  AMARILLO		;APAGO EL PIN PORTB,2
				CALL RETARDO_15MS	;LLAMO UN RETARDO DE 15 MILISEGUNDOS

				BANKSEL PORTA
				BTFSC 	B_PARO		     ;PREGUNTO POR EL BOTON DE PARO
				GOTO	APAGO_MOTOR_I    ;VE A PARO DE SECUENCIA IZQUIERDA

				BTFSS	B_IZQUIERDA	    ;PREGUNTO POR EL BOTON DE IZQUIERDA
				GOTO 	SEC_IZQUIERDA    ;SI NO ESTA PRESIONADO CONTINUA CON LA SECUENCIA IZQUIERDA
				GOTO	SEC_DERECHA      ; BOTON PRESIONADO ---> VE A SECUENCIA DERECHA

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-	
; S U B R U T I N A S

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
; S U B R U T I N A  D E   R E T A R D O

RETARDO_15MS
			MOVLW	.15 	
			MOVWF	NUM3

OTRA1:		MOVLW	.7
			MOVWF	NUM2

OTRA:		MOVLW	.46
			MOVWF	NUM1
			DECFSZ	NUM1,F
			GOTO	$-1
			DECFSZ	NUM2
			GOTO	OTRA

			
			DECFSZ	NUM3
			GOTO	OTRA1
			RETURN

;_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	END 		;D I R E C T R I Z   D E   F I N A L   D E   P R O G R A M A