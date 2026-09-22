; $098D6E..$098DB3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Four interleaved RLE lanes, actual destination stride FOUR (postincrement + addq #3). No established caller/data source; geometry interpretation is unproven.
        ifne *-$98D6E
        fail "ROM start moved"
        endif

DecompressFourLaneRle:
; Four interleaved RLE lanes, actual destination stride FOUR (postincrement + addq #3). No established caller/data source; geometry interpretation is unproven.
        movem.l      d0-d5/a0-a5, -(a7)                            ; $098D6E
; Only low word of D0 is replaced before ADD.L A4: old high word is a caller precondition, not cleared here.
        move.w       (a3)+, d0                                     ; $098D72
        add.l        a4, d0                                        ; $098D74
        move.w       #$3, d3                                       ; $098D76
        movea.l      a4, a5                                        ; $098D7A
        moveq        #$0, d4                                       ; $098D7C

loc_098D7E:
        movea.l      a5, a4                                        ; $098D7E
        adda.l       d4, a4                                        ; $098D80

loc_098D82:
        clr.w        d1                                            ; $098D82
; Signed end comparison occurs between runs; runs may overshoot the inclusive bound. No per-byte bound check.
        cmp.l        a4, d0                                        ; $098D84
        blt.w        loc_098DA8                                    ; $098D86
        move.b       (a3)+, d1                                     ; $098D8A
        bmi.w        loc_098D9A                                    ; $098D8C

loc_098D90:
        move.b       (a3)+, (a4)+                                  ; $098D90
        addq.l       #$3, a4                                       ; $098D92
        dbra         d1, loc_098D90                                ; $098D94
        bra.b        loc_098D82                                    ; $098D98

loc_098D9A:
; NEG.B after CLR.W: negative control encodes (-signed_byte)+1 repetitions; $80 produces 129 writes.
        neg.b        d1                                            ; $098D9A

loc_098D9C:
        move.b       (a3), (a4)+                                   ; $098D9C
        addq.l       #$3, a4                                       ; $098D9E
        dbra         d1, loc_098D9C                                ; $098DA0
        addq.l       #$1, a3                                       ; $098DA4
        bra.b        loc_098D82                                    ; $098DA6

loc_098DA8:
        addq.w       #$1, d4                                       ; $098DA8
        dbra         d3, loc_098D7E                                ; $098DAA
        movem.l      (a7)+, d0-d5/a0-a5                            ; $098DAE
        rts                                                        ; $098DB2
        ifne *-$98DB4
        fail "ROM end moved"
        endif
