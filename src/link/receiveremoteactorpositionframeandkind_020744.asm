; $020744..$020765 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; [⇐June 1AABA] декодер link-команды (см. 1AA68)
        ifne *-$20744
        fail "ROM start moved"
        endif

ReceiveRemoteActorPositionFrameAndKind:
        bsr.w        FindRemoteActorFromPacket                     ; $020744
        bne.b        loc_02074C                                    ; $020748
        rts                                                        ; $02074A

loc_02074C:
        move.w       (a3)+, ActorX(a0)                             ; $02074C
        move.w       (a3)+, ActorY(a0)                             ; $020750
        move.b       (a3)+, d0                                     ; $020754
        ext.w        d0                                            ; $020756
        move.w       d0, ActorZ(a0)                                ; $020758
        move.b       (a3)+, ActorRemoteFrame(a0)                   ; $02075C
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $020760
        rts                                                        ; $020764
        ifne *-$20766
        fail "ROM end moved"
        endif
