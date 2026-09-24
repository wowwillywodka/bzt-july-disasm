; $07AA20..$07AA4F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$7AA20
        fail "ROM start moved"
        endif

GemsCommand17:
        jsr          BeginGemsCommand(pc)                          ; $07AA20
        moveq        #$17, d0                                      ; $07AA24
        jsr          WriteGemsCommandPrefixAndOpcode(pc)                       ; $07AA26
        move.l       $8(a6), d0                                    ; $07AA2A
        jsr          WriteGemsCommandByte(pc)                      ; $07AA2E
        move.l       $c(a6), d0                                    ; $07AA32
        jsr          WriteGemsCommandByte(pc)                      ; $07AA36
        move.l       $10(a6), d0                                   ; $07AA3A
        jsr          WriteGemsCommandByte(pc)                      ; $07AA3E
        jmp          EndGemsCommand(pc)                            ; $07AA42
        jsr          BeginGemsCommand(pc)                          ; $07AA46
        moveq        #$1b, d0                                      ; $07AA4A
        bra.w        WriteGemsTwoArgumentCommand                                    ; $07AA4C
        ifne *-$7AA50
        fail "ROM end moved"
        endif
