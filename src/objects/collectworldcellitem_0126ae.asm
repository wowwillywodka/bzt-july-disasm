; $0126AE..$0126F7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; World pickup selector: $85->$25, $82->item 13, $36->item 14, $28->item 4; $25 uses special health branch. Names in this July ROM differ from editor/earlier-game labels.
        ifne *-$126AE
        fail "ROM start moved"
        endif

CollectWorldCellItem:
; World pickup selector: $85->$25, $82->item 13, $36->item 14, $28->item 4; $25 uses special health branch. Names in this July ROM differ from editor/earlier-game labels.
        tst.w        rPlayerDeathTicks(a6)                         ; $0126AE
        bne.b        loc_0126F6                                    ; $0126B2
        cmpi.b       #$85, d3                                      ; $0126B4
        bne.b        loc_0126BE                                    ; $0126B8
        move.b       #$25, d3                                      ; $0126BA

loc_0126BE:
        cmpi.b       #$82, d3                                      ; $0126BE
        beq.w        loc_0127EE                                    ; $0126C2
        cmpi.b       #$8c, d3                                      ; $0126C6
        beq.w        loc_0127DC                                    ; $0126CA
        cmpi.b       #$36, d3                                      ; $0126CE
        beq.w        loc_0127D6                                    ; $0126D2
        clr.w        d0                                            ; $0126D6
        move.b       d3, d0                                        ; $0126D8
        subi.w       #$18, d0                                      ; $0126DA
        cmpi.w       #$10, d0                                      ; $0126DE
        bne.b        loc_0126E8                                    ; $0126E2
        move.w       #$4, d0                                       ; $0126E4

loc_0126E8:
        cmpi.w       #$10, d0                                      ; $0126E8
        bhi.b        loc_0126F6                                    ; $0126EC
        lsl.w        #$2, d0                                       ; $0126EE
        movea.l      ItemPlacementHandlers(pc, d0.w), a1           ; $0126F0
        jmp          (a1)                                          ; $0126F4

loc_0126F6:
        rts                                                        ; $0126F6
        ifne *-$126F8
        fail "ROM end moved"
        endif
