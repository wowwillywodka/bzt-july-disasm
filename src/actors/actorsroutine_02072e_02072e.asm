; $02072E..$020743 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1AAA4] декодер link-команды (см. 1AA68)
        ifne *-$2072E
        fail "ROM start moved"
        endif

ActorsRoutine_02072E:
        bsr.w        FindRemoteActorFromPacket                     ; $02072E
        bne.b        loc_020736                                    ; $020732
        rts                                                        ; $020734

loc_020736:
        move.w       (a3)+, ActorX(a0)                             ; $020736
        move.w       (a3)+, ActorY(a0)                             ; $02073A
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $02073E
        rts                                                        ; $020742
        ifne *-$20744
        fail "ROM end moved"
        endif
