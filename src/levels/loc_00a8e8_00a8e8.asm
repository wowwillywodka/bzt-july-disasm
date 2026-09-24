; $00A8E8..$00A8FF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0xA3D2] Классификатор клетки: читает байт карты по (-$71e0,A6), индексирует таблицу типов клетка→токен $24ea(a6), затем PC-таблицу $a3e8 — возврат кода обработчика спецклетки
        ifne *-$A8E8
        fail "ROM start moved"
        endif

loc_00A8E8:
        move.l       a0, rCellRenderStateSourcePointer(a6)                                ; $00A8E8
        bsr.w        RecordVisibleCellRenderState                        ; $00A8EC
        st.b         rCellSideEffectsSuppressed(a6)                                    ; $00A8F0
        lea.l        rVisibleWallYCache(a6), a3                                ; $00A8F4
        cmpa.l       rVisibleWallYCacheEnd(a6), a3                                ; $00A8F8
        beq.b        loc_00A90A                                    ; $00A8FC

loc_00A8FE:
        cmpa.l       (a3)+, a0                                     ; $00A8FE
        ifne *-$A900
        fail "ROM end moved"
        endif
