; $01B816..$01B865 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Default including charge/return/wander uses walk0. State7 draws4/1 and forces Denpyder bank. State8 uses animation4 frames1..6; draw counters4/3 write ActorZ=$20.
        ifne *-$1B816
        fail "ROM start moved"
        endif

DrawDenpyder:
; Default including charge/return/wander uses walk0. State7 draws4/1 and forces Denpyder bank. State8 uses animation4 frames1..6; draw counters4/3 write ActorZ=$20.
        move.b       ActorState(a0), d7                            ; $01B816
        cmpi.b       #$2, d7                                       ; $01B81A
        beq.b        loc_01B858                                    ; $01B81E
        cmpi.b       #$1, d7                                       ; $01B820
        beq.w        loc_01B848                                    ; $01B824
        cmpi.b       #$5, d7                                       ; $01B828
        beq.w        DrawDenpyderWeaponDeath                       ; $01B82C
        cmpi.b       #$6, d7                                       ; $01B830
        beq.w        DenpyderSkipStateSixDrawing                   ; $01B834
        cmpi.b       #$7, d7                                       ; $01B838
        beq.w        DrawDenpyderDormant                           ; $01B83C
        cmpi.b       #$8, d7                                       ; $01B840
        beq.w        DrawDenpyderWake                              ; $01B844

loc_01B848:
        move.w       #$0, d0                                       ; $01B848
        move.w       #$ffff, d2                                    ; $01B84C
        jsr          DrawActorAnimation.l                          ; $01B850
        rts                                                        ; $01B856

loc_01B858:
        move.w       #$2, d0                                       ; $01B858
        move.w       #$1, d2                                       ; $01B85C
        jmp          DrawActorAnimation.l                          ; $01B860
        ifne *-$1B866
        fail "ROM end moved"
        endif
