; $02267E..$022711 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 540CE] хелпер экранного вывода (регион 0x54xxx заставок)
        ifne *-$2267E
        fail "ROM start moved"
        endif

UiRoutine_02267E:
        move.w       d3, d6                                        ; $02267E
        bra.b        loc_0226C8                                    ; $022680

loc_022682:
        subq.w       #$2, d3                                       ; $022682

loc_022684:
        move.w       d3, d6                                        ; $022684
        bra.b        loc_0226C8                                    ; $022686

loc_022688:
        andi.w       #$e0, d1                                      ; $022688
        andi.w       #$e0, d3                                      ; $02268C
        lsr.w        #$4, d1                                       ; $022690
        lsr.w        #$4, d3                                       ; $022692
        cmp.w        d1, d3                                        ; $022694
        beq.b        loc_0226A4                                    ; $022696
        st.b         d0                                            ; $022698
        bgt.b        loc_0226A2                                    ; $02269A
        addq.w       #$2, d3                                       ; $02269C
        move.w       d3, d6                                        ; $02269E
        bra.b        loc_0226D4                                    ; $0226A0

loc_0226A2:
        subq.w       #$2, d3                                       ; $0226A2

loc_0226A4:
        move.w       d3, d6                                        ; $0226A4
        bra.b        loc_0226D4                                    ; $0226A6

loc_0226A8:
        andi.w       #$e00, d1                                     ; $0226A8
        andi.w       #$e00, d3                                     ; $0226AC
        lsr.w        #$8, d1                                       ; $0226B0
        lsr.w        #$8, d3                                       ; $0226B2
        cmp.w        d1, d3                                        ; $0226B4
        beq.b        loc_0226C4                                    ; $0226B6
        st.b         d0                                            ; $0226B8
        bgt.b        loc_0226C2                                    ; $0226BA
        addq.w       #$2, d3                                       ; $0226BC
        move.w       d3, d6                                        ; $0226BE
        bra.b        loc_0226E4                                    ; $0226C0

loc_0226C2:
        subq.w       #$2, d3                                       ; $0226C2

loc_0226C4:
        move.w       d3, d6                                        ; $0226C4
        bra.b        loc_0226E4                                    ; $0226C6

loc_0226C8:
        move.w       d2, d4                                        ; $0226C8
        andi.w       #$ee0, d4                                     ; $0226CA
        or.w         d6, d4                                        ; $0226CE
        move.w       d4, (a0)                                      ; $0226D0
        bra.b        loc_0226F2                                    ; $0226D2

loc_0226D4:
        move.w       d2, d4                                        ; $0226D4
        andi.w       #$e0e, d4                                     ; $0226D6
        move.w       d6, d5                                        ; $0226DA
        lsl.w        #$4, d5                                       ; $0226DC
        or.w         d5, d4                                        ; $0226DE
        move.w       d4, (a0)                                      ; $0226E0
        bra.b        loc_0226F2                                    ; $0226E2

loc_0226E4:
        move.w       d2, d4                                        ; $0226E4
        andi.w       #$ee, d4                                      ; $0226E6
        move.w       d6, d5                                        ; $0226EA
        lsl.w        #$8, d5                                       ; $0226EC
        or.w         d5, d4                                        ; $0226EE
        move.w       d4, (a0)                                      ; $0226F0

loc_0226F2:
        addq.w       #$2, a0                                       ; $0226F2
        addq.w       #$2, a1                                       ; $0226F4
        dbra         d7, loc_022656                                ; $0226F6

loc_0226FA:
        tst.w        d0                                            ; $0226FA
        bne.b        loc_02270C                                    ; $0226FC
        cmpi.w       #$14, -$7808(a6)                              ; $0226FE
        beq.b        loc_022710                                    ; $022704
        addq.w       #$1, -$7808(a6)                               ; $022706
        rts                                                        ; $02270A

loc_02270C:
        clr.w        -$7808(a6)                                    ; $02270C

loc_022710:
        rts                                                        ; $022710
        ifne *-$22712
        fail "ROM end moved"
        endif
