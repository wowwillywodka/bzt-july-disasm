; $020710..$02072D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1AA86] декодер link-команды: апдейт позы реплики (см. 1AA68)
        ifne *-$20710
        fail "ROM start moved"
        endif

ActorsRoutine_020710:
        bsr.w        FindRemoteActorFromPacket                     ; $020710
        bne.b        loc_020718                                    ; $020714
        rts                                                        ; $020716

loc_020718:
        move.w       (a3)+, ActorX(a0)                             ; $020718
        move.w       (a3)+, ActorY(a0)                             ; $02071C
        move.b       (a3)+, d0                                     ; $020720
        ext.w        d0                                            ; $020722
        move.w       d0, ActorZ(a0)                                ; $020724
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $020728
        rts                                                        ; $02072C
        ifne *-$2072E
        fail "ROM end moved"
        endif
