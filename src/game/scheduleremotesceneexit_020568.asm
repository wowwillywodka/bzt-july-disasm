; $020568..$02056F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Link command $18 schedules scene exit after 15 gameplay iterations; the frame loop consumes the counter.
        ifne *-$20568
        fail "ROM start moved"
        endif

ScheduleRemoteSceneExit:
; Link command $18 schedules scene exit after 15 gameplay iterations; the frame loop consumes the counter.
        move.w       #$f, rRemoteSceneExitDelay(a6)                ; $020568
        rts                                                        ; $02056E
        ifne *-$20570
        fail "ROM end moved"
        endif
