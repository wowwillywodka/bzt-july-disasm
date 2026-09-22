; $017CC8..$017CFD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active tail after retained exit trampoline. Both arrival outcomes only refresh target; not a new goal selection.
        ifne *-$17CC8
        fail "ROM start moved"
        endif

CheckBlueDummyGoalAndRefresh:
; Active tail after retained exit trampoline. Both arrival outcomes only refresh target; not a new goal selection.
        move.w       ActorGoalX(a0), d0                            ; $017CC8
        sub.w        ActorX(a0), d0                                ; $017CCC
        asr.w        #$3, d0                                       ; $017CD0
        move.w       ActorGoalY(a0), d1                            ; $017CD2
        sub.w        ActorY(a0), d1                                ; $017CD6
        asr.w        #$3, d1                                       ; $017CDA
        tst.w        d0                                            ; $017CDC
        bpl.b        loc_017CE2                                    ; $017CDE
        neg.w        d0                                            ; $017CE0

loc_017CE2:
        cmpi.w       #$19, d0                                      ; $017CE2
        bgt.w        RefreshEnemyTargetOrExit                      ; $017CE6
        tst.w        d1                                            ; $017CEA
        bpl.b        loc_017CF0                                    ; $017CEC
        neg.w        d1                                            ; $017CEE

loc_017CF0:
        cmpi.w       #$19, d1                                      ; $017CF0
        bgt.w        RefreshEnemyTargetOrExit                      ; $017CF4
        jmp          RefreshEnemyTargetOrExit.l                    ; $017CF8
        ifne *-$17CFE
        fail "ROM end moved"
        endif
