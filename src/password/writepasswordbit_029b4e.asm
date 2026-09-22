; $029B4E..$029B77 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Упаковка бита: пишет бит D0.0 в битовый массив (A1) по индексу D1 (байт D1>>3, бит D1&7) через bset/bclr, инкрементит D1, прокручивает D0 — сериализатор битового поля
        ifne *-$29B4E
        fail "ROM start moved"
        endif

WritePasswordBit:
        movem.w      d1-d2, -(a7)                                  ; $029B4E
        andi.w       #$ff, d1                                      ; $029B52
        move.w       d1, d2                                        ; $029B56
        andi.w       #$7, d2                                       ; $029B58
        asr.w        #$3, d1                                       ; $029B5C
        btst.l       #$0, d0                                       ; $029B5E
        beq.b        loc_029B6A                                    ; $029B62
        bset.b       d2, (a1, d1.w)                                ; $029B64
        bra.b        loc_029B6E                                    ; $029B68

loc_029B6A:
        bclr.b       d2, (a1, d1.w)                                ; $029B6A

loc_029B6E:
        movem.w      (a7)+, d1-d2                                  ; $029B6E
        addq.w       #$1, d1                                       ; $029B72
        ror.w        #$1, d0                                       ; $029B74
        rts                                                        ; $029B76
        ifne *-$29B78
        fail "ROM end moved"
        endif
