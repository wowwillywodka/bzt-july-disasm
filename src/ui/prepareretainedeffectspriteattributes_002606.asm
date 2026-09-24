; $002606..$00267D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 25D4] тики флагов -0x6F59/-0x6F5C (парные к 1A8E6)
        ifne *-$2606
        fail "ROM start moved"
        endif

PrepareRetainedEffectSpriteAttributes:
        move.w       #$c00c, d3                                    ; $002606
        cmpi.w       #$10, d1                                      ; $00260A
        bcc.b        loc_002616                                    ; $00260E
        addi.w       #$1002, d3                                    ; $002610
        bra.b        loc_00261E                                    ; $002614

loc_002616:
        cmpi.w       #$30, d1                                      ; $002616
        bcs.b        loc_00261E                                    ; $00261A
        addq.w       #$2, d3                                       ; $00261C

loc_00261E:
        move.w       #$400, d0                                     ; $00261E
        addi.w       #$b0, d1                                      ; $002622
        addi.w       #$e0, d2                                      ; $002626
        rts                                                        ; $00262A

loc_00262C:
        bsr.b        PrepareRetainedEffectSpriteAttributes                          ; $00262C
        bra.w        AppendHardwareSprite                          ; $00262E

loc_002632:
        move.w       rPlayerFacingAngle(a6), d5                                ; $002632
        neg.w        d5                                            ; $002636
        lsl.w        #$1, d5                                       ; $002638
        addi.w       #$220, d5                                     ; $00263A
        move.w       rPlayerY(a6), d0                              ; $00263E
        asr.w        #$6, d0                                       ; $002642
        sub.w        d0, d5                                        ; $002644
        clr.w        d0                                            ; $002646
        move.b       rRetainedPanoramaHorizontalPhase(a6), d0                                ; $002648
        add.w        d0, d5                                        ; $00264C
        andi.w       #$3ff, d5                                     ; $00264E
        bsr.b        ComputeRetainedEffectSpriteAttributes                        ; $002652
        bra.b        AppendHardwareSprite                          ; $002654

loc_002656:
        move.w       rPlayerFacingAngle(a6), d5                                ; $002656
        neg.w        d5                                            ; $00265A
        lsl.w        #$1, d5                                       ; $00265C
        addi.w       #$20, d5                                      ; $00265E
        move.w       rPlayerY(a6), d0                              ; $002662
        asr.w        #$6, d0                                       ; $002666
        sub.w        d0, d5                                        ; $002668
        clr.w        d0                                            ; $00266A
        move.b       rRetainedPanoramaHorizontalPhase(a6), d0                                ; $00266C
        add.w        d0, d5                                        ; $002670
        andi.w       #$3ff, d5                                     ; $002672
        bsr.b        ComputeRetainedEffectSpriteAttributes                        ; $002676
        eori.w       #$1800, d3                                    ; $002678
        bra.b        AppendHardwareSprite                          ; $00267C
        ifne *-$267E
        fail "ROM end moved"
        endif
