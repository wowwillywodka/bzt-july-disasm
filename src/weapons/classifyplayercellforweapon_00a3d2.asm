; $00A3D2..$00A3E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; Return D3.b = 0 or 1 for the cell beneath the player. First resolve the raw
; map byte to a cell type, then index PlayerInteractionCellClasses. Callers
; branch on Z to select weapon shot/actor behavior; this routine spawns nothing.
        ifne *-$A3D2
        fail "ROM start moved"
        endif

ClassifyPlayerCellForWeapon:
        movea.l      rPlayerCellPointer(a6), a1                    ; $00A3D2
        clr.w        d3                                            ; $00A3D6
        move.b       (a1), d3                                      ; $00A3D8
        lea.l        rCellTypeByIndex(a6), a1                      ; $00A3DA
        move.b       (a1, d3.w), d3                                ; $00A3DE
        move.b       PlayerInteractionCellClasses(pc, d3.w), d3    ; $00A3E2
        rts                                                        ; $00A3E6
        ifne *-$A3E8
        fail "ROM end moved"
        endif
