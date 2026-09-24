; $020584..$02058B | m68k
; Separate link command handler entry.
        ifne *-$20584
        fail "ROM start moved"
        endif

ReceiveRemotePauseOn:
        bset.b       #$1, rPauseFlags(a6)                          ; $020584
        rts                                                        ; $02058A
        ifne *-$2058C
        fail "ROM end moved"
        endif
