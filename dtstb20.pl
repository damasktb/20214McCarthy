/* dtstb20 Damask Talary-Brown

THIS WORK IS ENTIRELY MY OWN.

The program does <or does not, choose which is appropriate> produce multiple answers.

I have <or I have not, choose which is appropriate> used built-ins.

1. <Number of elements in the list binding Q after executing s1(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s1.>

2. <Number of elements in the list binding Q after executing s2(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s2.>

3. <Number of elements in the list binding Q after executing s3(Q,100)>
<At most 300 characters of clear text on the main idea for the definition of s3.>

4.
<At most 300 characters of clear text on the main idea for the definition of s4.>

5. <Number of elements in the list binding Q after executing s4(Q,500)>
s4(Q,500) uses <number> inferences. */

%--- S1 -----------------------------------------------

%% s1(Q,Max) :- makeTuple(2,3,Max,Q).
s1(Q,Max) :- 	makeTuple(2,3,Max,Tuple), 
				mergeSortP(Tuple,PSorted),
				noUniqueProducts(PSorted,Q),!.

makeTuple(X,Y,Max,[[X,Y,S,P]|T]) :- S is X+Y, S =< Max, !, P is X*Y, Y2 is Y+1, makeTuple(X,Y2,Max,T).
makeTuple(X,Y,Max,T) :- X2 is X+1, Y2 is X2+1, S is X2+Y2, S=<Max, makeTuple(X2,Y2,Max,T).
makeTuple(_,_,_,[]) :- !.

alternates([],[],[]).
alternates([X],[X],[]).
alternates([Lh,Rh|T],[Lh|Lt],[Rh|Rt]) :- alternates(T,Lt,Rt).
 
mergeSortP([],[]).
mergeSortP([X],[X]).
mergeSortP(List,Sorted) :- 	alternates(List,L,R), 
							mergeSortP(L, SortedL), 
							mergeSortP(R, SortedR), 
							mergeP(SortedL,SortedR,Sorted).
mergeP([],R,R).
mergeP(L,[],L).
mergeP([Lh|Lt],[Rh|Rt],[Lh|T]) :-	[_,_,_,P1] = Lh, 
									[_,_,_,P2] = Rh, 
									P1 =< P2, 
									mergeP(Lt,[Rh|Rt],T).
mergeP([Lh|Lt],[Rh|Rt],[Rh|T]) :- 	[_,_,_,P1] = Lh, 
									[_,_,_,P2] = Rh, 
									P1 > P2,  
									mergeP([Lh|Lt],Rt,T).

noUniqueProducts([],[]).
noUniqueProducts([[_,_,_,P],[X2,Y2,S2,P],[X3,Y3,S3,P]|T],[[X3,Y3,S3,P]|L]) :- noUniqueProducts([[X2,Y2,S2,P],[X3,Y3,S3,P]|T],L).
noUniqueProducts([[X1,Y1,S1,P],[X2,Y2,S2,P]|T],[[X1,Y1,S1,P],[X2,Y2,S2,P]|L]) :- noUniqueProducts(T,L).
noUniqueProducts([_|T],Result) :- noUniqueProducts(T,Result).


%------------------------------------------------------




/*
?- consult(<username>).
% <username> compiled 0.00 sec, <...> bytes
true.
?- time(s1(Q,100)).
% <...> inferences, <...> CPU in <...> seconds (100% CPU, <...> Lips)
Q = [[3,4,7,12],[2,6,8,12], <rest of complete list of quadruples>]
?- time(s2(Q,100)).
Q=<...>
<...>
*/

