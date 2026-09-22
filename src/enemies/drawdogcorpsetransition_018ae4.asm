; $018AE4..$018B27 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; CB/CC: signed counter>=3 ->4/1,2->4/2,1->4/3; no counter writes in draw.
        ifne *-$18AE4
        fail "ROM start moved"
        endif

DrawDogCorpseTransition:
; CB/CC: signed counter>=3 ->4/1,2->4/2,1->4/3; no counter writes in draw.
        move.b       ActorStateCounter(a0), d7                     ; $018AE4
        cmpi.b       #$3, d7                                       ; $018AE8
        bge.b        loc_018AFC                                    ; $018AEC
        cmpi.b       #$2, d7                                       ; $018AEE
        beq.b        loc_018B0A                                    ; $018AF2
        cmpi.b       #$1, d7                                       ; $018AF4
        beq.b        loc_018B18                                    ; $018AF8
        rts                                                        ; $018AFA

loc_018AFC:
        move.w       #$4, d0                                       ; $018AFC
        move.w       #$1, d2                                       ; $018B00
        jmp          DrawActorAnimation.l                          ; $018B04

loc_018B0A:
        move.w       #$4, d0                                       ; $018B0A
        move.w       #$2, d2                                       ; $018B0E
        jmp          DrawActorAnimation.l                          ; $018B12

loc_018B18:
        move.w       #$4, d0                                       ; $018B18
        move.w       #$3, d2                                       ; $018B1C
        jmp          DrawActorAnimation.l                          ; $018B20

loc_018B26:
        bra.b        DrawDogCorpseTransition                       ; $018B26
        ifne *-$18B28
        fail "ROM end moved"
        endif
