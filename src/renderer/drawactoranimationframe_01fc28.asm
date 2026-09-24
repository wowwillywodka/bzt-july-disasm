; $01FC28..$01FCF9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; July frame stride $36: 6 header bytes, 16 mirror bytes, 16 WORD tile indices. Legacy $2B58E0 still stores $26-byte frames.
        ifne *-$1FC28
        fail "ROM start moved"
        endif

DrawActorAnimationFrame:
; July frame stride $36: 6 header bytes, 16 mirror bytes, 16 WORD tile indices. Legacy $2B58E0 still stores $26-byte frames.
        mulu.w       #$36, d1                                      ; $01FC28
        adda.l       d1, a1                                        ; $01FC2C
        movem.w      (a7)+, d1/d5                                  ; $01FC2E
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $01FC32
        move.w       d5, d2                                        ; $01FC36
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $01FC38
        sub.w        rTransitHeightOffset(a6), d3                                ; $01FC3C
        sub.w        ActorZ(a0), d3                                ; $01FC40
        muls.w       d3, d2                                        ; $01FC44
        asr.l        #$6, d2                                       ; $01FC46
        addi.w       #$28, d2                                      ; $01FC48
        clr.w        d6                                            ; $01FC4C
        move.b       $2(a1), d6                                    ; $01FC4E
        mulu.w       d5, d6                                        ; $01FC52
        asr.l        #$5, d6                                       ; $01FC54
        clr.w        d7                                            ; $01FC56
        move.b       $3(a1), d7                                    ; $01FC58
        mulu.w       d5, d7                                        ; $01FC5C
        asr.l        #$4, d7                                       ; $01FC5E
        clr.w        d3                                            ; $01FC60
        move.b       $4(a1), d3                                    ; $01FC62
        mulu.w       d6, d3                                        ; $01FC66
        tst.b        (a1)                                          ; $01FC68
        beq.b        loc_01FC7A                                    ; $01FC6A
        cmpi.b       #$1, (a1)                                     ; $01FC6C
        beq.b        loc_01FC76                                    ; $01FC70
        sub.w        d3, d1                                        ; $01FC72
        bra.b        loc_01FC7A                                    ; $01FC74

loc_01FC76:
        asr.w        #$1, d3                                       ; $01FC76
        sub.w        d3, d1                                        ; $01FC78

loc_01FC7A:
        clr.w        d3                                            ; $01FC7A
        move.b       $5(a1), d3                                    ; $01FC7C
        mulu.w       d7, d3                                        ; $01FC80
        tst.b        $1(a1)                                        ; $01FC82
        beq.b        loc_01FC98                                    ; $01FC86
        cmpi.b       #$1, $1(a1)                                   ; $01FC88
        beq.b        loc_01FC94                                    ; $01FC8E
        sub.w        d3, d2                                        ; $01FC90
        bra.b        loc_01FC98                                    ; $01FC92

loc_01FC94:
        asr.w        #$1, d3                                       ; $01FC94
        sub.w        d3, d2                                        ; $01FC96

loc_01FC98:
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $01FC98
        movea.l      a1, a3                                        ; $01FC9C
        addq.w       #$6, a3                                       ; $01FC9E
        movea.l      a3, a4                                        ; $01FCA0
        adda.l       #$10, a4                                      ; $01FCA2
        move.w       d6, d4                                        ; $01FCA8
        move.w       d7, d0                                        ; $01FCAA
        clr.w        d7                                            ; $01FCAC
        move.b       $5(a1), d7                                    ; $01FCAE
        subq.w       #$1, d7                                       ; $01FCB2

loc_01FCB4:
        clr.w        d6                                            ; $01FCB4
        move.b       $4(a1), d6                                    ; $01FCB6
        subq.w       #$1, d6                                       ; $01FCBA
        movem.l      d1/a1/a3-a4, -(a7)                            ; $01FCBC

loc_01FCC0:
        movea.l      a2, a1                                        ; $01FCC0
        move.b       (a3), rSoftwareSpriteMirrorFlagLow(a6)                              ; $01FCC2
        clr.l        d3                                            ; $01FCC6
; Tile address = pixel base + (sign_extend_16(index << 1) << 8). Valid present July tile indices are below $4000.
        move.w       (a4), d3                                      ; $01FCC8
        lsl.w        #$1, d3                                       ; $01FCCA
        ext.l        d3                                            ; $01FCCC
        lsl.l        #$8, d3                                       ; $01FCCE
        adda.l       d3, a1                                        ; $01FCD0
        movem.l      d0-d2/d4-d7/a0/a2-a4, -(a7)                   ; $01FCD2
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01FCD6
        movem.l      (a7)+, d0-d2/d4-d7/a0/a2-a4                   ; $01FCDC
        addq.w       #$1, a3                                       ; $01FCE0
        addq.w       #$2, a4                                       ; $01FCE2
        add.w        d4, d1                                        ; $01FCE4
        dbra         d6, loc_01FCC0                                ; $01FCE6
        movem.l      (a7)+, d1/a1/a3-a4                            ; $01FCEA
        add.w        d0, d2                                        ; $01FCEE
; A3/A4 restored at row end: attribute row stride 4 bytes, tile-index row stride 8 bytes.
        addq.w       #$4, a3                                       ; $01FCF0
        addq.l       #$8, a4                                       ; $01FCF2
        dbra         d7, loc_01FCB4                                ; $01FCF4
        rts                                                        ; $01FCF8
        ifne *-$1FCFA
        fail "ROM end moved"
        endif
