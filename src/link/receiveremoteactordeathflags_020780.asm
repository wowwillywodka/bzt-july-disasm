; $020780..$020799 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Link command12: find REMOTE replica, replace Flags with payload OR$21 and Floor. Does not assign ActorState, DeathMode, RemoteKind or callbacks.
        ifne *-$20780
        fail "ROM start moved"
        endif

ReceiveRemoteActorDeathFlags:
; Link command12: find REMOTE replica, replace Flags with payload OR$21 and Floor. Does not assign ActorState, DeathMode, RemoteKind or callbacks.
        bsr.w        FindRemoteActorFromPacket                     ; $020780
        bne.b        loc_020788                                    ; $020784
        rts                                                        ; $020786

loc_020788:
        clr.w        d0                                            ; $020788
        move.b       (a3)+, d0                                     ; $02078A
        ori.w        #$21, d0                                      ; $02078C
        move.w       d0, ActorFlags(a0)                            ; $020790
        move.b       (a3)+, ActorFloor(a0)                         ; $020794
        rts                                                        ; $020798
        ifne *-$2079A
        fail "ROM end moved"
        endif
