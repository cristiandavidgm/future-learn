-module(assignment). 
-export([perimeter/1,area/1,shape/1,enclose/1,bits/1]).

%%---------------------------------- 
%%------Perimeter------------------- 
%%---------------------------------- 
%% Takes the shape and shape 
%%attributes in finding the perimeter

perimeter({circle,R}) -> 
math:pi()*R*2; 
perimeter({rectangle,H,W})-> 
2*(H+W); 
perimeter({triangle, A,B,C})-> 
A+B+C.

%%---------------------------------- 
%%--------Area---------------------- 
%% Takes shape triangle along with 
%% its attributes

area({triangle, A,B,C})-> 
S=A+B+C/2, 
math:sqrt(S*(S-A)*(S-B)*(S-C)).

%%--------------------------------- 
%%using function shape whic takes 
%%the shape, what to find and 
%%shape parameters.Augmented both 
%% area and perimeter for triangle

shape({triangle,perimeter,A,B,C})-> 
perimeter({triangle,A,B,C}); 
shape({triangle,area, A,B,C}) -> 
area({triangle,A,B,C}).

%%------------------------------- 
%%------Enclose------------------ 
%%enclose returns the minimum 
%%rectangle which can enclose 
%%the shape

enclose({circle,R})-> 
{rectangle, R*2,R*2}; 
enclose({rectangle,H,W}) -> 
{rectangle, H, W}; 
enclose({triangle,A,B,C}) -> 
Ar=area({triangle, A,B,C}), 
Base = max(max(A,B),max(B,C)), 
H= (Ar*2)/Base, 
{rectangle, Base,H}.

%%-------BitsCount-------------------- 
%%When calling bits(10) B get assigned 
%%to "1010" which is a string, this 
%%string is conveted to integer and 
%%is passed to bitsN(Binteger, 0) 
%%bitsN(1010,0)----------------------- 
%%--bitsN(101,0+0)-------------------- 
%%----bitsN(10,1)--------------------- 
%%------bitsN(1,1)-------------------- 
%%-------bitsN(0,2)------------------- 
%%--------sum.------------------------

bits(N) -> 
B=hd(io_lib:format("~.2B", [N])), 
Binteger = list_to_integer([]++B), 
bitsN(Binteger,0).

bitsN(0,Sum) -> 
Sum; 
bitsN(A,S) -> 
bitsN((A div 10), (A rem 10)+S). 