; $0206BE..$0206F1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1AA34] RAM-реестр -0x7116/-0x711A (список клеток/акторов, аналог реестров обломков)
        ifne *-$206BE
        fail "ROM start moved"
        endif

ActorsRoutine_0206BE:
        bsr.b        FindRemoteActorFromPacket                     ; $0206BE
        bne.b        loc_0206C4                                    ; $0206C0
        rts                                                        ; $0206C2

loc_0206C4:
        move.w       (a3)+, ActorX(a0)                             ; $0206C4
        move.w       (a3)+, ActorY(a0)                             ; $0206C8
        move.w       (a3)+, ActorMotionX(a0)                       ; $0206CC
        move.w       (a3)+, ActorMotionY(a0)                       ; $0206D0
        move.b       (a3)+, d0                                     ; $0206D4
        ext.w        d0                                            ; $0206D6
        move.w       d0, ActorZ(a0)                                ; $0206D8
        clr.w        d0                                            ; $0206DC
        move.b       (a3)+, d0                                     ; $0206DE
        ori.w        #$21, d0                                      ; $0206E0
        move.w       d0, ActorFlags(a0)                            ; $0206E4
        move.b       (a3)+, ActorRemoteFrame(a0)                   ; $0206E8
        move.b       (a3)+, ActorRemoteKind(a0)                    ; $0206EC
        rts                                                        ; $0206F0
        ifne *-$206F2
        fail "ROM end moved"
        endif
