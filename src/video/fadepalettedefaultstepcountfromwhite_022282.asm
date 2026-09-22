; $022282..$022339 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$22282
        fail "ROM start moved"
        endif

FadePaletteDefaultStepCountFromWhite:
        moveq        #$f, d5                                       ; $022282

loc_022284:
        movem.l      d0-d1/d5/a0, -(a7)                            ; $022284
        movea.l      a0, a5                                        ; $022288
        move.l       a0, -(a7)                                     ; $02228A
        jsr          LoadPaletteLine(pc)                           ; $02228C
        movea.l      (a7)+, a0                                     ; $022290
        lea.l        $FFFF86F8.w, a1                               ; $022292
        moveq        #$1f, d0                                      ; $022296

loc_022298:
        move.l       (a0)+, (a1)+                                  ; $022298
        dbra         d0, loc_022298                                ; $02229A
        movem.l      (a7)+, d0-d1/d5/a0                            ; $02229E

loc_0222A2:
        move.b       #$1, d7                                       ; $0222A2
        move.l       a0, -(a7)                                     ; $0222A6
        move.l       d1, d0                                        ; $0222A8
        jsr          WaitVBlankFrames(pc)                          ; $0222AA
        lea.l        $FFFF86F8.w, a1                               ; $0222AE
        move.w       d5, d2                                        ; $0222B2

loc_0222B4:
        move.w       (a1), d3                                      ; $0222B4
        andi.w       #$e00, d3                                     ; $0222B6
        cmpi.w       #$e00, d3                                     ; $0222BA
        beq.w        loc_0222C6                                    ; $0222BE
        addi.w       #$200, (a1)                                   ; $0222C2

loc_0222C6:
        move.w       (a1), d3                                      ; $0222C6
        andi.w       #$e0, d3                                      ; $0222C8
        cmpi.w       #$e0, d3                                      ; $0222CC
        beq.w        loc_0222D8                                    ; $0222D0
        addi.w       #$20, (a1)                                    ; $0222D4

loc_0222D8:
        move.w       (a1), d3                                      ; $0222D8
        andi.w       #$e, d3                                       ; $0222DA
        cmpi.w       #$e, d3                                       ; $0222DE
        beq.w        loc_0222E8                                    ; $0222E2
        addq.w       #$2, (a1)                                     ; $0222E6

loc_0222E8:
        cmpi.w       #$eee, (a1)+                                  ; $0222E8
        beq.w        loc_0222F4                                    ; $0222EC
        move.b       #$0, d7                                       ; $0222F0

loc_0222F4:
        dbra         d2, loc_0222B4                                ; $0222F4
        cmpi.b       #$1, d7                                       ; $0222F8
        beq.w        loc_022336                                    ; $0222FC
        movem.l      d0-d1/d5-d7/a0, -(a7)                         ; $022300
        moveq        #$0, d6                                       ; $022304
        move.w       d6, d4                                        ; $022306

loc_022308:
        lea.l        $FFFF86F8.w, a0                               ; $022308
        adda.l       d6, a0                                        ; $02230C
        move.w       d4, d0                                        ; $02230E
        movem.l      d4-d6, -(a7)                                  ; $022310
        jsr          LoadPaletteLine(pc)                           ; $022314
        movem.l      (a7)+, d4-d6                                  ; $022318
        subi.w       #$10, d5                                      ; $02231C
        bmi.w        loc_02232C                                    ; $022320
        addi.w       #$20, d6                                      ; $022324
        addq.w       #$1, d4                                       ; $022328
        bra.b        loc_022308                                    ; $02232A

loc_02232C:
        movem.l      (a7)+, d0-d1/d5-d7/a0                         ; $02232C
        movea.l      (a7)+, a0                                     ; $022330
        bra.w        loc_0222A2                                    ; $022332

loc_022336:
        movea.l      (a7)+, a0                                     ; $022336
        rts                                                        ; $022338
        ifne *-$2233A
        fail "ROM end moved"
        endif
