; $01BE0C..$01BEBB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Обновляет proxy игрока из позиции, вектора взгляда и вертикального смещения, затем обходит активный список актёров.
        ifne *-$1BE0C
        fail "ROM start moved"
        endif

UpdateActors:
; Refresh the player proxy, then visit the active list; A6=WORK_RAM_BASE.
        andi.w       #$1fff, rPlayerX(a6)                          ; $01BE0C
        andi.w       #$1fff, rPlayerY(a6)                          ; $01BE12
        lea.l        rPlayerActorProxy(a6), a0                     ; $01BE18
        move.w       rPlayerViewOffsetZ(a6), ActorZ(a0)                        ; $01BE1C
        move.w       rPlayerX(a6), ActorX(a0)                      ; $01BE22
        move.w       rPlayerY(a6), ActorY(a0)                      ; $01BE28
        move.w       rPlayerFacingVectorX(a6), ActorMotionX(a0)                  ; $01BE2E
        move.w       rPlayerFacingVectorY(a6), ActorMotionY(a0)                  ; $01BE34
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $01BE3A
; Player proxy uses the player-specific hit handler; ordinary local-player blast
; paths may call that handler directly without traversing the actor list.
        move.l       #ApplyPlayerDistanceHit, ActorHitCallback(a0) ; $01BE40
        move.w       rActiveActorCount(a6), d7                     ; $01BE48
        bne.b        loc_01BE50                                    ; $01BE4C
        rts                                                        ; $01BE4E

loc_01BE50:
        subq.w       #$1, d7                                       ; $01BE50
        movea.l      rActiveActorHead(a6), a0                      ; $01BE52

loc_01BE56:
; Save ActorNext before callbacks: the current actor may remove itself.
        move.l       (a0), -(a7)                                   ; $01BE56
        move.w       ActorX(a0), ActorPreviousX(a0)                ; $01BE58
        move.w       ActorY(a0), ActorPreviousY(a0)                ; $01BE5E
        tst.w        ActorX(a0)                                    ; $01BE64
        bmi.b        loc_01BE8E                                    ; $01BE68
        tst.w        ActorY(a0)                                    ; $01BE6A
        bmi.b        loc_01BE8E                                    ; $01BE6E
        cmpi.w       #$2000, ActorX(a0)                            ; $01BE70
        bcc.b        loc_01BE8E                                    ; $01BE76
        cmpi.w       #$2000, ActorY(a0)                            ; $01BE78
        bcc.b        loc_01BE8E                                    ; $01BE7E
        tst.b        ActorFloor(a0)                                ; $01BE80
        bmi.b        loc_01BE8E                                    ; $01BE84
        cmpi.b       #$f, ActorFloor(a0)                           ; $01BE86
        bls.b        loc_01BE9E                                    ; $01BE8C

loc_01BE8E:
        move.w       ActorFlags(a0), d0                            ; $01BE8E
        andi.w       #$20, d0                                      ; $01BE92
        bne.b        loc_01BE9E                                    ; $01BE96
; Leaving the local window removes the actor directly; does not call its map-restoring exit callback.
        bsr.w        RemoveActorAndSendLink                        ; $01BE98
        bra.b        loc_01BEAE                                    ; $01BE9C

loc_01BE9E:
; Signed byte countdown: callback runs when the decremented value is negative. No automatic reload.
; A zero delay runs now (0->$FF); $14 runs after 21 visits if nobody edits it.
; A negative delay also runs now. Callbacks commonly clear it to zero.
; A visible-cell spawn sets delay=0, so its first visited update is eligible
; immediately; renderer-created actors are first visited next iteration.
        subq.b       #$1, ActorUpdateDelay(a0)                     ; $01BE9E
        bpl.b        loc_01BEAE                                    ; $01BEA2
        movea.l      ActorUpdateCallback(a0), a1                   ; $01BEA4
        move.w       d7, -(a7)                                     ; $01BEA8
        jsr          (a1)                                          ; $01BEAA
        move.w       (a7)+, d7                                     ; $01BEAC

loc_01BEAE:
        movea.l      (a7)+, a0                                     ; $01BEAE
        cmpa.l       #$0, a0                                       ; $01BEB0
        beq.b        ActorNoOp                                     ; $01BEB6
        dbra         d7, loc_01BE56                                ; $01BEB8
        ifne *-$1BEBC
        fail "ROM end moved"
        endif
