; $02233A..$0223AF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2233A
        fail "ROM start moved"
        endif

RetainedSpriteMappingAndWaitHelpers:
        move.w       (a0)+, d5                                     ; $02233A
        move.w       (a0)+, d0                                     ; $02233C

loc_02233E:
        move.w       d6, d2                                        ; $02233E
        move.w       d7, d3                                        ; $022340
        move.w       d5, d4                                        ; $022342
        add.w        (a0)+, d2                                     ; $022344
        add.w        (a0)+, d3                                     ; $022346
        move.w       a1, d1                                        ; $022348
        or.w         (a0)+, d1                                     ; $02234A
        addq.w       #$1, d1                                       ; $02234C
        or.w         (a0)+, d4                                     ; $02234E
        jsr          loc_021FFE(pc)                                ; $022350
        addq.w       #$1, a1                                       ; $022354
        add.w        (a0)+, d5                                     ; $022356
        dbra         d0, loc_02233E                                ; $022358
        rts                                                        ; $02235C
        moveq        #$0, d0                                       ; $02235E
        moveq        #$1, d1                                       ; $022360
        moveq        #$1, d2                                       ; $022362
        moveq        #$1, d3                                       ; $022364
        moveq        #$0, d4                                       ; $022366
        jsr          WriteHardwareSprite(pc)                       ; $022368
        rts                                                        ; $02236C
        lsl.w        #$3, d1                                       ; $02236E
        move.w       (a2, d1.w), d6                                ; $022370
        move.w       $2(a2, d1.w), d7                              ; $022374
        movea.l      $4(a2, d1.w), a0                              ; $022378
        jsr          RetainedSpriteMappingAndWaitHelpers(pc)       ; $02237C
        rts                                                        ; $022380
        moveq        #$0, d1                                       ; $022382
        moveq        #$1, d2                                       ; $022384
        moveq        #$1, d3                                       ; $022386
        moveq        #$0, d4                                       ; $022388
        jsr          loc_021FFE(pc)                                ; $02238A
        rts                                                        ; $02238E
        move.w       (a0)+, d1                                     ; $022390
        move.w       (a0)+, d0                                     ; $022392
        move.w       (a0)+, d7                                     ; $022394
        moveq        #$0, d6                                       ; $022396

loc_022398:
        movem.l      d0-d1, -(a7)                                  ; $022398
        movem.l      (a7)+, d0-d1                                  ; $02239C
        jsr          WaitVBlankFrames(pc)                          ; $0223A0
        cmp.w        d1, d6                                        ; $0223A4
        beq.w        loc_0223AE                                    ; $0223A6
        addq.w       #$1, d6                                       ; $0223AA
        bra.b        loc_022398                                    ; $0223AC

loc_0223AE:
        rts                                                        ; $0223AE
        ifne *-$223B0
        fail "ROM end moved"
        endif
