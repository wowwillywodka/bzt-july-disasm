; $00C74E..$00C77D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Зонд клетки X-луча: celltype через (0,A5,D3), 0 если проходима; спецслучай type2 с краевым тестом по (A4), рекурсия в очередь-диспетчер 0x8b50 для типов >=6
        ifne *-$C74E
        fail "ROM start moved"
        endif

RendererRoutine_00C74E:
        andi.w       #$ff, d3                                      ; $00C74E
        move.b       (a5, d3.w), d3                                ; $00C752
        bne.b        loc_00C75A                                    ; $00C756
        rts                                                        ; $00C758

loc_00C75A:
        cmpi.b       #$6, d3                                       ; $00C75A
        bcc.b        loc_00C772                                    ; $00C75E
        cmpi.b       #$2, d3                                       ; $00C760
        bne.b        loc_00C770                                    ; $00C764
        move.w       d2, d3                                        ; $00C766
        add.w        (a4), d3                                      ; $00C768
        cmp.w        d7, d3                                        ; $00C76A
        bhi.b        loc_00C77A                                    ; $00C76C
        moveq        #$2, d3                                       ; $00C76E

loc_00C770:
        rts                                                        ; $00C770

loc_00C772:
        bsr.w        DispatchVisibleCell                           ; $00C772
        bne.b        loc_00C75A                                    ; $00C776
        rts                                                        ; $00C778

loc_00C77A:
        clr.w        d3                                            ; $00C77A
        rts                                                        ; $00C77C
        ifne *-$C77E
        fail "ROM end moved"
        endif
