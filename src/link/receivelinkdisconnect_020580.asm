; $020580..$020583 | m68k
; Separate link command handler entry.
        ifne *-$20580
        fail "ROM start moved"
        endif

ReceiveLinkDisconnect:
        jmp          HandleLinkDisconnect(pc)                      ; $020580
        ifne *-$20584
        fail "ROM end moved"
        endif
