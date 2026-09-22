; $07A96C..$07A973 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 64358] GEMS-звук: обёртка/хелпер команд драйвера (регион 0x64xxx)
        ifne *-$7A96C
        fail "ROM start moved"
        endif

SoundRoutine_07A96C:
        jsr          BeginGemsCommand(pc)                          ; $07A96C
        moveq        #$5, d0                                       ; $07A970
        bra.b        loc_07A954                                    ; $07A972
        ifne *-$7A974
        fail "ROM end moved"
        endif
