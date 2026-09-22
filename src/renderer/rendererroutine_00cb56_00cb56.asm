; $00CB56..$00CB85 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проверка попадания луча в клетку (ветка A0): celltype=(A5,D3), при 0 промах; код 4 (грань стены) с add (A4),D3>D7 даёт чистый промах clr, иначе hit; celltype>=6 рекурсивно через диспетчер 0x8b50; возврат hit через Z-флаг
        ifne *-$CB56
        fail "ROM start moved"
        endif

RendererRoutine_00CB56:
        andi.w       #$ff, d3                                      ; $00CB56
        move.b       (a5, d3.w), d3                                ; $00CB5A
        bne.b        loc_00CB62                                    ; $00CB5E
        rts                                                        ; $00CB60

loc_00CB62:
        cmpi.b       #$6, d3                                       ; $00CB62
        bcc.b        loc_00CB7A                                    ; $00CB66
        cmpi.b       #$4, d3                                       ; $00CB68
        bne.b        loc_00CB78                                    ; $00CB6C
        move.w       d2, d3                                        ; $00CB6E
        add.w        (a4), d3                                      ; $00CB70
        cmp.w        d7, d3                                        ; $00CB72
        bhi.b        loc_00CB82                                    ; $00CB74
        moveq        #$4, d3                                       ; $00CB76

loc_00CB78:
        rts                                                        ; $00CB78

loc_00CB7A:
        bsr.w        DispatchVisibleCell                           ; $00CB7A
        bne.b        loc_00CB62                                    ; $00CB7E
        rts                                                        ; $00CB80

loc_00CB82:
        clr.w        d3                                            ; $00CB82
        rts                                                        ; $00CB84
        ifne *-$CB86
        fail "ROM end moved"
        endif
