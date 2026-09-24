; $02069A..$0206BD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; [⇐June 1AA10] RAM-реестр -0x7116/-0x711A (список клеток/акторов, аналог реестров обломков)
        ifne *-$2069A
        fail "ROM start moved"
        endif

ReceiveRemoteActorPositionMotionAndKind:
        bsr.b        FindRemoteActorFromPacket                     ; $02069A
        bne.b        loc_0206A0                                    ; $02069C
        rts                                                        ; $02069E

loc_0206A0:
        move.w       (a3)+, ActorX(a0)                             ; $0206A0
        move.w       (a3)+, ActorY(a0)                             ; $0206A4
        move.w       (a3)+, ActorMotionX(a0)                       ; $0206A8
        move.w       (a3)+, ActorMotionY(a0)                       ; $0206AC
        move.b       (a3)+, d0                                     ; $0206B0
        ext.w        d0                                            ; $0206B2
        move.w       d0, ActorZ(a0)                                ; $0206B4
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $0206B8
        rts                                                        ; $0206BC
        ifne *-$206BE
        fail "ROM end moved"
        endif
