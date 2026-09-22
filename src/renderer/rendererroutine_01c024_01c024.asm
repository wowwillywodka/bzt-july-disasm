; $01C024..$01C08F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Удаление элемента из кучи depth-сортировки спрайтов: декремент счётчика (-0x57c0,A6), просеивание 8-байтных записей массива (-0x57be,A6) по ключу-глубине с перестановкой пар (move.l) — поддержка порядка отрисовки
        ifne *-$1C024
        fail "ROM start moved"
        endif

RendererRoutine_01C024:
        lea.l        -$57be(a6), a2                                ; $01C024
        subq.w       #$1, -$57c0(a6)                               ; $01C028
        move.w       -$57c0(a6), d4                                ; $01C02C
        move.w       d4, d5                                        ; $01C030
        asl.w        #$3, d5                                       ; $01C032
        move.w       (a2, d5.w), d5                                ; $01C034
        clr.w        d0                                            ; $01C038
        clr.w        d1                                            ; $01C03A

loc_01C03C:
        move.w       d0, d2                                        ; $01C03C
        asl.w        #$1, d2                                       ; $01C03E
        addq.w       #$1, d2                                       ; $01C040
        cmp.w        d4, d2                                        ; $01C042
        bge.b        loc_01C07C                                    ; $01C044
        move.w       d2, d0                                        ; $01C046
        addq.w       #$1, d2                                       ; $01C048
        cmp.w        d4, d2                                        ; $01C04A
        bge.b        loc_01C05E                                    ; $01C04C
        move.w       d0, d2                                        ; $01C04E
        asl.w        #$3, d2                                       ; $01C050
        move.w       $8(a2, d2.w), d3                              ; $01C052
        cmp.w        (a2, d2.w), d3                                ; $01C056
        bge.b        loc_01C05E                                    ; $01C05A
        addq.w       #$1, d0                                       ; $01C05C

loc_01C05E:
        move.w       d0, d2                                        ; $01C05E
        asl.w        #$3, d2                                       ; $01C060
        cmp.w        (a2, d2.w), d5                                ; $01C062
        ble.b        loc_01C07C                                    ; $01C066
        move.w       d1, d3                                        ; $01C068
        asl.w        #$3, d3                                       ; $01C06A
        move.l       (a2, d2.w), (a2, d3.w)                        ; $01C06C
        move.l       $4(a2, d2.w), $4(a2, d3.w)                    ; $01C072
        move.w       d0, d1                                        ; $01C078
        bra.b        loc_01C03C                                    ; $01C07A

loc_01C07C:
        asl.w        #$3, d4                                       ; $01C07C
        move.w       d1, d3                                        ; $01C07E
        asl.w        #$3, d3                                       ; $01C080
        move.l       (a2, d4.w), (a2, d3.w)                        ; $01C082
        move.l       $4(a2, d4.w), $4(a2, d3.w)                    ; $01C088
        rts                                                        ; $01C08E
        ifne *-$1C090
        fail "ROM end moved"
        endif
