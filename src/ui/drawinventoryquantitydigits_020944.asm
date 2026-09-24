; $020944..$0209FD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Рисует две цифры счётчика предмета в пиксельных данных иконки. Разбивает D0 на десятки/единицы, выбирает упакованные строки глифов из $164148 и пишет 12 слов в VDP_DATA (A4). Это не запись в CRAM.
        ifne *-$20944
        fail "ROM start moved"
        endif

DrawInventoryQuantityDigits:
        movem.l      d0-d1/a2-a3, -(a7)                            ; $020944
        movea.l      #InventoryQuantityDigitRows, a2                    ; $020948
        clr.w        d1                                            ; $02094E
        andi.w       #$7f, d0                                      ; $020950
        cmpi.w       #$a, d0                                       ; $020954
        bcs.b        loc_0209C2                                    ; $020958
        movea.l      a2, a3                                        ; $02095A

loc_02095C:
        subi.w       #$a, d0                                       ; $02095C
        addq.w       #$1, d1                                       ; $020960
        cmpi.w       #$a, d0                                       ; $020962
        bcc.b        loc_02095C                                    ; $020966
        btst.l       #$0, d0                                       ; $020968
        beq.b        loc_020970                                    ; $02096C
        addq.w       #$2, a2                                       ; $02096E

loc_020970:
        lsl.w        #$2, d0                                       ; $020970
        andi.w       #$fff8, d0                                    ; $020972
        adda.w       d0, a2                                        ; $020976
        adda.w       d0, a2                                        ; $020978
        adda.w       d0, a2                                        ; $02097A
        btst.l       #$0, d1                                       ; $02097C
        beq.b        loc_020984                                    ; $020980
        addq.w       #$2, a3                                       ; $020982

loc_020984:
        lsl.w        #$2, d1                                       ; $020984
        andi.w       #$fff8, d1                                    ; $020986
        adda.w       d1, a3                                        ; $02098A
        adda.w       d1, a3                                        ; $02098C
        adda.w       d1, a3                                        ; $02098E
        move.w       (a3), (a4)                                    ; $020990
        move.w       (a2), (a4)                                    ; $020992
        move.w       $4(a3), (a4)                                  ; $020994
        move.w       $4(a2), (a4)                                  ; $020998
        move.w       $8(a3), (a4)                                  ; $02099C
        move.w       $8(a2), (a4)                                  ; $0209A0
        move.w       $c(a3), (a4)                                  ; $0209A4
        move.w       $c(a2), (a4)                                  ; $0209A8
        move.w       $10(a3), (a4)                                 ; $0209AC
        move.w       $10(a2), (a4)                                 ; $0209B0
        move.w       $14(a3), (a4)                                 ; $0209B4
        move.w       $14(a2), (a4)                                 ; $0209B8
        movem.l      (a7)+, d0-d1/a2-a3                            ; $0209BC
        rts                                                        ; $0209C0

loc_0209C2:
        btst.l       #$0, d0                                       ; $0209C2
        beq.b        loc_0209CA                                    ; $0209C6
        addq.w       #$2, a2                                       ; $0209C8

loc_0209CA:
        lsl.w        #$2, d0                                       ; $0209CA
        andi.w       #$fff8, d0                                    ; $0209CC
        adda.w       d0, a2                                        ; $0209D0
        adda.w       d0, a2                                        ; $0209D2
        adda.w       d0, a2                                        ; $0209D4
        move.w       d1, (a4)                                      ; $0209D6
        move.w       (a2), (a4)                                    ; $0209D8
        move.w       d1, (a4)                                      ; $0209DA
        move.w       $4(a2), (a4)                                  ; $0209DC
        move.w       d1, (a4)                                      ; $0209E0
        move.w       $8(a2), (a4)                                  ; $0209E2
        move.w       d1, (a4)                                      ; $0209E6
        move.w       $c(a2), (a4)                                  ; $0209E8
        move.w       d1, (a4)                                      ; $0209EC
        move.w       $10(a2), (a4)                                 ; $0209EE
        move.w       d1, (a4)                                      ; $0209F2
        move.w       $14(a2), (a4)                                 ; $0209F4
        movem.l      (a7)+, d0-d1/a2-a3                            ; $0209F8
        rts                                                        ; $0209FC
        ifne *-$209FE
        fail "ROM end moved"
        endif
