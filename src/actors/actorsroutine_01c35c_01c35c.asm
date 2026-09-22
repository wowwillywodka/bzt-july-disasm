; $01C35C..$01C389 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 16E2A] актёрные хелперы (инит/освобождение, регион 16Dxx-16Exx)
        ifne *-$1C35C
        fail "ROM start moved"
        endif

ActorsRoutine_01C35C:
        move.b       #$14, ActorUpdateDelay(a0)                    ; $01C35C
        clr.b        ActorEffectCounter(a0)                        ; $01C362
        move.l       #UpdatePlayerProximityMine, ActorUpdateCallback(a0) ; $01C366
        move.l       #loc_01CA7E, ActorDrawCallback(a0)            ; $01C36E
        move.l       #ExplodeProjectileOnNearHit, ActorHitCallback(a0) ; $01C376
        move.w       #$9, ActorFlags(a0)                           ; $01C37E
        clr.b        ActorState(a0)                                ; $01C384
        rts                                                        ; $01C388
        ifne *-$1C38A
        fail "ROM end moved"
        endif
