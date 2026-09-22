; $02079A..$02090F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x20780] [⇐June 1AAF6] декодер link-команды (см. 1AA68)
        ifne *-$2079A
        fail "ROM start moved"
        endif

ReceiveActorSpawn:
        movea.l      a0, a3                                        ; $02079A
        jsr          AllocateActor(pc)                             ; $02079C
        beq.b        loc_0207E4                                    ; $0207A0
; Remote ID is supplied by the sender; it need not match this local physical slot.
        move.b       (a3)+, ActorLinkId(a0)                        ; $0207A2
        move.w       (a3)+, ActorX(a0)                             ; $0207A6
        move.w       (a3)+, ActorY(a0)                             ; $0207AA
        move.b       (a3)+, d0                                     ; $0207AE
        ext.w        d0                                            ; $0207B0
        move.w       d0, ActorZ(a0)                                ; $0207B2
        clr.w        d0                                            ; $0207B6
        move.b       (a3)+, d0                                     ; $0207B8
        ori.w        #$21, d0                                      ; $0207BA
        or.w         d0, ActorFlags(a0)                            ; $0207BE
        clr.w        d0                                            ; $0207C2
        move.b       (a3)+, ActorFloor(a0)                         ; $0207C4
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $0207C8
        move.w       (a3)+, ActorMotionX(a0)                       ; $0207CC
        move.w       (a3)+, ActorMotionY(a0)                       ; $0207D0
        move.l       #DispatchRemoteActorUpdate, ActorDrawCallback(a0) ; $0207D4
        move.l       #$1eadc, ActorHitCallback(a0)                 ; $0207DC

loc_0207E4:
        rts                                                        ; $0207E4

loc_0207E6:
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

loc_020812:
        move.b       #$1, -$55be(a6)                               ; $020812
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
        jsr          UiRoutine_00E000.l                            ; $020858

loc_02085E:
        clr.b        -$55be(a6)                                    ; $02085E
        rts                                                        ; $020862

loc_020864:
; Command07 temporarily sets global $FF2A42 around command06 hit receiver. This is NOT actor byte34; hit callback still consults receiving machine CurrentWeapon byte.
        move.b       #$1, -$55be(a6)                               ; $020864
        bsr.b        loc_020872                                    ; $02086A
        clr.b        -$55be(a6)                                    ; $02086C
        rts                                                        ; $020870

loc_020872:
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

loc_0208B6:
        clr.w        d0                                            ; $0208B6
        move.b       (a0)+, d0                                     ; $0208B8
        jmp          SoundRoutine_00DFBA.l                         ; $0208BA

loc_0208C0:
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
