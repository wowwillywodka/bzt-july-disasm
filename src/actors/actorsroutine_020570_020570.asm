; $020570..$0205D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1A8E6] тик-хелпер: сброс -0x6F5C, декремент таймера -0x6F59
        ifne *-$20570
        fail "ROM start moved"
        endif

ActorsRoutine_020570:
        clr.b        -$6f56(a6)                                    ; $020570
        tst.b        -$6f53(a6)                                    ; $020574
        beq.b        loc_02057E                                    ; $020578
        subq.b       #$1, -$6f53(a6)                               ; $02057A

loc_02057E:
        rts                                                        ; $02057E

loc_020580:
        jmp          ActorsRoutine_01C1A0(pc)                      ; $020580

loc_020584:
        bset.b       #$1, rPauseFlags(a6)                          ; $020584
        rts                                                        ; $02058A

loc_02058C:
        bclr.b       #$1, rPauseFlags(a6)                          ; $02058C
        rts                                                        ; $020592

loc_020594:
        clr.w        d0                                            ; $020594
        move.b       (a0)+, d0                                     ; $020596
        move.b       (a0)+, d2                                     ; $020598
        lsl.w        #$8, d2                                       ; $02059A
        move.w       d2, -$6fa2(a6)                                ; $02059C
        move.w       d0, -(a7)                                     ; $0205A0
        jsr          UiRoutine_011C78.l                            ; $0205A2
        move.w       (a7)+, d0                                     ; $0205A8
        clr.w        -$6fa2(a6)                                    ; $0205AA
        cmpi.w       #$ffff, d7                                    ; $0205AE
        bne.b        loc_0205B6                                    ; $0205B2
        rts                                                        ; $0205B4

loc_0205B6:
        move.w       d0, -(a7)                                     ; $0205B6
        move.w       #$60, d0                                      ; $0205B8
        jsr          SoundRoutine_00DF84.l                         ; $0205BC
        move.w       (a7)+, d0                                     ; $0205C2
        movea.l      #ItemPickupMessagePointers, a0                ; $0205C4
        lsl.w        #$2, d0                                       ; $0205CA
        adda.w       d0, a0                                        ; $0205CC
        movea.l      (a0), a0                                      ; $0205CE
        jmp          QueueStatusMessage.l                          ; $0205D0
        ifne *-$205D6
        fail "ROM end moved"
        endif
