; $023214..$023335 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сборка параметров слоёв фона по индексам скролла: обнуляет блок (-0x76da..), по индексам (-0x7786/-0x7784) читает 5-байтовые записи из PC-таблиц, разворачивает в 6-байтовые дескрипторы слоёв (-0x76c0..-0x76d8) для отрисовки многослойного параллакса
        ifne *-$23214
        fail "ROM start moved"
        endif

BuildTitleScrollLayers:
        lea.l        rTitleScrollLayerWords(a6), a0                                ; $023214
        clr.l        (a0)+                                         ; $023218
        clr.l        (a0)+                                         ; $02321A
        clr.l        (a0)+                                         ; $02321C
        clr.l        (a0)+                                         ; $02321E
        clr.l        (a0)+                                         ; $023220
        clr.l        (a0)+                                         ; $023222
        clr.l        (a0)+                                         ; $023224
        clr.l        (a0)+                                         ; $023226
        move.w       rTitleScrollTrack0Ticks(a6), d0                                ; $023228
        cmpi.w       #$40, d0                                      ; $02322C
        bcc.w        loc_0232AE                                    ; $023230
        lea.l        TitleSpriteFrameSelectors(pc), a1             ; $023234
        adda.w       d0, a1                                        ; $023238
        lsl.w        #$2, d0                                       ; $02323A
        adda.w       d0, a1                                        ; $02323C
        clr.w        d0                                            ; $02323E
        move.b       (a1)+, d0                                     ; $023240
        beq.b        loc_023256                                    ; $023242
        subq.w       #$1, d0                                       ; $023244
        lsl.w        #$3, d0                                       ; $023246
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $023248
        adda.w       d0, a0                                        ; $02324C
        move.l       (a0)+, rTitleLayer4Long(a6)                             ; $02324E
        move.w       (a0)+, rTitleLayer4Word(a6)                             ; $023252

loc_023256:
        move.b       (a1)+, d0                                     ; $023256
        beq.b        loc_02326C                                    ; $023258
        subq.w       #$1, d0                                       ; $02325A
        lsl.w        #$3, d0                                       ; $02325C
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $02325E
        adda.w       d0, a0                                        ; $023262
        move.l       (a0)+, rTitleLayer3Long(a6)                             ; $023264
        move.w       (a0)+, rTitleLayer3Word(a6)                             ; $023268

loc_02326C:
        move.b       (a1)+, d0                                     ; $02326C
        beq.b        loc_023282                                    ; $02326E
        subq.w       #$1, d0                                       ; $023270
        lsl.w        #$3, d0                                       ; $023272
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $023274
        adda.w       d0, a0                                        ; $023278
        move.l       (a0)+, rTitleLayer2Long(a6)                             ; $02327A
        move.w       (a0)+, rTitleLayer2Word(a6)                             ; $02327E

loc_023282:
        move.b       (a1)+, d0                                     ; $023282
        beq.b        loc_023298                                    ; $023284
        subq.w       #$1, d0                                       ; $023286
        lsl.w        #$3, d0                                       ; $023288
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $02328A
        adda.w       d0, a0                                        ; $02328E
        move.l       (a0)+, rTitleLayer1Long(a6)                             ; $023290
        move.w       (a0)+, rTitleLayer1Word(a6)                             ; $023294

loc_023298:
        move.b       (a1)+, d0                                     ; $023298
        beq.b        loc_0232AE                                    ; $02329A
        subq.w       #$1, d0                                       ; $02329C
        lsl.w        #$3, d0                                       ; $02329E
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $0232A0
        adda.w       d0, a0                                        ; $0232A4
        move.l       (a0)+, rTitleLayer0Long(a6)                             ; $0232A6
        move.w       (a0)+, rTitleLayer0Word(a6)                             ; $0232AA

loc_0232AE:
        move.w       rTitleScrollTrack1Ticks(a6), d0                                ; $0232AE
        cmpi.w       #$40, d0                                      ; $0232B2
        bcc.w        loc_023334                                    ; $0232B6
        lea.l        TitleSpriteFrameSelectors(pc), a1             ; $0232BA
        adda.w       d0, a1                                        ; $0232BE
        lsl.w        #$2, d0                                       ; $0232C0
        adda.w       d0, a1                                        ; $0232C2
        clr.w        d0                                            ; $0232C4
        move.b       (a1)+, d0                                     ; $0232C6
        beq.b        loc_0232DC                                    ; $0232C8
        subq.w       #$1, d0                                       ; $0232CA
        lsl.w        #$3, d0                                       ; $0232CC
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $0232CE
        adda.w       d0, a0                                        ; $0232D2
        move.l       (a0)+, rTitleLayer4Long(a6)                             ; $0232D4
        move.w       (a0)+, rTitleLayer4Word(a6)                             ; $0232D8

loc_0232DC:
        move.b       (a1)+, d0                                     ; $0232DC
        beq.b        loc_0232F2                                    ; $0232DE
        subq.w       #$1, d0                                       ; $0232E0
        lsl.w        #$3, d0                                       ; $0232E2
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $0232E4
        adda.w       d0, a0                                        ; $0232E8
        move.l       (a0)+, rTitleLayer3Long(a6)                             ; $0232EA
        move.w       (a0)+, rTitleLayer3Word(a6)                             ; $0232EE

loc_0232F2:
        move.b       (a1)+, d0                                     ; $0232F2
        beq.b        loc_023308                                    ; $0232F4
        subq.w       #$1, d0                                       ; $0232F6
        lsl.w        #$3, d0                                       ; $0232F8
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $0232FA
        adda.w       d0, a0                                        ; $0232FE
        move.l       (a0)+, rTitleLayer2Long(a6)                             ; $023300
        move.w       (a0)+, rTitleLayer2Word(a6)                             ; $023304

loc_023308:
        move.b       (a1)+, d0                                     ; $023308
        beq.b        loc_02331E                                    ; $02330A
        subq.w       #$1, d0                                       ; $02330C
        lsl.w        #$3, d0                                       ; $02330E
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $023310
        adda.w       d0, a0                                        ; $023314
        move.l       (a0)+, rTitleLayer1Long(a6)                             ; $023316
        move.w       (a0)+, rTitleLayer1Word(a6)                             ; $02331A

loc_02331E:
        move.b       (a1)+, d0                                     ; $02331E
        beq.b        loc_023334                                    ; $023320
        subq.w       #$1, d0                                       ; $023322
        lsl.w        #$3, d0                                       ; $023324
        lea.l        TitleAnimatedSpriteMappings(pc), a0           ; $023326
        adda.w       d0, a0                                        ; $02332A
        move.l       (a0)+, rTitleLayer0Long(a6)                             ; $02332C
        move.w       (a0)+, rTitleLayer0Word(a6)                             ; $023330

loc_023334:
        rts                                                        ; $023334
        ifne *-$23336
        fail "ROM end moved"
        endif
