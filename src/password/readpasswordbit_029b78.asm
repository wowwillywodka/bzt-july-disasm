; $029B78..$029BA1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Распаковка бита: читает бит из массива (A2) по индексу D2 (байт D2>>3, бит D2&7) в D0.0 через btst, инкрементит D2 — десериализатор битового поля
        ifne *-$29B78
        fail "ROM start moved"
        endif

ReadPasswordBit:
        ror.w        #$1, d0                                       ; $029B78
        movem.w      d1-d2, -(a7)                                  ; $029B7A
        andi.w       #$ff, d2                                      ; $029B7E
        move.w       d2, d1                                        ; $029B82
        andi.w       #$7, d1                                       ; $029B84
        asr.w        #$3, d2                                       ; $029B88
        btst.b       d1, (a2, d2.w)                                ; $029B8A
        beq.b        loc_029B96                                    ; $029B8E
        bset.l       #$0, d0                                       ; $029B90
        bra.b        loc_029B9A                                    ; $029B94

loc_029B96:
        bclr.l       #$0, d0                                       ; $029B96

loc_029B9A:
        movem.w      (a7)+, d1-d2                                  ; $029B9A
        addq.w       #$1, d2                                       ; $029B9E
        rts                                                        ; $029BA0
        ifne *-$29BA2
        fail "ROM end moved"
        endif
