; $020766..$02077F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1AADC] декодер link-команды (см. 1AA68)
        ifne *-$20766
        fail "ROM start moved"
        endif

ActorsRoutine_020766:
        bsr.w        FindRemoteActorFromPacket                     ; $020766
        bne.b        loc_02076E                                    ; $02076A
        rts                                                        ; $02076C

loc_02076E:
        move.w       (a3)+, ActorX(a0)                             ; $02076E
        move.w       (a3)+, ActorY(a0)                             ; $020772
        move.b       (a3)+, ActorRemoteFrame(a0)                   ; $020776
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $02077A
        rts                                                        ; $02077E
        ifne *-$20780
        fail "ROM end moved"
        endif
