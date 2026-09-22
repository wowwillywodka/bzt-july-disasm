; $01FCFA..$01FDD3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A1=bank, D0=animation, D7=view, D3=frame, D1/D2=screen X/Y, D5=scale. View/frame indices have no bounds checks here.
        ifne *-$1FCFA
        fail "ROM start moved"
        endif

DrawExplicitAnimationFrame:
; A1=bank, D0=animation, D7=view, D3=frame, D1/D2=screen X/Y, D5=scale. View/frame indices have no bounds checks here.
        movem.w      d1-d2/d5, -(a7)                               ; $01FCFA
        move.w       d3, -(a7)                                     ; $01FCFE
        cmp.w        (a1)+, d0                                     ; $01FD00
        bcs.b        loc_01FD08                                    ; $01FD02
; Original invalid-animation exit discards 6 bytes after pushing 8; preserved, not repaired. Valid callers avoid this branch.
        addq.w       #$6, a7                                       ; $01FD04
        rts                                                        ; $01FD06

loc_01FD08:
        movea.l      a1, a2                                        ; $01FD08
        adda.w       (a1), a2                                      ; $01FD0A
        lsl.w        #$1, d0                                       ; $01FD0C
        adda.w       $2(a1, d0.w), a1                              ; $01FD0E
        lsl.w        #$1, d7                                       ; $01FD12
        adda.w       $2(a1, d7.w), a1                              ; $01FD14
        move.w       (a1)+, d7                                     ; $01FD18
        move.w       (a7)+, d1                                     ; $01FD1A
        mulu.w       #$36, d1                                      ; $01FD1C
        adda.l       d1, a1                                        ; $01FD20
        movem.w      (a7)+, d1-d2/d5                               ; $01FD22
        clr.w        d6                                            ; $01FD26
        move.b       $2(a1), d6                                    ; $01FD28
        mulu.w       d5, d6                                        ; $01FD2C
        asr.l        #$5, d6                                       ; $01FD2E
        clr.w        d7                                            ; $01FD30
        move.b       $3(a1), d7                                    ; $01FD32
        mulu.w       d5, d7                                        ; $01FD36
        asr.l        #$4, d7                                       ; $01FD38
        clr.w        d3                                            ; $01FD3A
        move.b       $4(a1), d3                                    ; $01FD3C
        mulu.w       d6, d3                                        ; $01FD40
        tst.b        (a1)                                          ; $01FD42
        beq.b        loc_01FD54                                    ; $01FD44
        cmpi.b       #$1, (a1)                                     ; $01FD46
        beq.b        loc_01FD50                                    ; $01FD4A
        sub.w        d3, d1                                        ; $01FD4C
        bra.b        loc_01FD54                                    ; $01FD4E

loc_01FD50:
        asr.w        #$1, d3                                       ; $01FD50
        sub.w        d3, d1                                        ; $01FD52

loc_01FD54:
        clr.w        d3                                            ; $01FD54
        move.b       $5(a1), d3                                    ; $01FD56
        mulu.w       d7, d3                                        ; $01FD5A
        tst.b        $1(a1)                                        ; $01FD5C
        beq.b        loc_01FD72                                    ; $01FD60
        cmpi.b       #$1, $1(a1)                                   ; $01FD62
        beq.b        loc_01FD6E                                    ; $01FD68
        sub.w        d3, d2                                        ; $01FD6A
        bra.b        loc_01FD72                                    ; $01FD6C

loc_01FD6E:
        asr.w        #$1, d3                                       ; $01FD6E
        sub.w        d3, d2                                        ; $01FD70

loc_01FD72:
        clr.w        -$6f32(a6)                                    ; $01FD72
        movea.l      a1, a3                                        ; $01FD76
        addq.w       #$6, a3                                       ; $01FD78
        movea.l      a3, a4                                        ; $01FD7A
        adda.l       #$10, a4                                      ; $01FD7C
        move.w       d6, d4                                        ; $01FD82
        move.w       d7, d0                                        ; $01FD84
        clr.w        d7                                            ; $01FD86
        move.b       $5(a1), d7                                    ; $01FD88
        subq.w       #$1, d7                                       ; $01FD8C

loc_01FD8E:
        clr.w        d6                                            ; $01FD8E
        move.b       $4(a1), d6                                    ; $01FD90
        subq.w       #$1, d6                                       ; $01FD94
        movem.l      d1/a1/a3-a4, -(a7)                            ; $01FD96

loc_01FD9A:
        movea.l      a2, a1                                        ; $01FD9A
        move.b       (a3), -$6f31(a6)                              ; $01FD9C
        clr.l        d3                                            ; $01FDA0
        move.w       (a4), d3                                      ; $01FDA2
        lsl.w        #$1, d3                                       ; $01FDA4
        ext.l        d3                                            ; $01FDA6
        lsl.l        #$8, d3                                       ; $01FDA8
        adda.l       d3, a1                                        ; $01FDAA
        movem.l      d0-d2/d4-d7/a0/a2-a4, -(a7)                   ; $01FDAC
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01FDB0
        movem.l      (a7)+, d0-d2/d4-d7/a0/a2-a4                   ; $01FDB6
        addq.w       #$1, a3                                       ; $01FDBA
        addq.w       #$2, a4                                       ; $01FDBC
        add.w        d4, d1                                        ; $01FDBE
        dbra         d6, loc_01FD9A                                ; $01FDC0
        movem.l      (a7)+, d1/a1/a3-a4                            ; $01FDC4
        add.w        d0, d2                                        ; $01FDC8
        addq.w       #$4, a3                                       ; $01FDCA
        addq.l       #$8, a4                                       ; $01FDCC
        dbra         d7, loc_01FD8E                                ; $01FDCE
        rts                                                        ; $01FDD2
        ifne *-$1FDD4
        fail "ROM end moved"
        endif
