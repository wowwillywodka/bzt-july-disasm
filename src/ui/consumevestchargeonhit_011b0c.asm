; $011B0C..$011BB9 | m68k
; Maintained assembly input; no extraction occurs during build.
; Called only by ApplyPlayerDistanceHit in the nonnegative vest-slot mode.
; Spend $100 from slot 7 if more than one unit remains; otherwise clear the
; slot and set its selector to -1. VDP control is set, but this routine does
; not itself write the new count or blank tiles to VDP_DATA.
        ifne *-$11B0C
        fail "ROM start moved"
        endif

ConsumeVestChargeOnHit:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $011B0C
        bne.b        ConsumeVestChargeOnHit                              ; $011B10
        move.w       rBulletProofVestSlotIndex(a6), d0                                ; $011B12
        lsl.w        #$8, d0                                       ; $011B16
        lsl.w        #$1, d0                                       ; $011B18
        addi.w       #$93e0, d0                                    ; $011B1A
        move.w       d0, d5                                        ; $011B1E
        movea.l      #VDP_DATA, a4                                 ; $011B20
        lea.l        rInventorySlots(a6), a0                       ; $011B26
        move.w       rBulletProofVestSlotIndex(a6), d0                                ; $011B2A
        mulu.w       #$4, d0                                       ; $011B2E
        cmpi.w       #$100, $2(a0, d0.w)                           ; $011B32
        bls.b        loc_011B6C                                    ; $011B38
        subi.w       #$100, $2(a0, d0.w)                           ; $011B3A
        move.w       $2(a0, d0.w), -(a7)                           ; $011B40
        move.w       d5, d0                                        ; $011B44
        addi.w       #$68, d0                                      ; $011B46
        move.w       d0, d1                                        ; $011B4A
        andi.w       #$3fff, d1                                    ; $011B4C
        ori.w        #$4000, d1                                    ; $011B50
        swap         d1                                            ; $011B54
        lsr.w        #$8, d0                                       ; $011B56
        lsr.w        #$6, d0                                       ; $011B58
        move.w       d0, d1                                        ; $011B5A
        move.l       d1, VDP_CONTROL.l                             ; $011B5C
        move.w       (a7)+, d0                                     ; $011B62
        subq.w       #$1, d0                                       ; $011B64
        lsr.w        #$8, d0                                       ; $011B66
        addq.w       #$1, d0                                       ; $011B68
        rts                                                        ; $011B6A

loc_011B6C:
        move.w       #$1, rInventorySlotDepletionFlag(a6)                               ; $011B6C
        clr.w        (a0, d0.w)                                    ; $011B72
        clr.w        $2(a0, d0.w)                                  ; $011B76
        move.w       #$f, d6                                       ; $011B7A
        moveq        #$0, d7                                       ; $011B7E
        move.w       d5, d0                                        ; $011B80
        move.w       d0, d1                                        ; $011B82
        andi.w       #$3fff, d1                                    ; $011B84
        ori.w        #$4000, d1                                    ; $011B88
        swap         d1                                            ; $011B8C
        lsr.w        #$8, d0                                       ; $011B8E
        lsr.w        #$6, d0                                       ; $011B90
        move.w       d0, d1                                        ; $011B92
        move.l       d1, VDP_CONTROL.l                             ; $011B94
        lea.l        rInventorySlots(a6), a0                       ; $011B9A
        move.w       #$7, d7                                       ; $011B9E
        adda.w       #$1c, a0                                      ; $011BA2
        cmpi.w       #$3, (a0)                                     ; $011BA6
        beq.b        loc_011BB4                                    ; $011BAA
        move.w       #$ffff, rBulletProofVestSlotIndex(a6)                            ; $011BAC
        rts                                                        ; $011BB2

loc_011BB4:
        move.w       d7, rBulletProofVestSlotIndex(a6)                                ; $011BB4
        rts                                                        ; $011BB8
        ifne *-$11BBA
        fail "ROM end moved"
        endif
