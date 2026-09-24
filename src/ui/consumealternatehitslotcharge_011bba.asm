; $011BBA..$011C71 | m68k
; Maintained assembly input; no extraction occurs during build.
; Spend $100 from the alternate hit slot and draw the new HUD count.
; When at most one unit remains, clear the slot, decrement occupied count,
; clear its icon tiles through VDP_DATA, and reset the selector to -1.
        ifne *-$11BBA
        fail "ROM start moved"
        endif

ConsumeAlternateHitSlotCharge:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $011BBA
        bne.b        ConsumeAlternateHitSlotCharge                              ; $011BBE
        move.w       rAlternateHitSlotIndex(a6), d0                                ; $011BC0
        lsl.w        #$8, d0                                       ; $011BC4
        lsl.w        #$1, d0                                       ; $011BC6
        addi.w       #$93e0, d0                                    ; $011BC8
        move.w       d0, d5                                        ; $011BCC
        movea.l      #VDP_DATA, a4                                 ; $011BCE
        lea.l        rInventorySlots(a6), a0                       ; $011BD4
        move.w       rAlternateHitSlotIndex(a6), d0                                ; $011BD8
        mulu.w       #$4, d0                                       ; $011BDC
        cmpi.w       #$100, $2(a0, d0.w)                           ; $011BE0
        bls.b        loc_011C1E                                    ; $011BE6
        subi.w       #$100, $2(a0, d0.w)                           ; $011BE8
        move.w       $2(a0, d0.w), -(a7)                           ; $011BEE
        move.w       d5, d0                                        ; $011BF2
        addi.w       #$68, d0                                      ; $011BF4
        move.w       d0, d1                                        ; $011BF8
        andi.w       #$3fff, d1                                    ; $011BFA
        ori.w        #$4000, d1                                    ; $011BFE
        swap         d1                                            ; $011C02
        lsr.w        #$8, d0                                       ; $011C04
        lsr.w        #$6, d0                                       ; $011C06
        move.w       d0, d1                                        ; $011C08
        move.l       d1, VDP_CONTROL.l                             ; $011C0A
        move.w       (a7)+, d0                                     ; $011C10
        subq.w       #$1, d0                                       ; $011C12
        lsr.w        #$8, d0                                       ; $011C14
        addq.w       #$1, d0                                       ; $011C16
        jmp          DrawInventoryQuantityDigits.l                            ; $011C18

loc_011C1E:
        move.w       #$1, rInventorySlotDepletionFlag(a6)                               ; $011C1E
        clr.w        (a0, d0.w)                                    ; $011C24
        clr.w        $2(a0, d0.w)                                  ; $011C28
        subq.b       #$1, rOccupiedInventorySlotCount(a6)          ; $011C2C
        move.w       #$f, d6                                       ; $011C30
        moveq        #$0, d7                                       ; $011C34
        move.w       d5, d0                                        ; $011C36
        move.w       d0, d1                                        ; $011C38
        andi.w       #$3fff, d1                                    ; $011C3A
        ori.w        #$4000, d1                                    ; $011C3E
        swap         d1                                            ; $011C42
        lsr.w        #$8, d0                                       ; $011C44
        lsr.w        #$6, d0                                       ; $011C46
        move.w       d0, d1                                        ; $011C48
        move.l       d1, VDP_CONTROL.l                             ; $011C4A

loc_011C50:
        move.l       d7, (a4)                                      ; $011C50
        move.l       d7, (a4)                                      ; $011C52
        move.l       d7, (a4)                                      ; $011C54
        move.l       d7, (a4)                                      ; $011C56
        move.l       d7, (a4)                                      ; $011C58
        move.l       d7, (a4)                                      ; $011C5A
        move.l       d7, (a4)                                      ; $011C5C
        move.l       d7, (a4)                                      ; $011C5E
        dbra         d6, loc_011C50                                ; $011C60
        lea.l        rInventorySlots(a6), a0                       ; $011C64
        clr.w        d7                                            ; $011C68
        move.w       #$ffff, rAlternateHitSlotIndex(a6)                            ; $011C6A
        rts                                                        ; $011C70
        ifne *-$11C72
        fail "ROM end moved"
        endif
