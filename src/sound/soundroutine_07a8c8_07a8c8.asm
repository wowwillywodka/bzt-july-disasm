; $07A8C8..$07A8D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 642B4] GEMS-звук: обёртка/хелпер команд драйвера (регион 0x64xxx)
        ifne *-$7A8C8
        fail "ROM start moved"
        endif

SoundRoutine_07A8C8:
        move.b       #$ff, (a1, d1.w)                              ; $07A8C8
        addq.b       #$1, d1                                       ; $07A8CE
        andi.b       #$3f, d1                                      ; $07A8D0
        ifne *-$7A8D4
        fail "ROM end moved"
        endif
