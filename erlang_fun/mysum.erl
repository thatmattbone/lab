-module(mysum).
-export([sum_normal/1, sum_tail/1]).

sum_normal([H|T]) -> H + sum_normal(T);
sum_normal([]) -> 0.

% accumulator helper function
sum_tail([H|T], Accum) -> sum_tail(T, H + Accum);
sum_tail([], Accum) -> Accum.

sum_tail([H|T]) -> sum_tail(T, H);
sum_tail([]) -> 0.
