-module(exercise_2_13).
-export([nub/1, test/0]).

%%
% Public functions
%%

-spec test() -> no_return().
test() ->
    [1,2,3,4,5,6,7,8] = nub([1,2,3,4,4,5,6,6,7,8,8]).


-spec nub(nonempty_list(any())) -> [nonempty_list(any())].
nub(List) ->
    % first we sort the list
    SortedList = sort(List),
    nubs(SortedList).

%%
% Private functions
%%

% nub for sorted list
nubs([]) ->
    [];
nubs([H | _T]) ->
    H.

% I know there is a built-in function to sort but I wanted to try to build my own
sort([]) ->
    [];
sort([ H | [] ]) ->
    [ H ];
sort([ H | T ]) ->
    [ H | T ].
