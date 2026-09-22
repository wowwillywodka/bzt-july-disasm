; $00CD5A..$00CD89 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проверка попадания луча в клетку (ветка A0, грань 5): celltype=(A5,D3), при 0 промах; код 5 с add (A4),D3>D7 даёт чистый промах clr, иначе hit; celltype>=6 рекурсия в диспетчер 0x8b50; результат в Z-флаге
        ifne *-$CD5A
        fail "ROM start moved"
        endif

RendererRoutine_00CD5A:
        andi.w       #$ff, d3                                      ; $00CD5A
        move.b       (a5, d3.w), d3                                ; $00CD5E
        bne.b        loc_00CD66                                    ; $00CD62
        rts                                                        ; $00CD64

loc_00CD66:
        cmpi.b       #$6, d3                                       ; $00CD66
        bcc.b        loc_00CD7E                                    ; $00CD6A
        cmpi.b       #$5, d3                                       ; $00CD6C
        bne.b        loc_00CD7C                                    ; $00CD70
        move.w       d2, d3                                        ; $00CD72
        add.w        (a4), d3                                      ; $00CD74
        cmp.w        d7, d3                                        ; $00CD76
        bhi.b        loc_00CD86                                    ; $00CD78
        moveq        #$5, d3                                       ; $00CD7A

loc_00CD7C:
        rts                                                        ; $00CD7C

loc_00CD7E:
        bsr.w        DispatchVisibleCell                           ; $00CD7E
        bne.b        loc_00CD66                                    ; $00CD82
        rts                                                        ; $00CD84

loc_00CD86:
        clr.w        d3                                            ; $00CD86
        rts                                                        ; $00CD88
        ifne *-$CD8A
        fail "ROM end moved"
        endif
