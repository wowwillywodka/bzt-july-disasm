; $016DEC..$016E51 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Live attack drawing: reached from $16CC8. Split from the preceding retained weapon0B frame body.
        ifne *-$16DEC
        fail "ROM start moved"
        endif

DrawGreyDummyAttack:
; Live attack drawing: reached from $16CC8. Split from the preceding retained weapon0B frame body.
        move.b       ActorStateCounter(a0), d7                     ; $016DEC
        cmpi.b       #$9, d7                                       ; $016DF0
        beq.b        loc_016E28                                    ; $016DF4
        cmpi.b       #$8, d7                                       ; $016DF6
        beq.b        loc_016E28                                    ; $016DFA
        cmpi.b       #$7, d7                                       ; $016DFC
        beq.b        loc_016E36                                    ; $016E00
        cmpi.b       #$6, d7                                       ; $016E02
        beq.b        loc_016E36                                    ; $016E06
        cmpi.b       #$5, d7                                       ; $016E08
        beq.b        loc_016E44                                    ; $016E0C
        cmpi.b       #$4, d7                                       ; $016E0E
        beq.b        loc_016E36                                    ; $016E12
        cmpi.b       #$3, d7                                       ; $016E14
        beq.b        loc_016E36                                    ; $016E18
        cmpi.b       #$2, d7                                       ; $016E1A
        beq.b        loc_016E28                                    ; $016E1E
        cmpi.b       #$1, d7                                       ; $016E20
        beq.b        loc_016E28                                    ; $016E24
        rts                                                        ; $016E26

loc_016E28:
        move.w       #$1, d0                                       ; $016E28
        move.w       #$1, d2                                       ; $016E2C
        jmp          DrawActorAnimation.l                          ; $016E30

loc_016E36:
        move.w       #$1, d0                                       ; $016E36
        move.w       #$2, d2                                       ; $016E3A
        jmp          DrawActorAnimation.l                          ; $016E3E

loc_016E44:
        move.w       #$1, d0                                       ; $016E44
        move.w       #$3, d2                                       ; $016E48
        jmp          DrawActorAnimation.l                          ; $016E4C
        ifne *-$16E52
        fail "ROM end moved"
        endif
