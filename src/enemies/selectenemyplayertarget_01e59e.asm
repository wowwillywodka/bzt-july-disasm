; $01E59E..$01E60D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Returns A1=player proxy, active-list head in link mode, or zero if floors differ.
; Ties select the player. Head is dereferenced without an empty-list guard and may equal A0; callers must not assume otherwise.
        ifne *-$1E59E
        fail "ROM start moved"
        endif

SelectEnemyPlayerTarget:
; Returns A1=player proxy, active-list head in link mode, or zero if floors differ.
; Ties select the player. Head is dereferenced without an empty-list guard and may equal A0; callers must not assume otherwise.
        tst.w        rLinkRole(a6)                                 ; $01E59E
        beq.b        loc_01E5F8                                    ; $01E5A2
        movea.l      rActiveActorHead(a6), a1                      ; $01E5A4
        move.b       ActorFloor(a1), d0                                   ; $01E5A8
        cmp.b        ActorFloor(a0), d0                                   ; $01E5AC
        bne.b        loc_01E5F8                                    ; $01E5B0
        move.w       rCurrentFloor(a6), d0                         ; $01E5B2
        cmp.b        ActorFloor(a0), d0                                   ; $01E5B6
        bne.b        loc_01E608                                    ; $01E5BA
        move.w       ActorX(a1), d0                                   ; $01E5BC
        sub.w        ActorX(a0), d0                                   ; $01E5C0
        move.w       ActorY(a1), d1                                   ; $01E5C4
        sub.w        ActorY(a0), d1                                   ; $01E5C8
        jsr          OctagonalDistance.l                           ; $01E5CC
        move.w       d0, d6                                        ; $01E5D2
        move.w       rPlayerX(a6), d0                              ; $01E5D4
        sub.w        ActorX(a0), d0                                   ; $01E5D8
        move.w       rPlayerY(a6), d1                              ; $01E5DC
        sub.w        ActorY(a0), d1                                   ; $01E5E0
        jsr          OctagonalDistance.l                           ; $01E5E4
        cmp.w        d0, d6                                        ; $01E5EA
        bcs.b        loc_01E608                                    ; $01E5EC
        bra.b        loc_01E602                                    ; $01E5EE

loc_01E5F0:
        movea.l      #$0, a1                                       ; $01E5F0
        rts                                                        ; $01E5F6

loc_01E5F8:
        move.w       rCurrentFloor(a6), d0                         ; $01E5F8
        cmp.b        ActorFloor(a0), d0                                   ; $01E5FC
        bne.b        loc_01E5F0                                    ; $01E600

loc_01E602:
        lea.l        rPlayerActorProxy(a6), a1                     ; $01E602
        rts                                                        ; $01E606

loc_01E608:
        movea.l      rActiveActorHead(a6), a1                      ; $01E608
        rts                                                        ; $01E60C
        ifne *-$1E60E
        fail "ROM end moved"
        endif
