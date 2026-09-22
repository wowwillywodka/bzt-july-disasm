; $00DFBA..$00DFDD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Синхронный тик звукового движка GEMS: маскирует IRQ (#$2700), сохраняет все регистры, jsr 0x7ace8 (обновление Z80/GEMS), затем восстанавливает SR в #$2500 или #$2100 по флагу активной игры (-0x53a4,A6)
        ifne *-$DFBA
        fail "ROM start moved"
        endif

SoundRoutine_00DFBA:
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
