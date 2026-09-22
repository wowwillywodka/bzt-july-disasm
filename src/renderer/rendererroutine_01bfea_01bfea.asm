; $01BFEA..$01C023 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вставка спрайта в отсортированный по глубине список (-0x57be,A6): сдвигает 8-байтные записи, чтобы вставить пакет (D5=ключ масштаб/глубина, D6, A0) с сохранением порядка по D5 для рендера задних-к-передним
        ifne *-$1BFEA
        fail "ROM start moved"
        endif

RendererRoutine_01BFEA:
        lea.l        -$57be(a6), a2                                ; $01BFEA
        move.w       -$57c0(a6), d0                                ; $01BFEE
        addq.w       #$1, -$57c0(a6)                               ; $01BFF2
        move.w       d0, d1                                        ; $01BFF6
        bne.b        loc_01BFFC                                    ; $01BFF8
        rts                                                        ; $01BFFA

loc_01BFFC:
        subq.w       #$1, d1                                       ; $01BFFC
        asr.w        #$1, d1                                       ; $01BFFE
        move.w       d1, d2                                        ; $01C000
        asl.w        #$3, d2                                       ; $01C002
        cmp.w        (a2, d2.w), d5                                ; $01C004
        bge.b        loc_01C01E                                    ; $01C008
        move.w       d0, d3                                        ; $01C00A
        asl.w        #$3, d3                                       ; $01C00C
        move.l       (a2, d2.w), (a2, d3.w)                        ; $01C00E
        move.l       $4(a2, d2.w), $4(a2, d3.w)                    ; $01C014
        move.w       d1, d0                                        ; $01C01A
        bne.b        loc_01BFFC                                    ; $01C01C

loc_01C01E:
        asl.w        #$3, d0                                       ; $01C01E
        adda.w       d0, a2                                        ; $01C020
        rts                                                        ; $01C022
        ifne *-$1C024
        fail "ROM end moved"
        endif
