; $0221B0..$022279 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$221B0
        fail "ROM start moved"
        endif

FadePaletteDefaultStepCountToWhite:
        moveq        #$f, d5                                       ; $0221B0

loc_0221B2:
        movem.l      d0-d1/d5/a0, -(a7)                            ; $0221B2
        movea.l      a0, a5                                        ; $0221B6
        moveq        #$0, d0                                       ; $0221B8
        lea.l        IntroPaletteB.l, a0                           ; $0221BA
        jsr          LoadPaletteLine(pc)                           ; $0221C0
        lea.l        $FFFF86F8.w, a0                               ; $0221C4
        moveq        #$1f, d0                                      ; $0221C8

loc_0221CA:
        move.l       #$eee0eee, (a0)+                              ; $0221CA
        dbra         d0, loc_0221CA                                ; $0221D0
        movem.l      (a7)+, d0-d1/d5/a0                            ; $0221D4

loc_0221D8:
        move.b       #$1, d7                                       ; $0221D8
        move.l       a0, -(a7)                                     ; $0221DC
        move.l       d1, d0                                        ; $0221DE
        jsr          WaitVBlankFrames(pc)                          ; $0221E0
        lea.l        $FFFF86F8.w, a1                               ; $0221E4
        move.w       d5, d2                                        ; $0221E8

loc_0221EA:
        move.w       (a0), d3                                      ; $0221EA
        move.w       (a1), d4                                      ; $0221EC
        andi.w       #$e00, d3                                     ; $0221EE
        andi.w       #$e00, d4                                     ; $0221F2
        cmp.w        d3, d4                                        ; $0221F6
        beq.w        loc_022200                                    ; $0221F8
        subi.w       #$200, (a1)                                   ; $0221FC

loc_022200:
        move.w       (a0), d3                                      ; $022200
        move.w       (a1), d4                                      ; $022202
        andi.w       #$e0, d3                                      ; $022204
        andi.w       #$e0, d4                                      ; $022208
        cmp.w        d3, d4                                        ; $02220C
        beq.w        loc_022216                                    ; $02220E
        subi.w       #$20, (a1)                                    ; $022212

loc_022216:
        move.w       (a0), d3                                      ; $022216
        move.w       (a1), d4                                      ; $022218
        andi.w       #$e, d3                                       ; $02221A
        andi.w       #$e, d4                                       ; $02221E
        cmp.w        d3, d4                                        ; $022222
        beq.w        loc_02222A                                    ; $022224
        subq.w       #$2, (a1)                                     ; $022228

loc_02222A:
        cmpm.w       (a0)+, (a1)+                                  ; $02222A
        beq.w        loc_022234                                    ; $02222C
        move.b       #$0, d7                                       ; $022230

loc_022234:
        dbra         d2, loc_0221EA                                ; $022234
        cmpi.b       #$1, d7                                       ; $022238
        beq.w        loc_022276                                    ; $02223C
        movem.l      d0-d1/d5-d7/a0, -(a7)                         ; $022240
        moveq        #$0, d6                                       ; $022244
        move.w       d6, d4                                        ; $022246

loc_022248:
        lea.l        $FFFF86F8.w, a0                               ; $022248
        adda.l       d6, a0                                        ; $02224C
        move.w       d4, d0                                        ; $02224E
        movem.l      d4-d6, -(a7)                                  ; $022250
        jsr          LoadPaletteLine(pc)                           ; $022254
        movem.l      (a7)+, d4-d6                                  ; $022258
        subi.w       #$10, d5                                      ; $02225C
        bmi.w        loc_02226C                                    ; $022260
        addi.w       #$20, d6                                      ; $022264
        addq.w       #$1, d4                                       ; $022268
        bra.b        loc_022248                                    ; $02226A

loc_02226C:
        movem.l      (a7)+, d0-d1/d5-d7/a0                         ; $02226C
        movea.l      (a7)+, a0                                     ; $022270
        bra.w        loc_0221D8                                    ; $022272

loc_022276:
        movea.l      (a7)+, a0                                     ; $022276
        rts                                                        ; $022278
        ifne *-$2227A
        fail "ROM end moved"
        endif
