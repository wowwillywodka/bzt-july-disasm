; $002FEC..$00303F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$2FEC
        fail "ROM start moved"
        endif

loc_002FEC:
        tst.w        -$7ffe(a6)                                    ; $002FEC
        bne.b        loc_002FEC                                    ; $002FF0
        lea.l        rInventorySlots(a6), a0                       ; $002FF2
        move.l       #$40200000, VDP_CONTROL.l                     ; $002FF6
        jsr          VideoRoutine_01175E.l                         ; $003000
        addq.w       #$4, a0                                       ; $003006
        jsr          VideoRoutine_01175E.l                         ; $003008
        addq.w       #$4, a0                                       ; $00300E
        jsr          VideoRoutine_01175E.l                         ; $003010
        addq.w       #$4, a0                                       ; $003016
        jsr          VideoRoutine_01175E.l                         ; $003018
        addq.w       #$4, a0                                       ; $00301E
        jsr          VideoRoutine_01175E.l                         ; $003020
        addq.w       #$4, a0                                       ; $003026
        jsr          VideoRoutine_01175E.l                         ; $003028
        addq.w       #$4, a0                                       ; $00302E
        jsr          VideoRoutine_01175E.l                         ; $003030
        addq.w       #$4, a0                                       ; $003036
        jsr          VideoRoutine_01175E.l                         ; $003038
        rts                                                        ; $00303E
        ifne *-$3040
        fail "ROM end moved"
        endif
