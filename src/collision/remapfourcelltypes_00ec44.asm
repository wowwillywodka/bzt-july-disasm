; $00EC44..$00EC65 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Перевод 4 сырых байтов celltype (D3-D6) через таблицу свойств клеток @0xec6c (lookup проходимости/типа стены)
        ifne *-$EC44
        fail "ROM start moved"
        endif

RemapFourCellTypes:
        andi.w       #$ff, d3                                      ; $00EC44
        andi.w       #$ff, d4                                      ; $00EC48
        andi.w       #$ff, d5                                      ; $00EC4C
        andi.w       #$ff, d6                                      ; $00EC50
        move.b       PlayerCollisionCellClasses(pc, d3.w), d3      ; $00EC54
        move.b       PlayerCollisionCellClasses(pc, d4.w), d4      ; $00EC58
        move.b       PlayerCollisionCellClasses(pc, d5.w), d5      ; $00EC5C
        move.b       PlayerCollisionCellClasses(pc, d6.w), d6      ; $00EC60
        rts                                                        ; $00EC64
        ifne *-$EC66
        fail "ROM end moved"
        endif
