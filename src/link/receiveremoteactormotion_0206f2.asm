; $0206F2..$02070F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Link command0D: find REMOTE replica, update XY/MotionXY and byte43 presentation kind. Does NOT assign ActorState/Counter, death mode or local AI callbacks; cannot directly enable a missing local state.
        ifne *-$206F2
        fail "ROM start moved"
        endif

ReceiveRemoteActorMotion:
; Link command0D: find REMOTE replica, update XY/MotionXY and byte43 presentation kind. Does NOT assign ActorState/Counter, death mode or local AI callbacks; cannot directly enable a missing local state.
        bsr.w        FindRemoteActorFromPacket                     ; $0206F2
        bne.b        loc_0206FA                                    ; $0206F6
        rts                                                        ; $0206F8

loc_0206FA:
        move.w       (a3)+, ActorX(a0)                             ; $0206FA
        move.w       (a3)+, ActorY(a0)                             ; $0206FE
        move.w       (a3)+, ActorMotionX(a0)                       ; $020702
        move.w       (a3)+, ActorMotionY(a0)                       ; $020706
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $02070A
        rts                                                        ; $02070E
        ifne *-$20710
        fail "ROM end moved"
        endif
