; $07A99E..$07A9A5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 6438A] GEMS-звук: обёртка/хелпер команд драйвера (регион 0x64xxx)
        ifne *-$7A99E
        fail "ROM start moved"
        endif

SoundRoutine_07A99E:
        jsr          BeginGemsCommand(pc)                          ; $07A99E
        moveq        #$1c, d0                                      ; $07A9A2
        bra.b        loc_07A954                                    ; $07A9A4
        ifne *-$7A9A6
        fail "ROM end moved"
        endif
