%Suma todos los valores hasta ese numero
suma(0,0):-!.
suma(Valor,Resultado):- Ant is Valor-1, suma(Ant,AntRes),
    Resultado is Valor + AntRes.
%Dice si la suma de un numero es mayor a otro
sumaMayor(Fijo,Sumado):- suma(Sumado, Resultado), Resultado >= Fijo.

%Dice el numero de fila horizontal de un numero
numeroFilaH(Numero,Fila):- numeroFilaH(Numero,Fila,1).

%Metodo auxiliar de numeroFila
numeroFilaH(Numero,Fila,Actual):- sumaMayor(Numero, Actual), Fila is Actual,!.
numeroFilaH(Numero,Fila,Actual):- ActualSig is Actual+1,
    numeroFilaH(Numero, FilaSig,ActualSig), Fila is FilaSig.

%Dice si 2 puntos están en la misma fila horizontal
mismaFilaH(X,Y):- numeroFilaH(X,Fil1), numeroFilaH(Y,Fil2), Fil1 is Fil2.

%Puntos de inicio y fin de las filas
finFila(Fila,Fin):- suma(Fila, Res), Fin is Res.
inicioFila(Fila,Inicio):- finFila(Fila,Fin), Resta is Fila -1,
    Inicio is Fin - Resta.

%Posicion de un numero en las fila(Diagonal 60)
numeroDiagonal_60(Numero, Diagonal):- numeroFilaH(Numero, Fila),
    inicioFila(Fila, Inicio), numeroDiagonal_60(Numero, Diag, 0, Inicio),
    Diagonal is Diag.
numeroDiagonal_60(Numero, Diagonal, Actual, Inicio):- Numero is Inicio + Actual,
    Diagonal is Actual + 1,!.
numeroDiagonal_60(Numero, Diagonal, Actual, Inicio):- ActualSig is Actual + 1,
    numeroDiagonal_60(Numero, Diag, ActualSig, Inicio), Diagonal is Diag.

mismaDiagonal_60(X,Y):- numeroDiagonal_60(X,Diag1), numeroDiagonal_60(Y,Diag2),
    Diag1 is Diag2.

%Posicion de fin a inicio de un numero las filas (Diagonal 120)
numeroDiagonal_120(Numero, Diagonal):- numeroFilaH(Numero, Fila),
    finFila(Fila, Fin), numeroDiagonal_120(Numero, Diag, 0, Fin),
    Diagonal is Diag.
numeroDiagonal_120(Numero, Diagonal, Actual, Fin):- Numero is Fin - Actual,
    Diagonal is Actual + 1,!.
numeroDiagonal_120(Numero, Diagonal, Actual, Fin):- ActualSig is Actual + 1,
    numeroDiagonal_120(Numero, Diag, ActualSig, Fin), Diagonal is Diag.

mismaDiagonal_120(X,Y):- numeroDiagonal_120(X,Diag1), numeroDiagonal_120(Y,Diag2),
    Diag1 is Diag2.


