; $01173A..$01175D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Vblank-wait по (-0x7ffe,A6), ставит VDP-команду 0x53e00002 (запись в VRAM @0x93e0) в $C00004, источник (-0x6fa0,A6), 4× bsr 0x1175e с A0+=4 — выгрузка набора HUD-иконок в VRAM
        ifne *-$1173A
        fail "ROM start moved"
        endif

UploadInventorySlotIconsToVram:
; Direct calls and inventory-reset fallthrough both reinitialize A0 from rInventorySlots; no incoming A0 is required.
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $01173A
        bne.b        UploadInventorySlotIconsToVram                           ; $01173E
        lea.l        rInventorySlots(a6), a0                       ; $011740
        move.l       #$53e00002, VDP_CONTROL.l                     ; $011744
        bsr.b        UploadInventorySlotIconToVram                           ; $01174E
        addq.w       #$4, a0                                       ; $011750
        bsr.b        UploadInventorySlotIconToVram                           ; $011752
        addq.w       #$4, a0                                       ; $011754
        bsr.b        UploadInventorySlotIconToVram                           ; $011756
        addq.w       #$4, a0                                       ; $011758
        bsr.b        UploadInventorySlotIconToVram                           ; $01175A
        addq.w       #$4, a0                                       ; $01175C
        ifne *-$1175E
        fail "ROM end moved"
        endif
