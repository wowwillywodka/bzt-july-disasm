; $016124..$016151 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Set state0 and goal to GLOBAL local player XY; ST.B writes only HIGH byte of word+$56, making it nonzero. RNG result discarded. Beatress uses this to arm close attack.
        ifne *-$16124
        fail "ROM start moved"
        endif

ChooseLocalPlayerGoalAndArmMelee:
; Set state0 and goal to GLOBAL local player XY; ST.B writes only HIGH byte of word+$56, making it nonzero. RNG result discarded. Beatress uses this to arm close attack.
        move.b       #$0, ActorState(a0)                           ; $016124
        jsr          NextRandom.l                                  ; $01612A
        asr.l        #$4, d2                                       ; $016130
        move.w       d2, d0                                        ; $016132
        andi.w       #$1ff, d0                                     ; $016134
        subi.w       #$100, d0                                     ; $016138
        move.w       rPlayerX(a6), d0                              ; $01613C
        move.w       d0, ActorGoalX(a0)                            ; $016140
        move.w       rPlayerY(a6), d0                              ; $016144
        move.w       d0, ActorGoalY(a0)                            ; $016148
; ST.B sets only the HIGH byte of the word tested at $019998.
        st.b         ActorCloseGoalFlagHigh(a0)                    ; $01614C
        rts                                                        ; $016150
        ifne *-$16152
        fail "ROM end moved"
        endif
