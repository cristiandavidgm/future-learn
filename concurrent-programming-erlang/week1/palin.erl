-module(palin).
-export([client/1, client_loop/1, server/0, server_loop/0, palin/1,nopunct/1,palindrome/1]).


client(ServerPid) ->
    spawn(palin,client_loop,[ServerPid]).

client_loop(ServerPid) -> 
    receive
        {check, Mesage} ->
            ServerPid ! {check, self(), Mesage},
            client_loop(ServerPid);
        flush -> 
            {messages, Messages} = erlang:process_info(self(), messages),
            io:format("\n~p\n",[Messages]),
            client_loop(ServerPid);
        stop -> 
            ok
    end.

server() ->
    spawn(palin,server_loop,[]).

server_loop() ->
    receive
        {check, Pid, Mesage} ->
            case palindrome(Mesage) of
                true ->
                    Result = " is a palindrome";
                false -> 
                    Result = " is NOT a palindrome"
            end,
            Pid ! {result, Mesage++Result},
            server_loop();
        _ ->
            ok
    end.

% palindrome problem
%
% palindrome("Madam I\'m Adam.") = true

palindrome(Xs) ->
    palin(nocaps(nopunct(Xs))).

nopunct([]) ->
    [];
nopunct([X|Xs]) ->
    case lists:member(X,".,\ ;:\t\n\'\"") of
	true ->
	    nopunct(Xs);
	false ->
	    [ X | nopunct(Xs) ]
    end.

nocaps([]) ->
    [];
nocaps([X|Xs]) ->
    [ nocap(X) | nocaps(Xs) ].

nocap(X) ->
    case $A =< X andalso X =< $Z of
	true ->
	    X+32;
	false ->
	    X
    end.

% literal palindrome

palin(Xs) ->
    Xs == reverse(Xs).

reverse(Xs) ->
    shunt(Xs,[]).

shunt([],Ys) ->
    Ys;
shunt([X|Xs],Ys) ->
    shunt(Xs,[X|Ys]).

 
	


