-module(exercise_2_18).
-export([join/2, concat/1, concat/2,  member/2, merge_sort/1, quick_sort/1, insertion_sort/1, 
        perms/1, mult/2, test/0]).


test() ->
    "hello" = join("he","llo"),
    "goodbye" = concat(["goo","d","","by","e"]),
    true = member(2,[2,0,0,1]),
    false = member(20,[2,0,0,1]),
    [1,2,5,7,8,9,10,11] = exercise_2_18:merge_sort([2,9,11,5,7,1,8,10]),
    [1,2,3,4,5,6,7,8,9] = exercise_2_18:quick_sort([7,4,3,5,6,8,1,3,2,9]),
    [1,2,3,4,5,6,7,8,9] = insertion_sort([2,6,3,7,9,5,1,4,8]),
    [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] = perms([1,2,3]),
    ok.

join([], Ys) ->
    Ys;
join(Xs, []) ->
    Xs;
join([X|Xs],Ys) -> 
    [ X | join(Xs,Ys) ].



concat([]) ->
    [];
concat(Xs) ->
    concat([], Xs).
concat( Acc, []) ->
    Acc;
concat( Acc, [X|Xs]) ->
    concat( join(Acc, X), Xs).



member(_N, []) ->
    false;
member(_N, [ _N | _Ys ]) ->
    true;
member(N, [ _M | Ys ]) ->
    member(N, Ys).



merge_sort([]) ->
    [];
merge_sort([X| []])  ->
    [X];
merge_sort(Xs) when length(Xs) > 0 ->
    Length = length(Xs),
    List1 = lists:sublist(Xs, 1, Length div 2),
    List2 = lists:sublist(Xs, (Length div 2)+1, Length),
    Left = merge_sort(List1),
    Right = merge_sort(List2),
    merge(Left, Right).

merge ([], []) ->
    [];
merge([], Ys) ->
    Ys;
merge(Xs,[]) ->
    Xs;
merge([X|Xs], [Y|Ys]) when X =< Y ->
    concat([ [X],  merge(Xs, [Y|Ys]) ]);
merge([X|Xs], [Y|Ys]) when X > Y ->
    concat([ [Y], merge([X|Xs], Ys) ]).


quick_sort([]) ->
    [];
quick_sort([X|[]]) ->
    [X];
quick_sort([X|Xs]) ->
    quick_sort(X, Xs).

quick_sort(P, []) ->
    [P];
quick_sort(P, Xs) ->
    Left = minors(P,Xs),
    Right = greater(P,Xs),
    concat( [ quick_sort(Left), [P], quick_sort(Right) ] ).


insertion_sort([]) ->
    [];
insertion_sort([X|Xs]) ->
    insert(X,insertion_sort(Xs)).


perms([]) ->
    [[]];
perms(Xs) ->
    perms(Xs,Xs,[]).

perms([],_Xs,Perms) ->
    Perms;
perms([H|Hs],Xs,Perms) ->
    Rest = extract(H,Xs),
    Mult = mult(H,perms(Rest)),
    perms(Hs, Xs, Perms ++ Mult ).

extract(X,Xs) ->
    lists:delete(X,Xs).

mult(_,[]) ->
    [];
mult(X,[Y|Ys]) ->
    join([[X|Y]], mult(X,Ys)).

%%
% Private functions
%%

minors(_, []) ->
    [];
minors(P, [X|[]]) when X < P ->
    [X];
minors(P, [X|[]]) when X >= P ->
    [];
minors(P, [X|Xs]) when X < P ->
    [X | minors(P,Xs)];
minors(P, [X|Xs]) when X >= P ->
    minors(P,Xs).

greater(_, []) ->
    [];
greater(P, [X|[]]) when X > P ->
    [X];
greater(P, [X|[]]) when X =< P ->
    [];
greater(P, [X|Xs]) when X > P ->
    [X | greater(P,Xs)];
greater(P, [X|Xs]) when X =< P ->
    greater(P,Xs).

insert(X,[]) ->
    [X];
insert(X,[H|T]) when X >= H -> 
    [H | insert(X,T)];
insert(X,[H|T]) when X < H -> 
    [X,H|T].
