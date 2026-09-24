; $009BC6..$009CB3 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9BC6
        fail "ROM start moved"
        endif

SpawnActorFromMapCell:
        movem.l      d0/d7/a0-a1/a4-a5, -(a7)                      ; $009BC6
        cmpa.l       #$ffa5fa, a1                                  ; $009BCA
        bcs.b        loc_009BDA                                    ; $009BD0
        cmpa.l       #$ffe5fa, a1                                  ; $009BD2
        bcs.b        loc_009BE0                                    ; $009BD8

loc_009BDA:
        movea.l      #$ffa9fa, a1                                  ; $009BDA

loc_009BE0:
; Second spawn path also consumes the map marker before AllocateActor can fail.
        clr.b        (a1)                                          ; $009BE0
        movea.l      a1, a0                                        ; $009BE2
        move.l       a1, d3                                        ; $009BE4
        jsr          CommitMapCellAndSendLink.l                    ; $009BE6
        jsr          AllocateActor.l                               ; $009BEC
        beq.w        loc_009CAC                                    ; $009BF2
        movea.l      rPendingActorDefinition(a6), a1               ; $009BF6
        clr.b        ActorUpdateDelay(a0)                          ; $009BFA
        move.l       (a1), ActorUpdateCallback(a0)                 ; $009BFE
        move.l       ActorDefDraw(a1), ActorDrawCallback(a0)       ; $009C02
        move.l       ActorDefHit(a1), ActorHitCallback(a0)         ; $009C08
        move.l       ActorDefExit(a1), ActorExitCallback(a0)       ; $009C0E
        move.w       ActorDefFlags(a1), d0                         ; $009C14
        or.w         d0, ActorFlags(a0)                            ; $009C18
        move.w       ActorDefHealth(a1), ActorHealth(a0)           ; $009C1C
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $009C22
        move.l       a1, -(a7)                                     ; $009C28
        jsr          GetVisibleMapBase.l                           ; $009C2A
        sub.l        a1, d3                                        ; $009C30
        movea.l      (a7)+, a1                                     ; $009C32
        andi.w       #$3ff, d3                                     ; $009C34
        move.w       d3, d0                                        ; $009C38
        andi.w       #$1f, d0                                      ; $009C3A
        lsl.w        #$8, d0                                       ; $009C3E
        addi.w       #$80, d0                                      ; $009C40
        move.w       d0, ActorX(a0)                                ; $009C44
        lsl.w        #$3, d3                                       ; $009C48
        move.b       #$80, d3                                      ; $009C4A
        move.w       d3, ActorY(a0)                                ; $009C4E
        move.w       ActorDefZ(a1), ActorZ(a0)                     ; $009C52
        clr.b        ActorState(a0)                                ; $009C58
        move.b       #$cd, ActorState(a0)                          ; $009C5C
        move.b       #$14, ActorStateCounter(a0)                   ; $009C62
        clr.b        ActorUnknown45(a0)                            ; $009C68
        move.w       rPlayerX(a6), ActorGoalX(a0)                  ; $009C6C
        move.w       rPlayerY(a6), ActorGoalY(a0)                  ; $009C72
        move.l       ActorDefSpriteBank(a1), ActorSpriteBank(a0)   ; $009C78
        move.b       ActorDefExitCellProfile(a1), ActorExitCellProfile(a0) ; $009C7E
        move.b       ActorDefCorpseCellProfile(a1), ActorCorpseCellProfile(a0) ; $009C84
        move.l       #ramPlayerActorProxy, ActorTarget(a0)         ; $009C8A
        move.w       ActorDefSpawnSound(a1), d0                    ; $009C92
        bsr.w        PlayActorSpawnSound                        ; $009C96
        tst.w        rLinkRole(a6)                                 ; $009C9A
        beq.b        loc_009CAC                                    ; $009C9E
        move.l       ActorDefLink(a1), ActorLinkCallback(a0)       ; $009CA0
        movea.l      ActorDefSendSpawn(a1), a1                     ; $009CA6
; Definition +$20: one of 11 SendActorSpawnKind handlers.
        jsr          (a1)                                          ; $009CAA

loc_009CAC:
        movem.l      (a7)+, d0/d7/a0-a1/a4-a5                      ; $009CAC
        clr.w        d3                                            ; $009CB0
        rts                                                        ; $009CB2
        ifne *-$9CB4
        fail "ROM end moved"
        endif
