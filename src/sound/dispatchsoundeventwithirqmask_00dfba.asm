; $00DFBA..$00DFDD | m68k
; Maintained assembly input; no extraction occurs during build.
; Dispatch one D0 sound event through the 68000 PlaySoundEvent table.
; This is not a periodic Z80 tick. SR is set to $2700 during dispatch,
; then assigned $2500 offline or $2100 with link; old SR is not restored.
        ifne *-$DFBA
        fail "ROM start moved"
        endif

DispatchSoundEventWithIrqMask:
        move.w       #$2700, sr                                    ; $00DFBA
        movem.l      d0-d7/a0-a6, -(a7)                            ; $00DFBE
        jsr          PlaySoundEvent.l                              ; $00DFC2
        movem.l      (a7)+, d0-d7/a0-a6                            ; $00DFC8
        tst.w        rLinkRole(a6)                                 ; $00DFCC
        bne.b        loc_00DFD8                                    ; $00DFD0
        move.w       #$2500, sr                                    ; $00DFD2
        rts                                                        ; $00DFD6

loc_00DFD8:
        move.w       #$2100, sr                                    ; $00DFD8
        rts                                                        ; $00DFDC
        ifne *-$DFDE
        fail "ROM end moved"
        endif
