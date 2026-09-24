; $0207E6..$020811 | m68k
; Separate link command handler entry.
        ifne *-$207E6
        fail "ROM start moved"
        endif

ReceiveRemoteActorRemoval:
        move.b       (a0)+, d0                                     ; $0207E6
        move.w       rActiveActorCount(a6), d7                     ; $0207E8
        bne.b        loc_0207F0                                    ; $0207EC
        rts                                                        ; $0207EE

loc_0207F0:
        subq.w       #$1, d7                                       ; $0207F0
        movea.l      rActiveActorHead(a6), a0                      ; $0207F2

loc_0207F6:
        move.w       ActorFlags(a0), d1                            ; $0207F6
        andi.w       #$20, d1                                      ; $0207FA
        beq.b        loc_02080A                                    ; $0207FE
        cmp.b        ActorLinkId(a0), d0                           ; $020800
        bne.b        loc_02080A                                    ; $020804
        jmp          RemoveActor(pc)                               ; $020806

loc_02080A:
        movea.l      (a0), a0                                      ; $02080A
        dbra         d7, loc_0207F6                                ; $02080C
        rts                                                        ; $020810
        ifne *-$20812
        fail "ROM end moved"
        endif
