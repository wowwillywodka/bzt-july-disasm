; $0117E4..$011877 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Consume $100 fixed-point units from selected inventory slot and update HUD. <=$100 empties slot but DOES NOT cancel the pending shot. Usage longword increments $100 here and again in exhausted tail. No success boolean. See docs/PLAYER_WEAPONS.md.
        ifne *-$117E4
        fail "ROM start moved"
        endif

ConsumeSelectedItemAndUpdateHud:
; Consume $100 fixed-point units from selected inventory slot and update HUD. <=$100 empties slot but DOES NOT cancel the pending shot. Usage longword increments $100 here and again in exhausted tail. No success boolean. See docs/PLAYER_WEAPONS.md.
        tst.w        -$7ffe(a6)                                    ; $0117E4
        bne.b        ConsumeSelectedItemAndUpdateHud               ; $0117E8
        clr.w        d0                                            ; $0117EA
        move.b       rSelectedInventorySlot(a6), d0                ; $0117EC
        lsl.w        #$8, d0                                       ; $0117F0
        lsl.w        #$1, d0                                       ; $0117F2
        addi.w       #$93e0, d0                                    ; $0117F4
        move.w       d0, d5                                        ; $0117F8
        movea.l      #VDP_DATA, a4                                 ; $0117FA
        lea.l        rInventorySlots(a6), a0                       ; $011800
        clr.w        d0                                            ; $011804
        move.b       rSelectedInventorySlot(a6), d0                ; $011806
        mulu.w       #$4, d0                                       ; $01180A
        addi.l       #$100, rAmmoUsageFixedCounter(a6)             ; $01180E
        cmpi.w       #$100, $2(a0, d0.w)                           ; $011816
        bls.b        ExhaustSelectedItemAndEraseHud                ; $01181C
        subi.w       #$100, $2(a0, d0.w)                           ; $01181E
        cmpi.w       #$300, $2(a0, d0.w)                           ; $011824
        bcc.b        loc_011848                                    ; $01182A
        cmpi.w       #$200, $2(a0, d0.w)                           ; $01182C
        bcs.b        loc_011848                                    ; $011832
        movem.l      d0/a0-a1, -(a7)                               ; $011834
        movea.l      #StatusMessageAmmuNitionIsLow, a0             ; $011838
        jsr          QueueStatusMessage.l                          ; $01183E
        movem.l      (a7)+, d0/a0-a1                               ; $011844

loc_011848:
        move.w       $2(a0, d0.w), -(a7)                           ; $011848
        move.w       d5, d0                                        ; $01184C
        addi.w       #$68, d0                                      ; $01184E
        move.w       d0, d1                                        ; $011852
        andi.w       #$3fff, d1                                    ; $011854
        ori.w        #$4000, d1                                    ; $011858
        swap         d1                                            ; $01185C
        lsr.w        #$8, d0                                       ; $01185E
        lsr.w        #$6, d0                                       ; $011860
        move.w       d0, d1                                        ; $011862
        move.l       d1, VDP_CONTROL.l                             ; $011864
        move.w       (a7)+, d0                                     ; $01186A
        subq.w       #$1, d0                                       ; $01186C
        lsr.w        #$8, d0                                       ; $01186E
        addq.w       #$1, d0                                       ; $011870
        jmp          UiRoutine_020944.l                            ; $011872
        ifne *-$11878
        fail "ROM end moved"
        endif
