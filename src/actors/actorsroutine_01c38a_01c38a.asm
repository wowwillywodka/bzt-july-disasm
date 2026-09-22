; $01C38A..$01C3BF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 16E58] актёрные хелперы (инит/освобождение, регион 16Dxx-16Exx)
        ifne *-$1C38A
        fail "ROM start moved"
        endif

ActorsRoutine_01C38A:
        clr.b        ActorUpdateDelay(a0)                          ; $01C38A
        clr.b        ActorState(a0)                                ; $01C38E
        move.l       #UpdateProximityWallCharge, ActorUpdateCallback(a0) ; $01C392
        move.l       #loc_01DEE4, ActorDrawCallback(a0)            ; $01C39A
        move.l       #$1dfbc, ActorHitCallback(a0)                 ; $01C3A2
        move.l       #EnvironmentRoutine_01E040, ActorExitCallback(a0) ; $01C3AA
        ori.w        #$84, ActorFlags(a0)                          ; $01C3B2
        move.w       #$64, ActorHealth(a0)                         ; $01C3B8
        rts                                                        ; $01C3BE
        ifne *-$1C3C0
        fail "ROM end moved"
        endif
