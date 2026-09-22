; $0198B6..$0198CB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active retry after branch $1985C. Separate from preceding retained RTS $198B4.
        ifne *-$198B6
        fail "ROM start moved"
        endif

RetryBeatressMarkerSearch:
; Active retry after branch $1985C. Separate from preceding retained RTS $198B4.
        bsr.w        FindBeatressNeighborMarkerGoal                ; $0198B6
        tst.w        d7                                            ; $0198BA
        beq.b        loc_0198CA                                    ; $0198BC
        st.b         ActorBehaviorByte52(a0)                       ; $0198BE
        st.b         ActorBehaviorByte51(a0)                       ; $0198C2
        bra.w        ChooseLocalPlayerGoalAndArmMelee              ; $0198C6

loc_0198CA:
        rts                                                        ; $0198CA
        ifne *-$198CC
        fail "ROM end moved"
        endif
