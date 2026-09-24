; $07A94E..$07A963 | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $10: start sequence ID from first stack argument.
        ifne *-$7A94E
        fail "ROM start moved"
        endif

GemsStartSequence:
        jsr          BeginGemsCommand(pc)                          ; $07A94E
        moveq        #$10, d0                                      ; $07A952

WriteGemsOneArgumentCommand:
; Common tail: D0=opcode, then write one byte from $8(A6).
        jsr          WriteGemsCommandPrefixAndOpcode(pc)                       ; $07A954
        move.l       $8(a6), d0                                    ; $07A958
        jsr          WriteGemsCommandByte(pc)                      ; $07A95C
        jmp          EndGemsCommand(pc)                            ; $07A960
        ifne *-$7A964
        fail "ROM end moved"
        endif
