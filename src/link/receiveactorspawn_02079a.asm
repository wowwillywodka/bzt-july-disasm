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
; Keep allocator's ActorNoOp update. Remote kind dispatch runs through the
; draw callback; packets supply state changes from the owning machine.
        move.l       #DispatchRemoteActorUpdate, ActorDrawCallback(a0) ; $0207D4
        move.l       #SendRemoteActorHit, ActorHitCallback(a0)     ; $0207DC

loc_0207E4:
        rts                                                        ; $0207E4
        ifne *-$207E6
        fail "ROM end moved"
        endif
