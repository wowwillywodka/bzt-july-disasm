; $012008..$012099 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Queue a 10-byte world object record: local cell coordinates, type word, projected scale and screen X. Center is cell +$80; depth below 2 is rejected. See docs/OBJECT_GRAPHICS.md.
        ifne *-$12008
        fail "ROM start moved"
        endif

QueueProjectedWorldObject:
; Queue a 10-byte world object record: local cell coordinates, type word, projected scale and screen X. Center is cell +$80; depth below 2 is rejected. See docs/OBJECT_GRAPHICS.md.
        movem.l      d0/a3, -(a7)                                  ; $012008
        swap         d0                                            ; $01200C
        move.w       d1, d0                                        ; $01200E
        swap         d0                                            ; $012010
        lea.l        -$6f18(a6), a3                                ; $012012

loc_012016:
        cmpa.l       -$6e50(a6), a3                                ; $012016
        beq.b        loc_012026                                    ; $01201A
        cmp.l        (a3), d0                                      ; $01201C
        beq.b        loc_012094                                    ; $01201E
        adda.w       #$a, a3                                       ; $012020
        bra.b        loc_012016                                    ; $012024

loc_012026:
        cmpa.l       #$ff11b0, a3                                  ; $012026
        beq.b        loc_012094                                    ; $01202C
        movem.l      d1/d3-d6, -(a7)                               ; $01202E
        move.l       d0, (a3)+                                     ; $012032
        clr.b        (a3)+                                         ; $012034
        move.b       d3, (a3)+                                     ; $012036
        add.w        rPlayerCellX(a6), d0                          ; $012038
        lsl.w        #$8, d0                                       ; $01203C
        add.w        rPlayerCellY(a6), d1                          ; $01203E
        lsl.w        #$8, d1                                       ; $012042
        addi.w       #$80, d0                                      ; $012044
        addi.w       #$80, d1                                      ; $012048
        move.w       d0, d4                                        ; $01204C
        sub.w        rPlayerX(a6), d4                              ; $01204E
        move.w       d4, d5                                        ; $012052
        muls.w       -$71f2(a6), d4                                ; $012054
        move.w       d1, d3                                        ; $012058
        sub.w        rPlayerY(a6), d3                              ; $01205A
        move.w       d3, d6                                        ; $01205E
        muls.w       -$71f0(a6), d3                                ; $012060
        add.l        d3, d4                                        ; $012064
        muls.w       -$71f2(a6), d6                                ; $012066
        muls.w       -$71f0(a6), d5                                ; $01206A
        sub.l        d5, d6                                        ; $01206E
        asr.l        #$6, d4                                       ; $012070
        cmpi.l       #$2, d4                                       ; $012072
        blt.b        loc_012090                                    ; $012078
        divs.w       d4, d6                                        ; $01207A
        addi.w       #$40, d6                                      ; $01207C
        move.l       #$10000, d5                                   ; $012080
        divs.w       d4, d5                                        ; $012086
        move.w       d5, (a3)+                                     ; $012088
        move.w       d6, (a3)+                                     ; $01208A
        move.l       a3, -$6e50(a6)                                ; $01208C

loc_012090:
        movem.l      (a7)+, d1/d3-d6                               ; $012090

loc_012094:
        movem.l      (a7)+, d0/a3                                  ; $012094
        rts                                                        ; $012098
        ifne *-$1209A
        fail "ROM end moved"
        endif
