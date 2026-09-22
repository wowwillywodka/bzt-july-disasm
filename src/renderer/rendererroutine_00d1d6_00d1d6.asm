; $00D1D6..$00D231 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проекция вершины 2 мир→камера: при совпадении с предыдущей точкой берёт кэш, иначе вычитает позицию камеры (-0x7206/-0x7204), поворот на sin/cos (-0x71f2/-0x71f0), даёт камера-координаты в (-0x7196)/(-0x7192) (глубина и боковое смещение)
        ifne *-$D1D6
        fail "ROM start moved"
        endif

RendererRoutine_00D1D6:
        cmp.w        -$718a(a6), d0                                ; $00D1D6
        bne.b        loc_00D1E2                                    ; $00D1DA
        cmp.w        -$7188(a6), d1                                ; $00D1DC
        beq.b        loc_00D214                                    ; $00D1E0

loc_00D1E2:
        clr.w        -$719a(a6)                                    ; $00D1E2
        move.w       d0, d4                                        ; $00D1E6
        sub.w        rPlayerX(a6), d4                              ; $00D1E8
        move.w       d4, d5                                        ; $00D1EC
        muls.w       -$71f2(a6), d4                                ; $00D1EE
        move.w       d1, d3                                        ; $00D1F2
        sub.w        rPlayerY(a6), d3                              ; $00D1F4
        move.w       d3, d6                                        ; $00D1F8
        muls.w       -$71f0(a6), d3                                ; $00D1FA
        add.l        d3, d4                                        ; $00D1FE
        move.l       d4, -$7196(a6)                                ; $00D200
        muls.w       -$71f2(a6), d6                                ; $00D204
        muls.w       -$71f0(a6), d5                                ; $00D208
        sub.l        d5, d6                                        ; $00D20C
        move.l       d6, -$7192(a6)                                ; $00D20E
        rts                                                        ; $00D212

loc_00D214:
        st.b         -$719a(a6)                                    ; $00D214
        move.l       -$7186(a6), -$7196(a6)                        ; $00D218
        move.l       -$7182(a6), -$7192(a6)                        ; $00D21E
        move.w       -$717e(a6), -$718e(a6)                        ; $00D224
        move.w       -$717c(a6), -$718c(a6)                        ; $00D22A
        rts                                                        ; $00D230
        ifne *-$D232
        fail "ROM end moved"
        endif
