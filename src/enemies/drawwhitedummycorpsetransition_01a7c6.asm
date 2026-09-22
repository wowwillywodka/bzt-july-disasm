; $01A7C6..$01A7FD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Each selected transition frame decrements counter BEFORE calling renderer:4 ->4/1; 3/2 ->4/2; 1 ->4/3. CC reuses this code via $1A7FC.
        ifne *-$1A7C6
        fail "ROM start moved"
        endif

DrawWhiteDummyCorpseTransition:
; Each selected transition frame decrements counter BEFORE calling renderer:4 ->4/1; 3/2 ->4/2; 1 ->4/3. CC reuses this code via $1A7FC.
        move.w       #$4, d0                                       ; $01A7C6
        move.w       #$1, d2                                       ; $01A7CA
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A7CE
        jmp          DrawActorAnimation.l                          ; $01A7D2

loc_01A7D8:
        move.w       #$4, d0                                       ; $01A7D8
        move.w       #$2, d2                                       ; $01A7DC
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A7E0
        jmp          DrawActorAnimation.l                          ; $01A7E4

loc_01A7EA:
        move.w       #$4, d0                                       ; $01A7EA
        move.w       #$3, d2                                       ; $01A7EE
        subq.b       #$1, ActorStateCounter(a0)                    ; $01A7F2
        jmp          DrawActorAnimation.l                          ; $01A7F6

loc_01A7FC:
        bra.b        loc_01A7A4                                    ; $01A7FC
        ifne *-$1A7FE
        fail "ROM end moved"
        endif
