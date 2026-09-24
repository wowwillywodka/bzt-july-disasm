; $002FEC..$00303F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$2FEC
        fail "ROM start moved"
        endif

; Reviewed call entry (procedure): Waits for VBlank transfer phases, then uploads eight inventory slots to VRAM.
WaitAndUploadEightInventoryIcons:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $002FEC
        bne.b        WaitAndUploadEightInventoryIcons                                    ; $002FF0
        lea.l        rInventorySlots(a6), a0                       ; $002FF2
        move.l       #$40200000, VDP_CONTROL.l                     ; $002FF6
        jsr          UploadInventorySlotIconToVram.l                         ; $003000
        addq.w       #$4, a0                                       ; $003006
        jsr          UploadInventorySlotIconToVram.l                         ; $003008
        addq.w       #$4, a0                                       ; $00300E
        jsr          UploadInventorySlotIconToVram.l                         ; $003010
        addq.w       #$4, a0                                       ; $003016
        jsr          UploadInventorySlotIconToVram.l                         ; $003018
        addq.w       #$4, a0                                       ; $00301E
        jsr          UploadInventorySlotIconToVram.l                         ; $003020
        addq.w       #$4, a0                                       ; $003026
        jsr          UploadInventorySlotIconToVram.l                         ; $003028
        addq.w       #$4, a0                                       ; $00302E
        jsr          UploadInventorySlotIconToVram.l                         ; $003030
        addq.w       #$4, a0                                       ; $003036
        jsr          UploadInventorySlotIconToVram.l                         ; $003038
        rts                                                        ; $00303E
        ifne *-$3040
        fail "ROM end moved"
        endif
