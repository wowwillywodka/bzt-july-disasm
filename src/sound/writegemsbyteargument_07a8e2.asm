; $07A8E2..$07A8F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Захват Z80-шины, постановка 1-байтного параметра (8,A6) в очередь GEMS, освобождение шины
        ifne *-$7A8E2
        fail "ROM start moved"
        endif

WriteGemsByteArgument:
        jsr          BeginGemsCommand(pc)                          ; $07A8E2
        move.l       $8(a6), d0                                    ; $07A8E6
        jsr          WriteGemsCommandByte(pc)                      ; $07A8EA
        jmp          EndGemsCommand(pc)                            ; $07A8EE
        ifne *-$7A8F2
        fail "ROM end moved"
        endif
