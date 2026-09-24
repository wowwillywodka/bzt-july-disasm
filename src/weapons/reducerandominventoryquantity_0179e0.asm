; $0179E0..$017A8F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reduce quantity in one randomly selected nonzero-ID LOCAL inventory slot; not an HP hit. Saves d0-d6/a0-a6, returns D7.w=0 on stable-inventory paths. See docs/GREY_GREEN_DUMMY.md.
        ifne *-$179E0
        fail "ROM start moved"
        endif

ReduceRandomInventoryQuantity:
; Reduce quantity in one randomly selected nonzero-ID LOCAL inventory slot; not an HP hit. Saves d0-d6/a0-a6, returns D7.w=0 on stable-inventory paths. See docs/GREY_GREEN_DUMMY.md.
        movem.l      d0-d6/a0-a6, -(a7)                            ; $0179E0
        st.b         d7                                            ; $0179E4
        clr.w        d0                                            ; $0179E6
        lea.l        rInventorySlots(a6), a0                       ; $0179E8
        lea.l        rInventoryRandomSelectionScratch(a6), a1                                ; $0179EC
        tst.w        (a0)                                          ; $0179F0
        beq.b        loc_0179FA                                    ; $0179F2
        move.w       #$0, (a1)+                                    ; $0179F4
        addq.w       #$1, d0                                       ; $0179F8

loc_0179FA:
        addq.w       #$4, a0                                       ; $0179FA
        tst.w        (a0)                                          ; $0179FC
        beq.b        loc_017A06                                    ; $0179FE
        move.w       #$1, (a1)+                                    ; $017A00
        addq.w       #$1, d0                                       ; $017A04

loc_017A06:
        addq.w       #$4, a0                                       ; $017A06
        tst.w        (a0)                                          ; $017A08
        beq.b        loc_017A12                                    ; $017A0A
        move.w       #$2, (a1)+                                    ; $017A0C
        addq.w       #$1, d0                                       ; $017A10

loc_017A12:
        addq.w       #$4, a0                                       ; $017A12
        tst.w        (a0)                                          ; $017A14
        beq.b        loc_017A1E                                    ; $017A16
        move.w       #$3, (a1)+                                    ; $017A18
        addq.w       #$1, d0                                       ; $017A1C

loc_017A1E:
        addq.w       #$4, a0                                       ; $017A1E
        tst.w        (a0)                                          ; $017A20
        beq.b        loc_017A2A                                    ; $017A22
        move.w       #$4, (a1)+                                    ; $017A24
        addq.w       #$1, d0                                       ; $017A28

loc_017A2A:
        cmpi.w       #$0, d0                                       ; $017A2A
        beq.w        loc_017A88                                    ; $017A2E
        lsl.w        #$2, d0                                       ; $017A32
        lea.l        InventoryChoiceRowPointers(pc), a0            ; $017A34
        movea.l      (a0, d0.w), a0                                ; $017A38
        jsr          NextRandom.w                                  ; $017A3C
        asr.l        #$8, d2                                       ; $017A40
        andi.w       #$7, d2                                       ; $017A42
        clr.w        d0                                            ; $017A46
        move.b       (a0, d2.w), d0                                ; $017A48
        lea.l        rInventoryRandomSelectionScratch(a6), a1                                ; $017A4C
        add.w        d0, d0                                        ; $017A50
        move.w       (a1, d0.w), d2                                ; $017A52
        move.w       d2, d3                                        ; $017A56
        lea.l        rInventorySlots(a6), a0                       ; $017A58
        mulu.w       #$4, d3                                       ; $017A5C
; Protects whole quantity1. Otherwise subtract max(1,whole_quantity>>2) units, retaining fractional byte. Nonzero item with quantity0 underflows to $FFxx; preserved, not asserted reachable in normal play.
        cmpi.b       #$1, $2(a0, d3.w)                             ; $017A60
        beq.b        loc_017A88                                    ; $017A66
        move.w       $2(a0, d3.w), d0                              ; $017A68
        lsr.w        #$8, d0                                       ; $017A6C
; Second quantity==1 check is redundant after the byte check at $17A60 under stable memory; its nonzero-D7 return is not an ordinary failure path.
        cmpi.w       #$1, d0                                       ; $017A6E
        beq.b        loc_017A8A                                    ; $017A72
        lsr.w        #$2, d0                                       ; $017A74
        tst.w        d0                                            ; $017A76
        bne.b        loc_017A7E                                    ; $017A78
        move.w       #$1, d0                                       ; $017A7A

loc_017A7E:
        lsl.w        #$8, d0                                       ; $017A7E
        sub.w        d0, $2(a0, d3.w)                              ; $017A80
        bsr.w        UploadInventorySlotIconsToVram                           ; $017A84

loc_017A88:
        clr.w        d7                                            ; $017A88

loc_017A8A:
        movem.l      (a7)+, d0-d6/a0-a6                            ; $017A8A
        rts                                                        ; $017A8E
        ifne *-$17A90
        fail "ROM end moved"
        endif
