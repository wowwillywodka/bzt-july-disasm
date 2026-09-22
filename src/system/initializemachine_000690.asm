; $000690..$0006DF | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$690
        fail "ROM start moved"
        endif

InitializeMachine:
        lea.l        ExceptionVectors.l, a7                        ; $000690
        move         a7, usp                                       ; $000696
        move.w       #$2700, sr                                    ; $000698
        lea.l        WORK_RAM_BASE.l, a6                           ; $00069C
        tst.w        -$7ffc(a6)                                    ; $0006A2
        bne.b        loc_0006DA                                    ; $0006A6
        jsr          ClearWorkRam.l                                ; $0006A8
        move.w       #$ffff, -$7ffc(a6)                            ; $0006AE
        lea.l        $ff000a.l, a0                                 ; $0006B4
        move.l       #$5f5f5f5f, (a0)+                             ; $0006BA
        move.l       #$5f5f5f5f, (a0)+                             ; $0006C0
        move.b       #$5f, (a0)+                                   ; $0006C6
        clr.b        (a0)+                                         ; $0006CA
        move.w       #$f, ramSoundOptions.l                        ; $0006CC
        clr.w        ramGameOptions.l                              ; $0006D4

loc_0006DA:
        jmp          InitializeHardware.l                          ; $0006DA
        ifne *-$6E0
        fail "ROM end moved"
        endif
