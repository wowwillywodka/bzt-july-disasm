; $020872..$0208B5 | m68k
; Separate link command handler entry.
        ifne *-$20872
        fail "ROM start moved"
        endif

ReceiveRemoteHitEventDirect:
; Command06 searches matching LOCAL actor (remote flag clear), then tail-calls its hit callback with packet direction/distance. Packet supplies no weapon byte and no ActorState; local hit rules can still cause special death.
        move.b       (a0)+, d0                                     ; $020872
        beq.b        loc_0208AA                                    ; $020874
        movea.l      a0, a1                                        ; $020876
        move.w       rActiveActorCount(a6), d7                     ; $020878
        bne.b        loc_020880                                    ; $02087C
        rts                                                        ; $02087E

loc_020880:
        subq.w       #$1, d7                                       ; $020880
        movea.l      rActiveActorHead(a6), a0                      ; $020882

loc_020886:
        move.w       ActorFlags(a0), d1                            ; $020886
        andi.w       #$20, d1                                      ; $02088A
        bne.b        loc_020896                                    ; $02088E
        cmp.b        ActorLinkId(a0), d0                           ; $020890
        beq.b        loc_02089E                                    ; $020894

loc_020896:
        movea.l      (a0), a0                                      ; $020896
        dbra         d7, loc_020886                                ; $020898
        rts                                                        ; $02089C

loc_02089E:
; Command06 supplies direction and hit parameter, but no weapon ID: the recipient's
; current global rCurrentWeaponId still governs weapon-specific enemy reactions.
        move.w       (a1)+, d3                                     ; $02089E
        move.w       (a1)+, d4                                     ; $0208A0
        move.w       (a1)+, d0                                     ; $0208A2
        movea.l      ActorHitCallback(a0), a1                      ; $0208A4
        jmp          (a1)                                          ; $0208A8

loc_0208AA:
        move.w       (a0)+, d3                                     ; $0208AA
        move.w       (a0)+, d4                                     ; $0208AC
        move.w       (a0)+, d0                                     ; $0208AE
        jmp          ApplyPlayerDistanceHit.l                      ; $0208B0
        ifne *-$208B6
        fail "ROM end moved"
        endif
