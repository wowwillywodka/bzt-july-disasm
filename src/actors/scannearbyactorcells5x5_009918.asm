; $009918..$009973 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$9918
        fail "ROM start moved"
        endif

ScanNearbyActorCells5x5:
; 5x5 helper has a direct Type06 call at $01989C; bounds use player XY although A0 may be an actor cell.
        move.w       rPlayerY(a6), d0                              ; $009918
        asr.w        #$8, d0                                       ; $00991C
        subq.w       #$3, d0                                       ; $00991E
        lea.l        -$42(a0), a1                                  ; $009920
        move.w       #$4, d6                                       ; $009924

loc_009928:
        addq.w       #$1, d0                                       ; $009928
        bmi.b        loc_00996A                                    ; $00992A
        cmpi.w       #$20, d0                                      ; $00992C
        bcc.b        loc_009972                                    ; $009930
        move.w       rPlayerX(a6), d1                              ; $009932
        asr.w        #$8, d1                                       ; $009936
        subq.w       #$3, d1                                       ; $009938
        move.w       #$4, d7                                       ; $00993A

loc_00993E:
        addq.w       #$1, d1                                       ; $00993E
        bmi.b        loc_009962                                    ; $009940
        cmpi.w       #$20, d1                                      ; $009942
        bcc.b        loc_009962                                    ; $009946
        clr.w        d3                                            ; $009948
        move.b       (a1), d3                                      ; $00994A
        move.b       (a5, d3.w), d3                                ; $00994C
        move.b       (a4, d3.w), d3                                ; $009950
        beq.b        loc_009962                                    ; $009954
        movem.w      d1/d6, -(a7)                                  ; $009956
        bsr.w        SelectActorDefinitionFromCell                 ; $00995A
        movem.w      (a7)+, d1/d6                                  ; $00995E

loc_009962:
        addq.w       #$1, a1                                       ; $009962
        dbra         d7, loc_00993E                                ; $009964
        subq.w       #$5, a1                                       ; $009968

loc_00996A:
        adda.w       #$20, a1                                      ; $00996A
        dbra         d6, loc_009928                                ; $00996E

loc_009972:
        rts                                                        ; $009972
        ifne *-$9974
        fail "ROM end moved"
        endif
