; $020812..$020863 | m68k
; Separate link command handler entry.
        ifne *-$20812
        fail "ROM start moved"
        endif

ReceiveRemoteHitEvent:
        move.b       #$1, rRemoteHitCommandVariant(a6)                               ; $020812
        move.b       (a0)+, d0                                     ; $020818
        beq.b        loc_020852                                    ; $02081A
        movea.l      a0, a1                                        ; $02081C
        move.w       rActiveActorCount(a6), d7                     ; $02081E
        bne.b        loc_020826                                    ; $020822
        bra.b        loc_02085E                                    ; $020824

loc_020826:
        subq.w       #$1, d7                                       ; $020826
        movea.l      rActiveActorHead(a6), a0                      ; $020828

loc_02082C:
        move.w       ActorFlags(a0), d1                            ; $02082C
        andi.w       #$20, d1                                      ; $020830
        bne.b        loc_02083C                                    ; $020834
        cmp.b        ActorLinkId(a0), d0                           ; $020836
        beq.b        loc_020844                                    ; $02083A

loc_02083C:
        movea.l      (a0), a0                                      ; $02083C
        dbra         d7, loc_02082C                                ; $02083E
        bra.b        loc_02085E                                    ; $020842

loc_020844:
        move.w       (a1)+, d3                                     ; $020844
        move.w       (a1)+, d4                                     ; $020846
        move.w       (a1)+, d0                                     ; $020848
        movea.l      ActorHitCallback(a0), a1                      ; $02084A
        jsr          (a1)                                          ; $02084E
        bra.b        loc_02085E                                    ; $020850

loc_020852:
        move.w       (a0)+, d3                                     ; $020852
        move.w       (a0)+, d4                                     ; $020854
        move.w       (a0)+, d0                                     ; $020856
        jsr          ResolvePlayerHitOrConsumeAlternateSlot.l                            ; $020858

loc_02085E:
        clr.b        rRemoteHitCommandVariant(a6)                                    ; $02085E
        rts                                                        ; $020862
        ifne *-$20864
        fail "ROM end moved"
        endif
