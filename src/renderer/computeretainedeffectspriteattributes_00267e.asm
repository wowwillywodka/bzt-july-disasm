; $00267E..$0026CF | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 264C] Преобразование координат объекта (D1+=0xb0,D2+=0xe0) и проверка X-границ для вычисления флагов отсечения/видимости на экране
        ifne *-$267E
        fail "ROM start moved"
        endif

ComputeRetainedEffectSpriteAttributes:
        addi.w       #$b0, d1                                      ; $00267E
        addi.w       #$e0, d2                                      ; $002682
        move.w       d1, d3                                        ; $002686
        andi.w       #$3, d3                                       ; $002688
        addi.w       #$c007, d3                                    ; $00268C
        cmpi.w       #$c6, d1                                      ; $002690
        blt.b        loc_0026A0                                    ; $002694
        cmpi.w       #$da, d1                                      ; $002696
        bgt.b        loc_0026A0                                    ; $00269A
        move.w       #$c00a, d3                                    ; $00269C

loc_0026A0:
        move.w       d5, -(a7)                                     ; $0026A0
        addi.w       #$18, d5                                      ; $0026A2
        cmp.w        d5, d2                                        ; $0026A6
        bgt.b        loc_0026B6                                    ; $0026A8
        subi.w       #$30, d5                                      ; $0026AA
        cmp.w        d5, d2                                        ; $0026AE
        blt.b        loc_0026B6                                    ; $0026B0
        move.w       #$c00b, d3                                    ; $0026B2

loc_0026B6:
        move.w       (a7)+, d5                                     ; $0026B6
        cmpi.w       #$d0, d1                                      ; $0026B8
        bgt.b        loc_0026C2                                    ; $0026BC
        ori.w        #$1000, d3                                    ; $0026BE

loc_0026C2:
        cmp.w        d5, d2                                        ; $0026C2
        bgt.b        loc_0026CA                                    ; $0026C4
        ori.w        #$800, d3                                     ; $0026C6

loc_0026CA:
        move.w       #$0, d0                                       ; $0026CA
        rts                                                        ; $0026CE
        ifne *-$26D0
        fail "ROM end moved"
        endif
