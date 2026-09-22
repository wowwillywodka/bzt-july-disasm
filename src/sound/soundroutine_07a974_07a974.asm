; $07A974..$07A981 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка одиночной GEMS-команды-опкода $0C (без параметров) в Z80-очередь
        ifne *-$7A974
        fail "ROM start moved"
        endif

SoundRoutine_07A974:
        jsr          BeginGemsCommand(pc)                          ; $07A974
        moveq        #$c, d0                                       ; $07A978
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A97A
        jmp          EndGemsCommand(pc)                            ; $07A97E
        ifne *-$7A982
        fail "ROM end moved"
        endif
