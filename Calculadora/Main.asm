INCLUDE Irvine32.inc

.data
	var1 Dword ?
	var2 Dword ?
	operacao Dword ?
	resultado Dword ?
	sobra Dword ?
	titulo BYTE "|-----|Calculadora Simples|-----|", 0
	msg BYTE "Entre dois valores inteiros: ", 0
	msgOpcao BYTE "Digite a operacao que voce deseja utilizar: ", 0
	msgOpcao1 BYTE "(1) Soma", 0
	msgOpcao2 BYTE "(2) Diferenca", 0
	msgOpcao3 BYTE "(3) Multiplicacao", 0
	msgOpcao4 BYTE "(4) Divisao", 0
	msg1 BYTE "Soma: ", 0
	msg2 BYTE "Diferenca: ", 0
	msg3 BYTE "Multiplicacao: ", 0
	msg4 BYTE "Divisao: ", 0
	msg5 BYTE "Deseja finalizar o programa? (1 para SIM e 0 para NAO): ", 0
	msgRestante BYTE "Resto da divisao: ", 0
	msgInvalido BYTE "Opcao invalida... ", 0
	msgDivZero BYTE "Erro... Divisao por zero...", 0
	mais BYTE " + ", 0
	menos BYTE " - ", 0
	vezes BYTE " x ", 0
	dividido BYTE " / ", 0
	igual BYTE " = ", 0

.code
main PROC
	; Imprime o T�tulo do Programa
	MOV edx, offset titulo 
	CALL writestring

	inicio:
		; Imprime a mensagem pedindo a entrada de dois valores
		CALL crlf
		MOV edx, offset msg
		CALL writestring
		CALL crlf

		; Armazena o primeiro valor em var1
		CALL readint
		MOV var1, eax

		; Armazena o segundo valor em var2
		CALL readint
		MOV var2, eax
	
	opcao:
		; Imprime as op��es de opera��o da calculadora
		MOV edx, offset msgOpcao1
		CALL writestring
		CALL crlf
		MOV edx, offset msgOpcao2
		CALL writestring
		CALL crlf
		MOV edx, offset msgOpcao3
		CALL writestring
		CALL crlf
		MOV edx, offset msgOpcao4
		CALL writestring
		CALL crlf

		; Imprime a mensagem pedindo a opera��o desejada
		MOV edx, offset msgOpcao
		CALL writestring
		CALL readint
		mov operacao, eax
	
		; Dependendo do valor inserido, ser� selecionada uma opera��o para ser realizada
		CMP eax, 1
		JE soma

		CMP eax, 2
		JE diferenca

		CMP eax, 3
		JE multiplicacao

		CMP eax, 4
		JE divisaoCondicao

		; Caso o valor inserido n�o seja uma das op��es dispon�veis, imprime uma mensagem de erro e pede um novo valor para a op��o
		CALL crlf
		MOV edx, offset msgInvalido
		CALL writestring
		CALL crlf
		JMP opcao

	soma:
		MOV edx, offset msg1
		CALL writestring

		; Opera��o da soma
		MOV eax, var1
		ADD eax, var2
		MOV resultado, eax

		JMP imprimirResultado

	diferenca:
		MOV edx, offset msg2
		CALL writestring

		; Opera��o da diferen�a
		MOV eax, var1
		SUB eax, var2
		MOV resultado, eax

		JMP imprimirResultado

	multiplicacao:
		MOV edx, offset msg3
		CALL writestring

		; Opera��o da multiplica��o
		MOV eax, var1
		MOV ebx, var2
		MUL ebx
		MOV resultado, eax

		JMP imprimirResultado

	; Verifica se os dois valores inseridos s�o zeros
	divisaoCondicao:
		MOV eax, var2
		CMP eax, 0
		JE imprimeErroZero

	divisao:
		MOV edx, offset msg4
		CALL writestring

		; Opera��o da divis�o
		MOV eax, var1
		MOV ebx, var2
		XOR edx, edx
		DIV ebx
		MOV resultado, eax
		MOV sobra, edx

		JMP imprimirResultado

	imprimeErroZero:
		; Imprime a mensagem sobre a divis�o por zero
		MOV edx, offset msgDivZero
		CALL writestring
		CALL crlf

		JMP finalizar

	imprimirResultado:
		; Imprime o primeiro valor
		MOV eax, var1
		CALL writeint

		; Imprime o sinal da opera��o realizada
		MOV eax, operacao
		CMP eax, 1
		JE sinalMais
		CMP eax, 2
		JE sinalMenos
		CMP eax, 3
		JE sinalVezes
		CMP eax, 4
		JE sinalDividido

		sinalMais: 
			MOV edx, offset mais
			JMP imprimirSinal
		sinalMenos:
			MOV edx, offset menos
			JMP imprimirSinal
		sinalVezes:
			MOV edx, offset vezes
			JMP imprimirSinal
		sinalDividido:
			mov edx, offset dividido
		imprimirSinal:
			CALL writestring

		; Imprime o segundo valor
		MOV eax, var2
		CALL writeint

		; Imprime o sinal de igual
		MOV edx, offset igual
		CALL writestring

		; Imprime o resultado da opera��o
		MOV eax, resultado
		CALL writeint
		CALL crlf

		; Verifica se a opera��o realizada foi a de divis�o
		MOV eax, operacao
		CMP eax, 4
		JNE finalizar

		; Imprime o resto da divis�o
		MOV edx, offset msgRestante
		CALL writestring
		mov eax, sobra
		CALL writeint
		CALL crlf

	finalizar:
		; Imprime a mensagem perguntando se o usu�rio deseja finalizar ou n�o o programa
		MOV edx, offset msg5
		CALL writestring
		CALL readint

		CMP eax, 0
		JE inicio

		CMP eax, 1
		JE fim

		; Caso o valor inserido seja inv�lido, imprime uma mensagem de erro e pede para entrar com o valor novamente
		CALL crlf
		MOV edx, offset msgInvalido
		CALL writestring
		JMP finalizar
		
	fim:
	exit

main ENDP
END main