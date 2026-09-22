; $07A9CC..$07A9DB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 643B8] GEMS-звук: обёртка/хелпер команд драйвера (регион 0x64xxx)
        ifne *-$7A9CC
        fail "ROM start moved"
        endif

SoundRoutine_07A9CC:
        jsr          BeginGemsCommand(pc)                          ; $07A9CC
        moveq        #$0, d0                                       ; $07A9D0
        bra.b        loc_07A9B4                                    ; $07A9D2

loc_07A9D4:
        jsr          BeginGemsCommand(pc)                          ; $07A9D4
        moveq        #$1, d0                                       ; $07A9D8
        bra.b        loc_07A9B4                                    ; $07A9DA
        ifne *-$7A9DC
        fail "ROM end moved"
        endif
