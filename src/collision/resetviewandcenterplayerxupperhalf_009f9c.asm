; $009F9C..$00A009 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mirror of the transition helper at $009F80: halve vertical view Z, clear
; target and velocity, then center fractional player X when bit 7 was set.
        ifne *-$9F9C
        fail "ROM start moved"
        endif

ResetViewAndCenterPlayerXUpperHalf:
        asr.w        rPlayerViewOffsetZ(a6)                                    ; $009F9C
        clr.w        rPlayerViewOffsetTargetZ(a6)                                    ; $009FA0
        clr.w        rPlayerViewVerticalVelocity(a6)                                    ; $009FA4
        btst.b       #$7, rPlayerXLow(a6)                               ; $009FA8
        beq.b        loc_009FB6                                    ; $009FAE
        move.b       #$80, rPlayerXLow(a6)                              ; $009FB0

loc_009FB6:
        rts                                                        ; $009FB6

ChoosePlayerAlignmentFromNeighborsA:
        move.b       $1(a0), d3                                    ; $009FB8
        cmpi.b       #$17, (a5, d3.w)                              ; $009FBC
        beq.b        ResetViewAndCenterPlayerYLowerHalf                                    ; $009FC2
        move.b       -$1(a0), d3                                   ; $009FC4
        cmpi.b       #$3f, (a5, d3.w)                              ; $009FC8
        beq.b        ResetViewAndCenterPlayerYUpperHalf                                    ; $009FCE
        move.b       $20(a0), d3                                   ; $009FD0
        cmpi.b       #$47, (a5, d3.w)                              ; $009FD4
        beq.b        ResetViewAndCenterPlayerXUpperHalf                       ; $009FDA
        bra.b        ResetViewAndCenterPlayerXLowerHalf                       ; $009FDC

ChoosePlayerAlignmentFromNeighborsB:
        move.b       -$1(a0), d3                                   ; $009FDE
        cmpi.b       #$17, (a5, d3.w)                              ; $009FE2
        beq.w        ResetViewAndCenterPlayerYLowerHalf                                    ; $009FE8
        move.b       $1(a0), d3                                    ; $009FEC
        cmpi.b       #$3f, (a5, d3.w)                              ; $009FF0
        beq.w        ResetViewAndCenterPlayerYUpperHalf                                    ; $009FF6
        move.b       -$20(a0), d3                                  ; $009FFA
        cmpi.b       #$47, (a5, d3.w)                              ; $009FFE
        beq.b        ResetViewAndCenterPlayerXUpperHalf                       ; $00A004
        bra.w        ResetViewAndCenterPlayerXLowerHalf                       ; $00A006
        ifne *-$A00A
        fail "ROM end moved"
        endif
