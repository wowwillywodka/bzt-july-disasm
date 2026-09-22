; $098796..$098875 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Compare GLOBAL player cell against two exact doorway cells. Otherwise decide boarding by a one-sided comparison only; no longitudinal or cabin rectangle bound.
        ifne *-$98796
        fail "ROM start moved"
        endif

CheckTrainBoarding:
; Compare GLOBAL player cell against two exact doorway cells. Otherwise decide boarding by a one-sided comparison only; no longitudinal or cabin rectangle bound.
        move.w       rPlayerX(a6), d0                              ; $098796
        move.w       rPlayerY(a6), d1                              ; $09879A
        lsr.w        #$8, d0                                       ; $09879E
        lsr.w        #$8, d1                                       ; $0987A0
        add.w        rMapWindowOriginX(a6), d0                     ; $0987A2
        add.w        rMapWindowOriginY(a6), d1                     ; $0987A6
        move.b       TrainOriginX(a0), d2                          ; $0987AA
        move.b       TrainOriginY(a0), d3                          ; $0987AE
        move.b       d2, d4                                        ; $0987B2
        move.b       d3, d5                                        ; $0987B4
        cmpi.b       #$1, TrainOrientation(a0)                     ; $0987B6
        beq.b        loc_0987D8                                    ; $0987BC
        cmpi.b       #$2, TrainOrientation(a0)                     ; $0987BE
        beq.b        loc_0987E6                                    ; $0987C4
        cmpi.b       #$3, TrainOrientation(a0)                     ; $0987C6
        beq.b        loc_0987F4                                    ; $0987CC
        cmpi.b       #$4, TrainOrientation(a0)                     ; $0987CE
        beq.b        loc_098802                                    ; $0987D4
        rts                                                        ; $0987D6

loc_0987D8:
        addi.b       #$e, d2                                       ; $0987D8
        addq.b       #$1, d3                                       ; $0987DC
        addi.b       #$11, d4                                      ; $0987DE
        addq.b       #$1, d5                                       ; $0987E2
        bra.b        loc_09880E                                    ; $0987E4

loc_0987E6:
        addi.b       #$e, d2                                       ; $0987E6
        subq.b       #$1, d3                                       ; $0987EA
        addi.b       #$11, d4                                      ; $0987EC
        subq.b       #$1, d5                                       ; $0987F0
        bra.b        loc_09880E                                    ; $0987F2

loc_0987F4:
        addq.b       #$1, d2                                       ; $0987F4
        addi.b       #$e, d3                                       ; $0987F6
        addq.b       #$1, d4                                       ; $0987FA
        addi.b       #$11, d5                                      ; $0987FC
        bra.b        loc_09880E                                    ; $098800

loc_098802:
        subq.b       #$1, d2                                       ; $098802
        addi.b       #$e, d3                                       ; $098804
        subq.b       #$1, d4                                       ; $098808
        addi.b       #$11, d5                                      ; $09880A

loc_09880E:
        cmp.b        d0, d2                                        ; $09880E
        bne.b        loc_098824                                    ; $098810
        cmp.b        d1, d3                                        ; $098812
        bne.b        loc_098824                                    ; $098814

loc_098816:
; Player exactly in either doorway: keep state 2 and timer 10, delaying departure for 11 more calls before the next check.
        move.b       #$2, TrainState(a0)                           ; $098816
        move.b       #$a, TrainTimer(a0)                           ; $09881C
        rts                                                        ; $098822

loc_098824:
        cmp.b        d0, d4                                        ; $098824
        bne.b        loc_09882C                                    ; $098826
        cmp.b        d1, d5                                        ; $098828
        beq.b        loc_098816                                    ; $09882A

loc_09882C:
        cmpi.b       #$1, TrainOrientation(a0)                     ; $09882C
        beq.b        loc_09884E                                    ; $098832
        cmpi.b       #$2, TrainOrientation(a0)                     ; $098834
        beq.b        loc_098856                                    ; $09883A
        cmpi.b       #$3, TrainOrientation(a0)                     ; $09883C
        beq.b        loc_09885E                                    ; $098842
        cmpi.b       #$4, TrainOrientation(a0)                     ; $098844
        beq.b        loc_098866                                    ; $09884A
        rts                                                        ; $09884C

loc_09884E:
        subq.b       #$2, d2                                       ; $09884E
        cmp.b        d3, d1                                        ; $098850
        bhi.b        loc_09886E                                    ; $098852
        bra.b        BoardTrainAndTransferPlayer                   ; $098854

loc_098856:
        subq.b       #$2, d2                                       ; $098856
        cmp.b        d3, d1                                        ; $098858
        bcs.b        loc_09886E                                    ; $09885A
        bra.b        BoardTrainAndTransferPlayer                   ; $09885C

loc_09885E:
        subq.b       #$2, d3                                       ; $09885E
        cmp.b        d2, d0                                        ; $098860
        bhi.b        loc_09886E                                    ; $098862
        bra.b        BoardTrainAndTransferPlayer                   ; $098864

loc_098866:
        subq.b       #$2, d3                                       ; $098866
        cmp.b        d2, d0                                        ; $098868
        bcs.b        loc_09886E                                    ; $09886A
        bra.b        BoardTrainAndTransferPlayer                   ; $09886C

loc_09886E:
        move.w       #$0, rTrainPassengerFlag(a6)                  ; $09886E
        rts                                                        ; $098874
        ifne *-$98876
        fail "ROM end moved"
        endif
