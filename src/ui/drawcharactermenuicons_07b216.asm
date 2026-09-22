; $07B216..$07B2DB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B216
        fail "ROM start moved"
        endif

DrawCharacterMenuIcons:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        move.w       #$1ff, d5                                     ; $07B216
        move.w       $ff2a4e.l, d6                                 ; $07B21A
        andi.w       #$1ff, d6                                     ; $07B220
        sub.w        d6, d5                                        ; $07B224
        moveq        #$0, d0                                       ; $07B226
        move.w       #$b01, d1                                     ; $07B228
        move.w       #$1a0, d2                                     ; $07B22C
        move.w       #$a8, d3                                      ; $07B230
        add.w        d5, d3                                        ; $07B234
        andi.w       #$1ff, d3                                     ; $07B236
        move.w       #$a546, d4                                    ; $07B23A
        jsr          WriteHardwareSprite.l                         ; $07B23E
        moveq        #$1, d0                                       ; $07B244
        move.w       #$b02, d1                                     ; $07B246
        move.w       #$1a0, d2                                     ; $07B24A
        move.w       #$110, d3                                     ; $07B24E
        add.w        d5, d3                                        ; $07B252
        andi.w       #$1ff, d3                                     ; $07B254
        move.w       #$b546, d4                                    ; $07B258
        jsr          WriteHardwareSprite.l                         ; $07B25C
        moveq        #$2, d0                                       ; $07B262
        move.w       #$b03, d1                                     ; $07B264
        move.w       #$1a0, d2                                     ; $07B268
        move.w       #$1a8, d3                                     ; $07B26C
        add.w        d5, d3                                        ; $07B270
        andi.w       #$1ff, d3                                     ; $07B272
        move.w       #$a546, d4                                    ; $07B276
        jsr          WriteHardwareSprite.l                         ; $07B27A
        moveq        #$3, d0                                       ; $07B280
        move.w       #$b04, d1                                     ; $07B282
        move.w       #$1a0, d2                                     ; $07B286
        move.w       #$210, d3                                     ; $07B28A
        add.w        d5, d3                                        ; $07B28E
        andi.w       #$1ff, d3                                     ; $07B290
        move.w       #$b546, d4                                    ; $07B294
        jsr          WriteHardwareSprite.l                         ; $07B298
        moveq        #$4, d0                                       ; $07B29E
        move.w       #$f05, d1                                     ; $07B2A0
        move.w       #$19c, d2                                     ; $07B2A4
        move.w       #$dc, d3                                      ; $07B2A8
        add.w        d5, d3                                        ; $07B2AC
        andi.w       #$1ff, d3                                     ; $07B2AE
        move.w       #$a552, d4                                    ; $07B2B2
        jsr          WriteHardwareSprite.l                         ; $07B2B6
        moveq        #$5, d0                                       ; $07B2BC
        move.w       #$f00, d1                                     ; $07B2BE
        move.w       #$19c, d2                                     ; $07B2C2
        move.w       #$1dc, d3                                     ; $07B2C6
        add.w        d5, d3                                        ; $07B2CA
        andi.w       #$1ff, d3                                     ; $07B2CC
        move.w       #$a552, d4                                    ; $07B2D0
        jsr          WriteHardwareSprite.l                         ; $07B2D4
        rts                                                        ; $07B2DA
        ifne *-$7B2DC
        fail "ROM end moved"
        endif
