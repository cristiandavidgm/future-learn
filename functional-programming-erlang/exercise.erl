%%
% Student: Cristian David Grajales
%%

-module(exercise).
-export([perimeter/1, area/1, enclose/1, bits/1]).

%%
% I choose, square, circle, and triangle becase they are the most basic figures. since the 
% porpouse of the excercise is to practice pattern matching I guess it is enough.
% To represent the figures I choose to use the side lenghts, I am no using the coordinates but the side length of the sides.
%%

%%
% Perimeter
%%
perimeter({square, X}) ->
    X*4;
perimeter({rectangle, X, Y}) ->
    2*(X+Y);
perimeter({circle, R}) ->
    2*R*math:pi();
% This is a triangle rectangle
perimeter({triangle,X,Y}) ->
    X+Y+hypotenuse(X,Y);
perimeter(_) ->
    {error, <<"figure not supported">>}.

%%
% Area
%%
area({square, X}) ->
    X*X;
area({rectangle, X, Y}) ->
    X*Y;
area({circle, R}) ->
    math:pi()*R*R;
    % This is a triangle rectangle
area({triangle, X, Y}) ->
    H = hypotenuse(X,Y),
    P = perimeter({triangle, X, Y})/2,
    math:sqrt( P * ( P - X ) * ( P - Y ) * ( P - H ) );
area(_) ->
    {error, <<"figure not supported">>}.

%%
% Enclose
% Returns the lenght of the sides of the smallest rectangle that encloses the figure
%%
enclose({square, X}) ->
    {X, X};
enclose({rectangle, X, Y}) ->
    {X, Y};
enclose({circle, R}) ->
    D = 2*R,
    {D, D};
% Given that this is a triangle rectangle the  smallest encolsing rectange will be 
enclose({triangle, A, B}) ->
    {A, B};
enclose(_) ->
    {error, <<"figure not supported">>}.

%%
% Bits
%%
bitsp(0, X) ->
    X;
bitsp(1, X) ->
    X+1;
bitsp(N, X) when N > 0 ->
    bitsp( N div 2, X + ( N rem 2 ) ).
bits(N) ->
    bitsp(N, 0).

%%
% PRIVATE FUNCTIONS
%%
hypotenuse(X,Y) ->
    math:sqrt( first:square(X) + first:square(Y) ).