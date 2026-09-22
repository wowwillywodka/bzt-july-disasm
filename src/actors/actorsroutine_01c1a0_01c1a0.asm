; $01C1A0..$01C221 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Полный сброс всех актёров: 3× jsr 0x20ab2(#0x21036) и jsr 0x1ff82 (очистка спрайт/звук), сброс флага (-0x53a4,A6); обход списка — для актёров с битом 0x20 ставит хэндлер 0x1c150 и диспетчеризует по типу (0x43,A0) через таблицу 0x1c222
        ifne *-$1C1A0
        fail "ROM start moved"
        endif

ActorsRoutine_01C1A0:
        tst.w        rLinkRole(a6)                                 ; $01C1A0
        bne.b        loc_01C1A8                                    ; $01C1A4
        rts                                                        ; $01C1A6

loc_01C1A8:
        movea.l      #StatusMessage2PlayerConnecTionLost, a0       ; $01C1A8
        jsr          QueueStatusMessage.l                          ; $01C1AE
        movea.l      #StatusMessage2PlayerConnecTionLost, a0       ; $01C1B4
        jsr          QueueStatusMessage.l                          ; $01C1BA
        movea.l      #StatusMessage2PlayerConnecTionLost, a0       ; $01C1C0
        jsr          QueueStatusMessage.l                          ; $01C1C6
        jsr          InputRoutine_01FF82.l                         ; $01C1CC
        clr.w        rLinkRole(a6)                                 ; $01C1D2
        movea.l      rActiveActorHead(a6), a0                      ; $01C1D6
        cmpa.l       #$0, a0                                       ; $01C1DA
        beq.b        loc_01C220                                    ; $01C1E0
        move.l       (a0), -(a7)                                   ; $01C1E2
        movea.l      (a7)+, a0                                     ; $01C1E4
        cmpa.l       #$0, a0                                       ; $01C1E6
        beq.b        loc_01C220                                    ; $01C1EC

loc_01C1EE:
        move.l       (a0), -(a7)                                   ; $01C1EE
        move.w       ActorFlags(a0), d0                            ; $01C1F0
        andi.w       #$20, d0                                      ; $01C1F4
        beq.b        loc_01C216                                    ; $01C1F8
        andi.w       #$ffdf, ActorFlags(a0)                        ; $01C1FA
        move.l       #RemoveActor, ActorExitCallback(a0)           ; $01C200
        clr.w        d0                                            ; $01C208
        move.b       ActorRemoteKind(a0), d0                       ; $01C20A
        lsl.w        #$2, d0                                       ; $01C20E
        movea.l      ActorLinkStateHandlers(pc, d0.w), a1          ; $01C210
        jsr          (a1)                                          ; $01C214

loc_01C216:
        movea.l      (a7)+, a0                                     ; $01C216
        cmpa.l       #$0, a0                                       ; $01C218
        bne.b        loc_01C1EE                                    ; $01C21E

loc_01C220:
        rts                                                        ; $01C220
        ifne *-$1C222
        fail "ROM end moved"
        endif
