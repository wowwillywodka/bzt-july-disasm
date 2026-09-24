; $020864..$020871 | m68k
; Separate link command handler entry.
        ifne *-$20864
        fail "ROM start moved"
        endif

ReceiveRemoteHitEventWithFlag:
; Command07 temporarily sets global $FF2A42 around command06 hit receiver. This is NOT actor byte34; hit callback still consults receiving machine CurrentWeapon byte.
        move.b       #$1, rRemoteHitCommandVariant(a6)                               ; $020864
        bsr.b        ReceiveRemoteHitEventDirect                                    ; $02086A
        clr.b        rRemoteHitCommandVariant(a6)                                    ; $02086C
        rts                                                        ; $020870
        ifne *-$20872
        fail "ROM end moved"
        endif
