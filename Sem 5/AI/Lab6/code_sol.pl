% Facts (atomic statements)
% ----------------------------
warm.
raining.
sunny.
pleasant.
% ----------------------------
% Rules (from original English sentences)
% ----------------------------
% Step 1: Convert to FOL (with predicates)
enjoy :- sunny, warm.
strawberry_picking :- warm, pleasant.
not_strawberry_picking :- raining.
wet :- raining.
% ----------------------------
% Step 2: Remove implications (manual for this problem)
% A -> B becomes ~A v B
% remove_implications(implies(A,B), CNF_form).
remove_implications(implies(and(sunny, warm), enjoy), or(not(sunny), or(not(warm),
enjoy))).
remove_implications(implies(and(warm, pleasant), strawberry_picking), or(not(warm),
or(not(pleasant), strawberry_picking))).
remove_implications(implies(raining, not_strawberry_picking), or(not(raining),
not_strawberry_picking)).
remove_implications(implies(raining, wet), or(not(raining), wet)).
