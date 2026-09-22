; $018E0C..$018E21 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shared CD initializer reached by BOTH Larva and Dog. Set state0, bytes51/52=6/5, then choose goal using inherited A3. Does not initialize counter or SavedXY.
        ifne *-$18E0C
        fail "ROM start moved"
        endif

InitializeLarvaCreatureOrDog:
; Shared CD initializer reached by BOTH Larva and Dog. Set state0, bytes51/52=6/5, then choose goal using inherited A3. Does not initialize counter or SavedXY.
        move.b       #$0, ActorState(a0)                           ; $018E0C
        move.b       #$6, ActorBehaviorByte51(a0)                  ; $018E12
        move.b       #$5, ActorBehaviorByte52(a0)                  ; $018E18
        bra.w        ChooseRandomDoubledRadiusGoal                 ; $018E1E
        ifne *-$18E22
        fail "ROM end moved"
        endif
