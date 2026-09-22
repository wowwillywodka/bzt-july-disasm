; $01B156..$01B19B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; If Byte52!=0, update scene-exit delay first. Otherwise CB->CC, CC waits for draw-side counter0, CA enters movement/pickup.
        ifne *-$1B156
        fail "ROM start moved"
        endif

UpdateGunnerCorpse:
; If Byte52!=0, update scene-exit delay first. Otherwise CB->CC, CC waits for draw-side counter0, CA enters movement/pickup.
        clr.b        ActorUpdateDelay(a0)                          ; $01B156
        tst.b        ActorBehaviorByte52(a0)                       ; $01B15A
        bne.w        TickGunnerSceneExitDelay                      ; $01B15E
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $01B162
        beq.w        BeginGunnerCorpseTransition                   ; $01B168
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $01B16C
        beq.w        WaitGunnerCorpseDrawing                       ; $01B172
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $01B176
        beq.w        loc_01B198                                    ; $01B17C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $01B180
        beq.w        loc_01B198                                    ; $01B186
        cmpi.b       #$ca, ActorDeathMode(a0)                      ; $01B18A
        beq.w        MoveGunnerCorpseAndTryPickup                  ; $01B190
        bra.w        MoveGunnerCorpseAndTryPickup                  ; $01B194

loc_01B198:
        bra.w        MoveGunnerCorpseAndTryPickup                  ; $01B198
        ifne *-$1B19C
        fail "ROM end moved"
        endif
