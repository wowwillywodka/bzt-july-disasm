; $00A3D2..$00A3E7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Классификатор клетки: читает байт карты по (-$71e0,A6), индексирует таблицу типов клетка→токен $24ea(a6), затем PC-таблицу $a3e8 — возврат кода обработчика спецклетки
        ifne *-$A3D2
        fail "ROM start moved"
        endif

ObjectsRoutine_00A3D2:
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
