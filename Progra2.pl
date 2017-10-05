%Suma todos los valores hasta ese numero
suma(0,0):-!.
suma(Valor,Resultado):- Ant is Valor-1, suma(Ant,AntRes),
    Resultado is Valor + AntRes.

%Dice si la suma de un numero es mayor a otro
sumaMayor(Fijo,Sumado):- suma(Sumado, Resultado), Resultado >= Fijo.

%Dice el numero de fila horizontal de un numero
numeroFilaH(Numero,Fila):- numeroFilaH(Numero,Fila,1).

%Metodo auxiliar de numeroFilaH
numeroFilaH(Numero,Fila,Actual):- sumaMayor(Numero, Actual), Fila is Actual,!.
numeroFilaH(Numero,Fila,Actual):- ActualSig is Actual+1,
    numeroFilaH(Numero, FilaSig,ActualSig), Fila is FilaSig.

%Dice si 2 puntos estÃ¡n en la misma fila horizontal
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


%FIGURAS

%Triangulo

%triangulo hacia arriba
triangulo([P1,P2,P3]) :-
   mismaDiagonal_60(P1,P2),
   mismaFilaH(P2,P3),
   mismaDiagonal_120(P1,P3),!.

%triangulo hacia abajo
triangulo([P1,P2,P3]) :-
  mismaDiagonal_60(P2,P3),
  mismaFilaH(P1,P2),
  mismaDiagonal_120(P1,P3).

%Hexagono
hexagono([P1,P2,P3,P4,P5,P6]):-
    %Recibe la lista ordenada
    mismaFilaH(P1,P2),
    mismaFilaH(P5,P6),
    mismaDiagonal_60(P1,P3),
    mismaDiagonal_60(P6,P4),
    mismaDiagonal_120(P2,P4),
    mismaDiagonal_120(P3,P5).


%ParalelogramoHorizontal_60
paralelogramo([P1,P2,P3,P4]) :-
    mismaFilaH(P1,P2),
    mismaFilaH(P3,P4),
    mismaDiagonal_60(P1,P3),
    mismaDiagonal_60(P2,P4),!.


%ParalelogramoHorizontal_120
paralelogramo([P1,P2,P3,P4]) :-
    mismaFilaH(P1,P2),
    mismaFilaH(P3,P4),
    mismaDiagonal_120(P1,P3),
    mismaDiagonal_120(P2,P4),!.


%Paralelogramo_60_120
paralelogramo([P1,P2,P3,P4]) :-
    mismaDiagonal_60(P1,P3),
    mismaDiagonal_60(P2,P4),
    mismaDiagonal_120(P1,P2),
    mismaDiagonal_120(P3,P4),!.


%Paralelogramo_120_60
paralelogramo([P1,P2,P3,P4]) :-
    mismaDiagonal_60(P1,P2),
    mismaDiagonal_60(P3,P4),
    mismaDiagonal_120(P1,P3),
    mismaDiagonal_120(P2,P4).



%isFigure

is_figure(R,Lista):-
   is_figure(Lista,Acum,_),
   return_list_members(Acum,R).

is_figure([],_,Hole):- Hole = [],!.

is_figure([Head|Tail],[X|Hole],Hole):-
   quick_sort2(Head,Sorted),
   triangulo(Sorted),
   llena_R(R1,Head),
   atom_concat(R1, 'son los vértices de un triangulo', X),
   is_figure(Tail,Hole,_),!.

is_figure([Head|Tail],[X|Hole],Hole):-
   quick_sort2(Head,Sorted),
   hexagono(Sorted),
   llena_R(R1,Head),
   atom_concat(R1, 'son los vértices de un hexágono', X),

   is_figure(Tail,Hole,_),!.

is_figure([Head|Tail],[X|Hole],Hole):-
   quick_sort2(Head,Sorted),
   paralelogramo(Sorted),
   llena_R(R1,Head),
   atom_concat(R1, 'son los vértices de un paralelogramo', X),
   is_figure(Tail,Hole,_),!.

is_figure([Head|Tail],[X|Hole],Hole):-
   llena_R(R1,Head),
   atom_concat(R1, 'no son los vértices de una figura aceptable',X),
   is_figure(Tail,Hole,_),!.




%funcion que llena R
llena_R(R,Lista):-
   R1 = '', llena_R(R,Lista,R1).

llena_R(R,[],R).
llena_R(R,[Head|Tail],R1):-
   atom_concat(R1, Head, R2),
   atom_concat(R2, ' ', R3),
   llena_R(R,Tail,R3).


%Retorna 1 a 1 la lista
return_list_members([X], X):- !.
return_list_members([X|_], X).
return_list_members([_|T], X):-
  return_list_members(T, X).


%Ordenamiento de una lista.
quick_sort2(List,Sorted):-
    q_sort(List,[],Sorted).
    q_sort([],Acc,Acc).
    q_sort([H|T],Acc,Sorted):-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(_,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X>=H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X<H,pivoting(H,T,L,G).
