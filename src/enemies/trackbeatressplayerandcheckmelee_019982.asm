; $019982..$0199B9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; If Byte51!=0 refresh goal from GLOBAL player XY, AFTER motion calculation for this tick. Nonzero word56 and signed octagonal distance<$40 permit attack. ActorTarget is not the proximity source.
        ifne *-$19982
        fail "ROM start moved"
        endif

TrackBeatressPlayerAndCheckMelee:
; If Byte51!=0 refresh goal from GLOBAL player XY, AFTER motion calculation for this tick. Nonzero word56 and signed octagonal distance<$40 permit attack. ActorTarget is not the proximity source.
        tst.b        ActorBehaviorByte51(a0)                       ; $019982
        beq.b        loc_019998                                    ; $019986
        move.w       rPlayerX(a6), d0                              ; $019988
        move.w       d0, ActorGoalX(a0)                            ; $01998C
        move.w       rPlayerY(a6), d0                              ; $019990
        move.w       d0, ActorGoalY(a0)                            ; $019994

loc_019998:
        tst.w        ActorCloseGoalFlag(a0)                        ; $019998
        beq.b        loc_0199C4                                    ; $01999C
        move.w       ActorX(a0), d0                                ; $01999E
        sub.w        rPlayerX(a6), d0                              ; $0199A2
        move.w       ActorY(a0), d1                                ; $0199A6
        sub.w        rPlayerY(a6), d1                              ; $0199AA
        jsr          OctagonalDistance.l                           ; $0199AE
        cmpi.w       #$40, d0                                      ; $0199B4
        bge.b        loc_0199C4                                    ; $0199B8
        ifne *-$199BA
        fail "ROM end moved"
        endif
