; $07A94E..$07A963 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; GEMS-команда $10 + 1-байтный параметр (8,A6): захват шины, запись опкода и аргумента в очередь, освобождение
        ifne *-$7A94E
        fail "ROM start moved"
        endif

SoundRoutine_07A94E:
        jsr          BeginGemsCommand(pc)                          ; $07A94E
        moveq        #$10, d0                                      ; $07A952

loc_07A954:
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A954
        move.l       $8(a6), d0                                    ; $07A958
        jsr          WriteGemsCommandByte(pc)                      ; $07A95C
        jmp          EndGemsCommand(pc)                            ; $07A960
        ifne *-$7A964
        fail "ROM end moved"
        endif
