; $07A982..$07A98F | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $0D: resume active, unreserved sequences, no argument.
        ifne *-$7A982
        fail "ROM start moved"
        endif

GemsResumeAll:
        jsr          BeginGemsCommand(pc)                          ; $07A982
        moveq        #$d, d0                                       ; $07A986
        jsr          WriteGemsCommandPrefixAndOpcode(pc)                       ; $07A988
        jmp          EndGemsCommand(pc)                            ; $07A98C
        ifne *-$7A990
        fail "ROM end moved"
        endif
