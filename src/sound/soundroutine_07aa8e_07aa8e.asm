; $07AA8E..$07AA97 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; GEMS-обёртки команд July (=June 6447A)
        ifne *-$7AA8E
        fail "ROM start moved"
        endif

SoundRoutine_07AA8E:
        jsr          BeginGemsCommand(pc)                          ; $07AA8E
        moveq        #$1a, d0                                      ; $07AA92
        bra.w        loc_07A9B4                                    ; $07AA94
        ifne *-$7AA98
        fail "ROM end moved"
        endif
