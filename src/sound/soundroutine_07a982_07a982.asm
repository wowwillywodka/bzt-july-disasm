; $07A982..$07A98F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка одиночной GEMS-команды-опкода $0D (без параметров) в Z80-очередь
        ifne *-$7A982
        fail "ROM start moved"
        endif

SoundRoutine_07A982:
        jsr          BeginGemsCommand(pc)                          ; $07A982
        moveq        #$d, d0                                       ; $07A986
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A988
        jmp          EndGemsCommand(pc)                            ; $07A98C
        ifne *-$7A990
        fail "ROM end moved"
        endif
