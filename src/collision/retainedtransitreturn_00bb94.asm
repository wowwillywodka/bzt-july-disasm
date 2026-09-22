; $00BB94..$00BBE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$BB94
        fail "ROM start moved"
        endif

RetainedTransitReturn:
        rts                                                        ; $00BB94

loc_00BB96:
        subq.w       #$4, -$6e4c(a6)                               ; $00BB96
        bpl.b        loc_00BBD6                                    ; $00BB9A
        move.w       #$2, -$6e4a(a6)                               ; $00BB9C
        clr.w        -$6e4c(a6)                                    ; $00BBA2
        rts                                                        ; $00BBA6

loc_00BBA8:
        cmpi.b       #$32, d3                                      ; $00BBA8
        beq.b        loc_00BBD8                                    ; $00BBAC
        cmpi.b       #$51, d3                                      ; $00BBAE
        beq.b        loc_00BBD8                                    ; $00BBB2
        cmpi.b       #$55, d3                                      ; $00BBB4
        beq.b        loc_00BBD8                                    ; $00BBB8
        cmpi.b       #$59, d3                                      ; $00BBBA
        beq.b        loc_00BBD8                                    ; $00BBBE
        addq.w       #$4, -$6e4c(a6)                               ; $00BBC0
        cmpi.w       #$40, -$6e4c(a6)                              ; $00BBC4
        ble.b        loc_00BBD6                                    ; $00BBCA
        move.w       #$ffc0, -$6e4c(a6)                            ; $00BBCC
        bra.w        RequestLowerFloorTransition                   ; $00BBD2

loc_00BBD6:
        rts                                                        ; $00BBD6

loc_00BBD8:
        addq.w       #$4, -$6e4c(a6)                               ; $00BBD8
        bmi.b        loc_00BBD6                                    ; $00BBDC
        move.w       #$fffe, -$6e4a(a6)                            ; $00BBDE
        clr.w        -$6e4c(a6)                                    ; $00BBE4
        rts                                                        ; $00BBE8
        ifne *-$BBEA
        fail "ROM end moved"
        endif
