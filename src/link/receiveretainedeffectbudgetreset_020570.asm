; $020570..$0205D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: link command $16 clears the retained panorama active
; flag and decrements its budget if nonzero. Later labels are separate command
; handlers ($17 disconnect, $14/$15 pause, $13 item grant); they do not
; execute after this RTS.
        ifne *-$20570
        fail "ROM start moved"
        endif

ReceiveRetainedEffectBudgetReset:
        clr.b        rRetainedPanoramaEffectActive(a6)                                    ; $020570
        tst.b        rRetainedPanoramaEffectBudget(a6)                                    ; $020574
        beq.b        loc_02057E                                    ; $020578
        subq.b       #$1, rRetainedPanoramaEffectBudget(a6)                               ; $02057A

loc_02057E:
        rts                                                        ; $02057E
        ifne *-$20580
        fail "ROM end moved"
        endif
