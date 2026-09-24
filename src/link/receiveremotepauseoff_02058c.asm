; $02058C..$020593 | m68k
; Separate link command handler entry.
        ifne *-$2058C
        fail "ROM start moved"
        endif

ReceiveRemotePauseOff:
        bclr.b       #$1, rPauseFlags(a6)                          ; $02058C
        rts                                                        ; $020592
        ifne *-$20594
        fail "ROM end moved"
        endif
