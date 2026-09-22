; $07A8F2..$07A90D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Захват шины, постановка 3-байтного значения (8,A6) в очередь GEMS (3 байта со сдвигом asr.l #8), освобождение
        ifne *-$7A8F2
        fail "ROM start moved"
        endif

WriteGems24BitArgument:
        jsr          BeginGemsCommand(pc)                          ; $07A8F2
        move.l       $8(a6), d0                                    ; $07A8F6
        jsr          WriteGemsCommandByte(pc)                      ; $07A8FA
        asr.l        #$8, d0                                       ; $07A8FE
        jsr          WriteGemsCommandByte(pc)                      ; $07A900
        asr.l        #$8, d0                                       ; $07A904
        jsr          WriteGemsCommandByte(pc)                      ; $07A906
        jmp          EndGemsCommand(pc)                            ; $07A90A
        ifne *-$7A90E
        fail "ROM end moved"
        endif
