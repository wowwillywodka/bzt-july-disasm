; $09761A..$0976BB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: slide toward local cell 16, at most one cell per axis per call, constrained by floor boundaries.
        ifne *-$9761A
        fail "ROM start moved"
        endif

UpdateMapWindowOrigin:
; At most one cell per axis PER CALL; frame-end and movement code can both call this routine.
        move.w       rPlayerX(a6), d0                              ; $09761A
        move.w       rPlayerY(a6), d1                              ; $09761E
        move.w       rMapWindowOriginX(a6), d2                     ; $097622
        move.w       rMapWindowOriginY(a6), d3                     ; $097626
        movem.w      d0-d3, -(a7)                                  ; $09762A
        cmpi.w       #$20, rCurrentFloorWidth(a6)                  ; $09762E
        bcs.b        loc_09766C                                    ; $097634
        cmpi.b       #$10, rPlayerX(a6)                            ; $097636
        beq.b        loc_09766C                                    ; $09763C
        bcs.b        loc_09765A                                    ; $09763E
        move.w       rCurrentFloorWidth(a6), d0                    ; $097640
        subi.w       #$20, d0                                      ; $097644
        cmp.w        rMapWindowOriginX(a6), d0                     ; $097648
        beq.b        loc_09766C                                    ; $09764C
        addq.w       #$1, rMapWindowOriginX(a6)                    ; $09764E
        subi.w       #$100, rPlayerX(a6)                           ; $097652
        bra.b        loc_09766C                                    ; $097658

loc_09765A:
        cmpi.w       #$0, rMapWindowOriginX(a6)                    ; $09765A
        beq.b        loc_09766C                                    ; $097660
        subq.w       #$1, rMapWindowOriginX(a6)                    ; $097662
        addi.w       #$100, rPlayerX(a6)                           ; $097666

loc_09766C:
        cmpi.w       #$20, rCurrentFloorHeight(a6)                 ; $09766C
        bcs.b        loc_0976AA                                    ; $097672
        cmpi.b       #$10, rPlayerY(a6)                            ; $097674
        beq.b        loc_0976AA                                    ; $09767A
        bcs.b        loc_097698                                    ; $09767C
        move.w       rCurrentFloorHeight(a6), d0                   ; $09767E
        subi.w       #$20, d0                                      ; $097682
        cmp.w        rMapWindowOriginY(a6), d0                     ; $097686
        beq.b        loc_0976AA                                    ; $09768A
        addq.w       #$1, rMapWindowOriginY(a6)                    ; $09768C
        subi.w       #$100, rPlayerY(a6)                           ; $097690
        bra.b        loc_0976AA                                    ; $097696

loc_097698:
        cmpi.w       #$0, rMapWindowOriginY(a6)                    ; $097698
        beq.b        loc_0976AA                                    ; $09769E
        subq.w       #$1, rMapWindowOriginY(a6)                    ; $0976A0
        addi.w       #$100, rPlayerY(a6)                           ; $0976A4

loc_0976AA:
        movem.w      (a7)+, d0-d3                                  ; $0976AA
        cmp.w        rPlayerX(a6), d0                              ; $0976AE
        bne.b        ShiftWorldRelativeCoordinates                 ; $0976B2
        cmp.w        rPlayerY(a6), d1                              ; $0976B4
        bne.b        ShiftWorldRelativeCoordinates                 ; $0976B8
        rts                                                        ; $0976BA
        ifne *-$976BC
        fail "ROM end moved"
        endif
