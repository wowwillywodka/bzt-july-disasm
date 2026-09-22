; $00C952..$00C981 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зонд клетки X-луча (восходящий октант): celltype через (0,A5,D3), спецслучай type3 с краевым тестом по (A4), рекурсия в 0x8b50 для типов >=6
        ifne *-$C952
        fail "ROM start moved"
        endif

RendererRoutine_00C952:
        andi.w       #$ff, d3                                      ; $00C952
        move.b       (a5, d3.w), d3                                ; $00C956
        bne.b        loc_00C95E                                    ; $00C95A
        rts                                                        ; $00C95C

loc_00C95E:
        cmpi.b       #$6, d3                                       ; $00C95E
        bcc.b        loc_00C976                                    ; $00C962
        cmpi.b       #$3, d3                                       ; $00C964
        bne.b        loc_00C974                                    ; $00C968
        move.w       d2, d3                                        ; $00C96A
        add.w        (a4), d3                                      ; $00C96C
        cmp.w        d7, d3                                        ; $00C96E
        bhi.b        loc_00C97E                                    ; $00C970
        moveq        #$3, d3                                       ; $00C972

loc_00C974:
        rts                                                        ; $00C974

loc_00C976:
        bsr.w        DispatchVisibleCell                           ; $00C976
        bne.b        loc_00C95E                                    ; $00C97A
        rts                                                        ; $00C97C

loc_00C97E:
        clr.w        d3                                            ; $00C97E
        rts                                                        ; $00C980
        ifne *-$C982
        fail "ROM end moved"
        endif
