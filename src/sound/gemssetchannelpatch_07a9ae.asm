; $07A9AE..$07A9CB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; GEMS-команда $02 (play) + 2 байтных параметра (8,A6) и (12,A6): запись опкода и двух аргументов в Z80-очередь
        ifne *-$7A9AE
        fail "ROM start moved"
        endif

GemsSetChannelPatch:
        jsr          BeginGemsCommand(pc)                          ; $07A9AE
        moveq        #$2, d0                                       ; $07A9B2

loc_07A9B4:
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A9B4
        move.l       $8(a6), d0                                    ; $07A9B8
        jsr          WriteGemsCommandByte(pc)                      ; $07A9BC
        move.l       $c(a6), d0                                    ; $07A9C0
        jsr          WriteGemsCommandByte(pc)                      ; $07A9C4
        jmp          EndGemsCommand(pc)                            ; $07A9C8
        ifne *-$7A9CC
        fail "ROM end moved"
        endif
