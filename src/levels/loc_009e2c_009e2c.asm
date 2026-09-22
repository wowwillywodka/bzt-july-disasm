; $009E2C..$009F7F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9E2C
        fail "ROM start moved"
        endif

loc_009E2C:
        move.w       rPlayerX(a6), d0                              ; $009E2C
        move.w       d0, d3                                        ; $009E30
        move.b       #$80, d3                                      ; $009E32
        sub.w        d3, d0                                        ; $009E36
        move.w       rPlayerY(a6), d1                              ; $009E38
        move.w       d1, d4                                        ; $009E3C
        move.b       #$80, d4                                      ; $009E3E
        sub.w        d4, d1                                        ; $009E42
        move.w       d3, d5                                        ; $009E44
        move.w       d4, d6                                        ; $009E46
        move.w       d0, d3                                        ; $009E48
        move.w       d1, d4                                        ; $009E4A
        bsr.w        OctagonalDistance                             ; $009E4C
        cmpi.w       #$28, d0                                      ; $009E50
        bcc.b        loc_009E7C                                    ; $009E54
        addq.w       #$1, d0                                       ; $009E56
        lsl.w        #$4, d3                                       ; $009E58
        move.w       d3, d1                                        ; $009E5A
        lsl.w        #$1, d3                                       ; $009E5C
        add.w        d1, d3                                        ; $009E5E
        lsl.w        #$4, d4                                       ; $009E60
        move.w       d4, d1                                        ; $009E62
        lsl.w        #$1, d4                                       ; $009E64
        add.w        d1, d4                                        ; $009E66
        ext.l        d3                                            ; $009E68
        ext.l        d4                                            ; $009E6A
        divs.w       d0, d3                                        ; $009E6C
        divs.w       d0, d4                                        ; $009E6E
        add.w        d5, d3                                        ; $009E70
        add.w        d6, d4                                        ; $009E72
        move.w       d3, rPlayerX(a6)                              ; $009E74
        move.w       d4, rPlayerY(a6)                              ; $009E78

loc_009E7C:
        rts                                                        ; $009E7C

loc_009E7E:
        move.w       rPlayerX(a6), d0                              ; $009E7E
        move.w       d0, d3                                        ; $009E82
        move.b       #$80, d3                                      ; $009E84
        sub.w        d3, d0                                        ; $009E88
        move.w       rPlayerY(a6), d1                              ; $009E8A
        move.w       d1, d4                                        ; $009E8E
        move.b       #$80, d4                                      ; $009E90
        sub.w        d4, d1                                        ; $009E94
        move.w       d3, d5                                        ; $009E96
        move.w       d4, d6                                        ; $009E98
        move.w       d0, d3                                        ; $009E9A
        move.w       d1, d4                                        ; $009E9C
        bsr.w        OctagonalDistance                             ; $009E9E
        cmpi.w       #$58, d0                                      ; $009EA2
        bcc.b        loc_009ECE                                    ; $009EA6
        addq.w       #$1, d0                                       ; $009EA8
        lsl.w        #$5, d3                                       ; $009EAA
        move.w       d3, d1                                        ; $009EAC
        lsl.w        #$1, d3                                       ; $009EAE
        add.w        d1, d3                                        ; $009EB0
        lsl.w        #$5, d4                                       ; $009EB2
        move.w       d4, d1                                        ; $009EB4
        lsl.w        #$1, d4                                       ; $009EB6
        add.w        d1, d4                                        ; $009EB8
        ext.l        d3                                            ; $009EBA
        ext.l        d4                                            ; $009EBC
        divs.w       d0, d3                                        ; $009EBE
        divs.w       d0, d4                                        ; $009EC0
        add.w        d5, d3                                        ; $009EC2
        add.w        d6, d4                                        ; $009EC4
        move.w       d3, rPlayerX(a6)                              ; $009EC6
        move.w       d4, rPlayerY(a6)                              ; $009ECA

loc_009ECE:
        rts                                                        ; $009ECE

loc_009ED0:
        asr.w        -$71d8(a6)                                    ; $009ED0
        clr.w        -$71d6(a6)                                    ; $009ED4
        clr.w        -$71d2(a6)                                    ; $009ED8
        rts                                                        ; $009EDC

loc_009EDE:
        move.w       -$6e4c(a6), d0                                ; $009EDE
        bpl.b        loc_009EE6                                    ; $009EE2
        neg.w        d0                                            ; $009EE4

loc_009EE6:
        cmpi.w       #$18, d0                                      ; $009EE6
        bcs.b        loc_009F46                                    ; $009EEA
        clr.w        d7                                            ; $009EEC
        move.w       rPlayerX(a6), d0                              ; $009EEE
        cmpi.b       #$20, d0                                      ; $009EF2
        bcc.b        loc_009F02                                    ; $009EF6
        move.b       #$20, -$7205(a6)                              ; $009EF8
        st.b         d7                                            ; $009EFE
        bra.b        loc_009F10                                    ; $009F00

loc_009F02:
        cmpi.b       #$df, d0                                      ; $009F02
        bls.b        loc_009F10                                    ; $009F06
        move.b       #$df, -$7205(a6)                              ; $009F08
        st.b         d7                                            ; $009F0E

loc_009F10:
        move.w       rPlayerY(a6), d0                              ; $009F10
        cmpi.b       #$20, d0                                      ; $009F14
        bcc.b        loc_009F24                                    ; $009F18
        move.b       #$20, -$7203(a6)                              ; $009F1A
        st.b         d7                                            ; $009F20
        bra.b        loc_009F32                                    ; $009F22

loc_009F24:
        cmpi.b       #$df, d0                                      ; $009F24
        bls.b        loc_009F32                                    ; $009F28
        move.b       #$df, -$7203(a6)                              ; $009F2A
        st.b         d7                                            ; $009F30

loc_009F32:
        tst.w        d7                                            ; $009F32
        beq.b        loc_009F46                                    ; $009F34
        clr.w        -$7154(a6)                                    ; $009F36
        clr.w        -$7150(a6)                                    ; $009F3A
        clr.w        -$7202(a6)                                    ; $009F3E
        clr.w        -$7200(a6)                                    ; $009F42

loc_009F46:
        rts                                                        ; $009F46

loc_009F48:
        asr.w        -$71d8(a6)                                    ; $009F48
        clr.w        -$71d6(a6)                                    ; $009F4C
        clr.w        -$71d2(a6)                                    ; $009F50
        btst.b       #$7, -$7203(a6)                               ; $009F54
        bne.b        loc_009F62                                    ; $009F5A
        move.b       #$80, -$7203(a6)                              ; $009F5C

loc_009F62:
        rts                                                        ; $009F62

loc_009F64:
        asr.w        -$71d8(a6)                                    ; $009F64
        clr.w        -$71d6(a6)                                    ; $009F68
        clr.w        -$71d2(a6)                                    ; $009F6C
        btst.b       #$7, -$7203(a6)                               ; $009F70
        beq.b        loc_009F7E                                    ; $009F76
        move.b       #$80, -$7203(a6)                              ; $009F78

loc_009F7E:
        rts                                                        ; $009F7E
        ifne *-$9F80
        fail "ROM end moved"
        endif
