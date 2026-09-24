; $00EDAA..$00EDDB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Entered-cell dispatcher. Raw map byte -> episode cell type;
; skip <=$05 or >$94, remap $85 to $25, then call CellInteractionHandlers.
        ifne *-$EDAA
        fail "ROM start moved"
        endif

DispatchEnteredCellInteraction:
        lea.l        rCellTypeByIndex(a6), a5                      ; $00EDAA
        clr.w        d3                                            ; $00EDAE
        move.b       (a0), d3                                      ; $00EDB0
        move.b       (a5, d3.w), d3                                ; $00EDB2
        cmpi.b       #$5, d3                                       ; $00EDB6
        bls.b        loc_00EDDA                                    ; $00EDBA
        cmpi.b       #$85, d3                                      ; $00EDBC
        bne.b        loc_00EDC6                                    ; $00EDC0
        move.b       #$25, d3                                      ; $00EDC2

loc_00EDC6:
        cmpi.b       #$94, d3                                      ; $00EDC6
        bhi.b        loc_00EDDA                                    ; $00EDCA
        lsl.w        #$2, d3                                       ; $00EDCC
        movea.l      CellInteractionHandlers(pc, d3.w), a3         ; $00EDCE
        lsr.w        #$2, d3                                       ; $00EDD2
        move.l       a0, -(a7)                                     ; $00EDD4
        jsr          (a3)                                          ; $00EDD6
        movea.l      (a7)+, a0                                     ; $00EDD8

loc_00EDDA:
        rts                                                        ; $00EDDA
        ifne *-$EDDC
        fail "ROM end moved"
        endif
