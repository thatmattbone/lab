-module(ring).
-compile(export_all).

wait() ->
    receive
        die -> void
    end.

for(N, N, F) ->
    [F()];
for(I, N, F) ->
    [F()|for(I+1, N, F)].

max(N) ->
    Max = erlang:system_info(process_limit),
    io:format("Maximum allowed processes:~p~n", [Max]),
    %statistics(runtime),
    %statistics(wall_clock),
    L = for(1, N, fun() -> spawn(fun wait/0) end),
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    % send the die msg to each process we've spawned
    lists:foreach(fun(Pid) -> Pid ! die end, L),
    U1 = Time1 * 1000 / N,
    U2 = Time2 * 1000 / N,
    io:format("Process spawn time=~p (~p) microseconds~n", [U1, U2]).

%%
% Ring stuff
%%

setup_circle(Max) ->
    %io:format("setup circle:~p~n", [self()]),
    receive 
        {next, Next} ->
            forward_or_die(Next, Max)
    end.

forward_or_die(Next, Max) ->
    %io:format("forward or die:~p~n", [self()]),
    receive 
        die -> 
            void;

        {forward, Count} when Count < Max ->
            io:format("~p got count: ~p~n", [self(), Count]),
            Next ! {forward, Count + 1},
            forward_or_die(Next, Max);

        {forward, Count} when Count >= Max ->
            Next ! die
    end.


send_next([ReallyFirst|[First|Rest]]) ->
    ReallyFirst ! {next, First},
    send_next([First|Rest], ReallyFirst).

send_next([First|[Next|Rest]], ReallyFirst) ->
    First ! {next, Next},
    send_next([Next|Rest], ReallyFirst);

send_next([First], ReallyFirst) ->
    io:format("last is: ~p~n", [First]),
    First ! {next, ReallyFirst}.

ring(Num, MaxForwards) ->
    ProcessList = for(1, Num, fun() -> spawn(fun() -> setup_circle(MaxForwards) end) end),
    %send next to all of them
    send_next(ProcessList),
    [First|_] = ProcessList,
    First ! {forward, 0}.
