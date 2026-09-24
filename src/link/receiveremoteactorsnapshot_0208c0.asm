; $0208C0..$02090F | m68k
; Separate link command handler entry.
        ifne *-$208C0
        fail "ROM start moved"
        endif

ReceiveRemoteActorSnapshot:
        move.b       (a0)+, d0                                     ; $0208C0
        movea.l      a0, a3                                        ; $0208C2
        move.w       rActiveActorCount(a6), d7                     ; $0208C4
        bne.b        loc_0208CC                                    ; $0208C8
        rts                                                        ; $0208CA

loc_0208CC:
        subq.w       #$1, d7                                       ; $0208CC
        movea.l      rActiveActorHead(a6), a0                      ; $0208CE

loc_0208D2:
        move.w       ActorFlags(a0), d1                            ; $0208D2
        andi.w       #$20, d1                                      ; $0208D6
        beq.b        loc_0208E2                                    ; $0208DA
        cmp.b        ActorLinkId(a0), d0                           ; $0208DC
        beq.b        loc_0208EA                                    ; $0208E0

loc_0208E2:
        movea.l      (a0), a0                                      ; $0208E2
        dbra         d7, loc_0208D2                                ; $0208E4
        rts                                                        ; $0208E8

loc_0208EA:
        move.w       (a3)+, ActorX(a0)                             ; $0208EA
        move.w       (a3)+, ActorY(a0)                             ; $0208EE
        move.b       (a3)+, d0                                     ; $0208F2
        ext.w        d0                                            ; $0208F4
        move.w       d0, ActorZ(a0)                                ; $0208F6
        clr.w        d0                                            ; $0208FA
        move.b       (a3)+, d0                                     ; $0208FC
        ori.w        #$21, d0                                      ; $0208FE
        move.w       d0, ActorFlags(a0)                            ; $020902
        move.b       (a3)+, ActorFloor(a0)                         ; $020906
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $02090A
        rts                                                        ; $02090E
        ifne *-$20910
        fail "ROM end moved"
        endif
