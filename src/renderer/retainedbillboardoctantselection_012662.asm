; $012662..$0126AD | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$12662
        fail "ROM start moved"
        endif

RetainedBillboardOctantSelection:
        tst.w        d5                                            ; $012662
        bmi.b        loc_01268A                                    ; $012664
        tst.w        d6                                            ; $012666
        bmi.b        loc_012678                                    ; $012668
        move.w       #$6, d7                                       ; $01266A
        cmp.w        d6, d5                                        ; $01266E
        bhi.b        loc_0126AC                                    ; $012670
        move.w       #$7, d7                                       ; $012672
        bra.b        loc_0126AC                                    ; $012676

loc_012678:
        move.w       d6, d3                                        ; $012678
        neg.w        d3                                            ; $01267A
        move.w       #$5, d7                                       ; $01267C
        cmp.w        d3, d5                                        ; $012680
        bhi.b        loc_0126AC                                    ; $012682
        move.w       #$4, d7                                       ; $012684
        bra.b        loc_0126AC                                    ; $012688

loc_01268A:
        tst.w        d6                                            ; $01268A
        bmi.b        loc_0126A0                                    ; $01268C
        move.w       d5, d3                                        ; $01268E
        neg.w        d3                                            ; $012690
        move.w       #$1, d7                                       ; $012692
        cmp.w        d6, d3                                        ; $012696
        bgt.b        loc_0126AC                                    ; $012698
        move.w       #$0, d7                                       ; $01269A
        bra.b        loc_0126AC                                    ; $01269E

loc_0126A0:
        move.w       #$2, d7                                       ; $0126A0
        cmp.w        d6, d5                                        ; $0126A4
        blt.b        loc_0126AC                                    ; $0126A6
        move.w       #$3, d7                                       ; $0126A8

loc_0126AC:
        rts                                                        ; $0126AC
        ifne *-$126AE
        fail "ROM end moved"
        endif
