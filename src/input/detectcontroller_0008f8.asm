; $0008F8..$000975 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Детекция типа контроллера на $A10003: toggling $40/$00, чтение ID-nibble, сверка с 4/0xD; ставит/сбрасывает флаг наличия пада в $FF0018
        ifne *-$8F8
        fail "ROM start moved"
        endif

DetectController:
        movea.l      #PAD1_DATA, a0                                ; $0008F8
        moveq        #$0, d0                                       ; $0008FE
        move.l       d0, d1                                        ; $000900
        move.b       #$40, $6(a0)                                  ; $000902
        nop                                                        ; $000908
        nop                                                        ; $00090A
        move.b       #$40, (a0)                                    ; $00090C
        nop                                                        ; $000910
        nop                                                        ; $000912
        move.b       (a0), d0                                      ; $000914
        move.b       #$0, (a0)                                     ; $000916
        nop                                                        ; $00091A
        nop                                                        ; $00091C
        move.b       (a0), d1                                      ; $00091E
        move.b       #$40, (a0)                                    ; $000920
        move.w       d0, d2                                        ; $000924
        ror.w        #$1, d0                                       ; $000926
        lsr.b        #$1, d0                                       ; $000928
        rol.w        #$1, d0                                       ; $00092A
        lsr.b        #$1, d2                                       ; $00092C
        ror.w        #$1, d2                                       ; $00092E
        lsr.b        #$1, d2                                       ; $000930
        rol.w        #$1, d2                                       ; $000932
        or.b         d2, d0                                        ; $000934
        andi.b       #$3, d0                                       ; $000936
        lsl.b        #$2, d0                                       ; $00093A
        move.w       d1, d2                                        ; $00093C
        ror.w        #$1, d1                                       ; $00093E
        lsr.b        #$1, d1                                       ; $000940
        rol.w        #$1, d1                                       ; $000942
        lsr.b        #$1, d2                                       ; $000944
        ror.b        #$1, d2                                       ; $000946
        lsr.b        #$1, d2                                       ; $000948
        rol.b        #$1, d2                                       ; $00094A
        or.b         d2, d1                                        ; $00094C
        andi.b       #$3, d1                                       ; $00094E
        or.b         d1, d0                                        ; $000952
        andi.b       #$f, d0                                       ; $000954
        cmpi.b       #$4, d0                                       ; $000958
        beq.b        loc_00096C                                    ; $00095C
        cmpi.b       #$d, d0                                       ; $00095E
        beq.b        loc_00096C                                    ; $000962
        clr.b        ramControllerPresent.l                        ; $000964
        rts                                                        ; $00096A

loc_00096C:
        move.b       #$1, ramControllerPresent.l                   ; $00096C
        rts                                                        ; $000974
        ifne *-$976
        fail "ROM end moved"
        endif
