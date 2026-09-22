; $07A990..$07A99D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Постановка одиночной GEMS-команды-опкода $16 (без параметров) в Z80-очередь
        ifne *-$7A990
        fail "ROM start moved"
        endif

SoundRoutine_07A990:
        jsr          BeginGemsCommand(pc)                          ; $07A990
        moveq        #$16, d0                                      ; $07A994
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A996
        jmp          EndGemsCommand(pc)                            ; $07A99A
        ifne *-$7A99E
        fail "ROM end moved"
        endif
