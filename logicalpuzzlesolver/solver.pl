:- use_module(library(lists)).

solve_puzzle(Names, Items, Constraints, Result) :-
    permutation(Items, Assigned),
    check_constraints(Constraints, Names, Assigned),
    pair_up(Names, Assigned, Result), !.

check_constraints([], _, _).

check_constraints([C|Cs], Names, Assigned) :-
    check_constraint(C, Names, Assigned),
    check_constraints(Cs, Names, Assigned).

check_constraint(C, Names, Assigned) :-
    sub_string(C, Before, 2, After, "!="),
    sub_string(C, 0, Before, _, Left),
    Start is Before + 2,
    sub_string(C, Start, After, 0, Right),

    atom_string(Name, Left),
    atom_string(Item, Right),

    nth0(Index, Names, Name),
    nth0(Index, Assigned, AssignedItem),

    AssignedItem \= Item.

check_constraint(C, Names, Assigned) :-
    sub_string(C, Before, 1, After, "="),
    \+ sub_string(C, _, _, _, "!="),

    sub_string(C, 0, Before, _, Left),
    Start is Before + 1,
    sub_string(C, Start, After, 0, Right),

    atom_string(Name, Left),
    atom_string(Item, Right),

    nth0(Index, Names, Name),
    nth0(Index, Assigned, Item).

pair_up([], [], []).

pair_up([N|Ns], [P|Ps], [[N,P]|R]) :-
    pair_up(Ns, Ps, R).