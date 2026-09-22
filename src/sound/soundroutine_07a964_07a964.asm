; $07A964..$07A96B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 64350] GEMS-звук: обёртка/хелпер команд драйвера (регион 0x64xxx)
        ifne *-$7A964
        fail "ROM start moved"
        endif

SoundRoutine_07A964:
        jsr          BeginGemsCommand(pc)                          ; $07A964
        moveq        #$12, d0                                      ; $07A968
        bra.b        loc_07A954                                    ; $07A96A
        ifne *-$7A96C
        fail "ROM end moved"
        endif
