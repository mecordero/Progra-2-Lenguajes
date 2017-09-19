%Suma todos los valores hasta ese numero
suma(0,0):-!.
suma(Valor,Resultado):- write('Pasa por aqui'),Ant is Valor-1, suma(Ant,AntRes),
    Resultado is Valor + AntRes.
%Dice si la suma de un numero es mayor a otro
sumaMayor(Fijo,Sumado):- write('Empieza suma  '), suma(Sumado, Resultado),
write('hace la suma  '),Resultado >= Fijo,write('termina la suma  ').

%Dice el numero de fila horizontal de un numero
numeroFila(Numero,Fila,Actual):- write('Primera  '),sumaMayor(Numero, Actual),
    write('Primera2  '),Fila is Actual.
numeroFila(Numero,Fila,Actual):- write('Segunda  '), ActualSig is Actual+1,
    numeroFila(Numero, FilaSig,ActualSig), Fila is FilaSig.
