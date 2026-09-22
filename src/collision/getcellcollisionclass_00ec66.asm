; $00EC66..$00EC6B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D3.w=cell type with high byte zero; replace low byte with PlayerCollisionCellClasses[type], return Z from MOVE.B. Classes0 clear,1 solid,2..5 diagonal half-cells,6/7 blocked here.
        ifne *-$EC66
        fail "ROM start moved"
        endif

GetCellCollisionClass:
; D3.w=cell type with high byte zero; replace low byte with PlayerCollisionCellClasses[type], return Z from MOVE.B. Classes0 clear,1 solid,2..5 diagonal half-cells,6/7 blocked here.
        move.b       PlayerCollisionCellClasses(pc, d3.w), d3      ; $00EC66
        rts                                                        ; $00EC6A
        ifne *-$EC6C
        fail "ROM end moved"
        endif
