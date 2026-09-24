; $07A990..$07A99D | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $16: stop and clear all 16 logical channels, no argument.
        ifne *-$7A990
        fail "ROM start moved"
        endif

GemsStopAll:
        jsr          BeginGemsCommand(pc)                          ; $07A990
        moveq        #$16, d0                                      ; $07A994
        jsr          WriteGemsCommandPrefixAndOpcode(pc)                       ; $07A996
        jmp          EndGemsCommand(pc)                            ; $07A99A
        ifne *-$7A99E
        fail "ROM end moved"
        endif
