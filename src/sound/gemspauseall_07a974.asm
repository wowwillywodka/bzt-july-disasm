; $07A974..$07A981 | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $0C: pause all logical channels, no argument.
        ifne *-$7A974
        fail "ROM start moved"
        endif

GemsPauseAll:
        jsr          BeginGemsCommand(pc)                          ; $07A974
        moveq        #$c, d0                                       ; $07A978
        jsr          WriteGemsCommandPrefixAndOpcode(pc)                       ; $07A97A
        jmp          EndGemsCommand(pc)                            ; $07A97E
        ifne *-$7A982
        fail "ROM end moved"
        endif
