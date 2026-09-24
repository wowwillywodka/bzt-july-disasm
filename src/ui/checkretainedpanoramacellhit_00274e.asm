; $00274E..$002775 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; По указателю -$71e0(a6) читает байт-токен, индексирует таблицу $24ea(a6), сравнивает с $28/$27: при $28 идёт на тряску $2776, при $27 — на $276c (проверка порога), иначе rts
        ifne *-$274E
        fail "ROM start moved"
        endif

CheckRetainedPanoramaCellHit:
        movea.l      rPlayerCellPointer(a6), a0                    ; $00274E
        clr.w        d3                                            ; $002752
        move.b       (a0), d3                                      ; $002754
        lea.l        rCellTypeByIndex(a6), a0                      ; $002756
        move.b       (a0, d3.w), d3                                ; $00275A
        cmpi.b       #$28, d3                                      ; $00275E
        beq.b        ApplyRetainedPanoramaCellHit                           ; $002762
        cmpi.b       #$27, d3                                      ; $002764
        beq.b        loc_00276C                                    ; $002768
        rts                                                        ; $00276A

loc_00276C:
        cmpi.w       #$fff6, rPlayerViewOffsetZ(a6)                            ; $00276C
        bgt.b        ApplyRetainedPanoramaCellHit                           ; $002772
        rts                                                        ; $002774
        ifne *-$2776
        fail "ROM end moved"
        endif
