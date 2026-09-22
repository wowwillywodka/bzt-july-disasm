; $01BE0C..$01BEBB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главный цикл обновления актёров: заполняет шаблон (-0x6e1e,A6) позицией/углами камеры, обходит список актёров (счётчик -0x57c6, ptr -0x57c4), валидирует позицию (0x24/0x26 в [0,0x2000), тайл 0x36 в [0,0xf]) и по таймеру (0x23,A0) вызывает per-actor хэндлер через vptr (0x16,A0)
        ifne *-$1BE0C
        fail "ROM start moved"
        endif

UpdateActors:
; Refresh the player proxy, then visit the active list; A6=WORK_RAM_BASE.
        andi.w       #$1fff, rPlayerX(a6)                          ; $01BE0C
        andi.w       #$1fff, rPlayerY(a6)                          ; $01BE12
        lea.l        rPlayerActorProxy(a6), a0                     ; $01BE18
        move.w       -$71d8(a6), ActorZ(a0)                        ; $01BE1C
        move.w       rPlayerX(a6), ActorX(a0)                      ; $01BE22
        move.w       rPlayerY(a6), ActorY(a0)                      ; $01BE28
        move.w       -$71f2(a6), ActorMotionX(a0)                  ; $01BE2E
        move.w       -$71f0(a6), ActorMotionY(a0)                  ; $01BE34
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $01BE3A
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
