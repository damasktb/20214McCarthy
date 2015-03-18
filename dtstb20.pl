/* dtstb20 Damask Talary-Brown

THIS WORK IS ENTIRELY MY OWN.

The program does <or does not, choose which is appropriate> produce multiple answers.

I have not used built-ins.

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

%--- S1 -------------------------- Generate List sorted by sum, sort by product, remove unique products, sort by sum

s1(Q,Max) :- s1(Q,Max,_), !.
s1(Q,Max,Sums) :- 	makeTuple(2,3,Max,Tuple), 
					mergeSortP(Tuple,PSorted),
					noUniqueProducts(PSorted,NoUniques,Sums),
					mergeSortS(NoUniques,Q),
					!.

makeTuple(X,Y,Max,[[X,Y,S,P]|T]) :- X+Y =< Max, !, S is X+Y , P is X*Y, Y2 is Y+1, makeTuple(X,Y2,Max,T).
makeTuple(X,_,Max,T) :- X+X+2=<Max, !, X2 is X+1, Y2 is X2+1, makeTuple(X2,Y2,Max,T).
makeTuple(_,_,_,[]) :- !.

alternates([],[],[]).
alternates([X],[X],[]).
alternates([Lh,Rh|T],[Lh|Lt],[Rh|Rt]) :- alternates(T,Lt,Rt).
 
mergeSortP([],[]).
mergeSortP([X],[X]).
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]]) :- P1=<P2,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],[[X2,Y2,S2,P2],[X1,Y1,S1,P1]]) :- P1>P2,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]]) :- P1=<P2,P2=<P3,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X1,Y1,S1,P1],[X3,Y3,S3,P3],[X2,Y2,S2,P2]]) :- P1=<P3,P3=<P2,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X3,Y3,S3,P3],[X2,Y2,S2,P2],[X1,Y1,S1,P1]]) :- P3=<P2,P2=<P1,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X3,Y3,S3,P3],[X1,Y1,S1,P1],[X2,Y2,S2,P2]]) :- P3=<P1,P1=<P2,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X2,Y2,S2,P2],[X1,Y1,S1,P1],[X3,Y3,S3,P3]]) :- P2=<P1,P1=<P3,!.
mergeSortP([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X2,Y2,S2,P2],[X3,Y3,S3,P3],[X1,Y1,S1,P1]]) :- P2=<P3,P3=<P1,!.
mergeSortP(List,Sorted) :- 	alternates(List,L,R), 
							mergeSortP(L,SortedL), 
							mergeSortP(R,SortedR), 
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

noUniqueProducts([],[],[]).
noUniqueProducts([[X1,Y1,S1,P],[X2,Y2,S2,P],[X3,Y3,S3,P]|T],[[X1,Y1,S1,P]|L], Sums) :- noUniqueProducts([[X2,Y2,S2,P],[X3,Y3,S3,P]|T],L,Sums).
noUniqueProducts([[X1,Y1,S1,P],[X2,Y2,S2,P]|T],[[X1,Y1,S1,P],[X2,Y2,S2,P]|L],Sums) :- noUniqueProducts(T,L,Sums).
noUniqueProducts([[_,_,S,_]|T],Result,[S|Sums]) :- noUniqueProducts(T,Result,Sums).

mergeSortS([],[]).
mergeSortS([X],[X]).
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]]) :- S1=<S2,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2]],[[X2,Y2,S2,P2],[X1,Y1,S1,P1]]) :- S1>S2,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]]) :- S1=<S2,S2=<S3,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X1,Y1,S1,P1],[X3,Y3,S3,P3],[X2,Y2,S2,P2]]) :- S1=<S3,S3=<S2,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X3,Y3,S3,P3],[X2,Y2,S2,P2],[X1,Y1,S1,P1]]) :- S3=<S2,S2=<S1,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X3,Y3,S3,P3],[X1,Y1,S1,P1],[X2,Y2,S2,P2]]) :- S3=<S1,S1=<S2,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X2,Y2,S2,P2],[X1,Y1,S1,P1],[X3,Y3,S3,P3]]) :- S2=<S1,S1=<S3,!.
mergeSortS([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]],[[X2,Y2,S2,P2],[X3,Y3,S3,P3],[X1,Y1,S1,P1]]) :- S2=<S3,S3=<S1,!.
mergeSortS(List,Sorted) :- 	alternates(List,L,R), 
							mergeSortS(L, SortedL), 
							mergeSortS(R, SortedR), 
							mergeS(SortedL,SortedR,Sorted).
mergeS([],R,R).
mergeS(L,[],L).
mergeS([Lh|Lt],[Rh|Rt],[Lh|T]) :-	[_,_,S1,_] = Lh, 
									[_,_,S2,_] = Rh, 
									S1 =< S2, 
									mergeS(Lt,[Rh|Rt],T).
mergeS([Lh|Lt],[Rh|Rt],[Rh|T]) :- 	[_,_,S1,_] = Lh, 
									[_,_,S2,_] = Rh, 
									S1 > S2,
									mergeS([Lh|Lt],Rt,T).



%--- S2 -------------------------- Get list, remove sums corresponding to unique products, sort by product

s2(Q,Max) :- 	s1(S1,Max,Sums),
				mergeSort(Sums,UniquePSList),
				noSumsWUniqueProducts(S1,UniquePSList,NoSumUniques),
				mergeSortP(NoSumUniques, Q),
				!.

mergeSort([],[]).
mergeSort([X],[X]).
mergeSort([X,Y],[X,Y]) :- X=<Y,!.
mergeSort([X,Y],[Y,X]) :- X>Y,!.
mergeSort([X,Y,Z],[X,Y,Z]) :- X=<Y,Y=<Z,!.
mergeSort([X,Y,Z],[X,Z,Y]) :- X=<Z,Z=<Y,!.
mergeSort([X,Y,Z],[Z,Y,X]) :- Z=<Y,Y=<X,!.
mergeSort([X,Y,Z],[Z,X,Y]) :- Z=<X,X=<Y,!.
mergeSort([X,Y,Z],[Y,X,Z]) :- Y=<X,X=<Z,!.
mergeSort([X,Y,Z],[Y,Z,X]) :- Y=<Z,Z=<X,!.
mergeSort(List,Sorted) :- 	alternates(List,L,R), 
							mergeSort(L, SortedL), 
							mergeSort(R, SortedR), 
							merge(SortedL,SortedR,Sorted).
merge([],R,R).
merge(L,[],L).
merge([Lh|Lt],[Lh|Rt],Sorted) :- merge([Lh|Lt],Rt,Sorted).
merge([Rh|Lt],[Rh|Rt],Sorted) :- merge(Lt,[Rh|Rt],Sorted).
merge([Lh|Lt],[Rh|Rt],[Lh|T]) :-	Lh =< Rh, 
									merge(Lt,[Rh|Rt],T).
merge([Lh|Lt],[Rh|Rt],[Rh|T]) :- 	Lh > Rh,  
									merge([Lh|Lt],Rt,T).

noDuplicates([],[]) :- !.
noDuplicates([H,H|T],Unique) :- noDuplicates([H|T], Unique), !.
noDuplicates([H|T],[H|NewTail]) :- noDuplicates(T,NewTail).

isMember(X,[X|_]) :- !.
isMember(X,[_|T]):- isMember(X,T).


noSumsWUniqueProducts([],_,[]) :- !.
noSumsWUniqueProducts([[_,_,S,_]|T], Sums, Result) :- 	isMember(S, Sums), !,
														noSumsWUniqueProducts(T, Sums, Result).
noSumsWUniqueProducts([H|T], Sums, [H|Result]) :- noSumsWUniqueProducts(T, Sums, Result).

%--- S3 -------------------------- Remove duplicate products from the list sort by sum

s3(Q,Max) :- 	s2(S2,Max),
				noDuplicateProducts(S2,UniqueProducts),
				mergeSortS(UniqueProducts,Q), 
				!.

noDuplicateProducts([],[]) :- !.
noDuplicateProducts([[_,_,_,P],[X1,Y1,S1,P],[X2,Y2,S2,P]|T],Unique) :- noDuplicateProducts([[X1,Y1,S1,P],[X2,Y2,S2,P]|T], Unique), !.
noDuplicateProducts([[_,_,_,P],[_,_,_,P]|T],Unique) :- noDuplicateProducts(T, Unique), !.
noDuplicateProducts([H|T],[H|NewTail]) :- noDuplicateProducts(T,NewTail), !.

%--- S4 -------------------------- Remove duplicate sums from the list

s4(Q,Max) :- 	s3(S3,Max),
				noDuplicateSums(S3,Q),
				!.

noDuplicateSums([],[]) :- !.
noDuplicateSums([[_,_,S,_],[X1,Y1,S,P1],[X2,Y2,S,P2]|T],Unique) :- 	noDuplicateSums([[X1,Y1,S,P1],[X2,Y2,S,P2]|T], Unique), !.
noDuplicateSums([[_,_,S,_],[_,_,S,_]|T],Unique) :- noDuplicateSums(T, Unique), !.
noDuplicateSums([H|T],[H|NewTail]) :- noDuplicateSums(T,NewTail), !.

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

