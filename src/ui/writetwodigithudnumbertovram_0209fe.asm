; $0209FE..$020A3B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Вывод двузначного числа в VRAM-нейметейбл: ждёт завершения двухфазной VBlank-передачи, затем пишет глифы цифр в VDP.
        ifne *-$209FE
        fail "ROM start moved"
        endif

WriteTwoDigitHudNumberToVram:
        tst.w        rVBlankTransferPhasesRemaining(a6)                                    ; $0209FE
        bne.b        WriteTwoDigitHudNumberToVram                              ; $020A02
        movem.w      d5-d6, -(a7)                                  ; $020A04
        clr.w        d5                                            ; $020A08

loc_020A0A:
        cmpi.w       #$a, d6                                       ; $020A0A
        bcs.b        loc_020A18                                    ; $020A0E
        addq.w       #$1, d5                                       ; $020A10
        subi.w       #$a, d6                                       ; $020A12
        bra.b        loc_020A0A                                    ; $020A16

loc_020A18:
        move.l       #$44820003, VDP_CONTROL.l                     ; $020A18
        addi.w       #$e52f, d5                                    ; $020A22
        move.w       d5, VDP_DATA.l                                ; $020A26
        addi.w       #$e52f, d6                                    ; $020A2C
        move.w       d6, VDP_DATA.l                                ; $020A30
        movem.w      (a7)+, d5-d6                                  ; $020A36
        rts                                                        ; $020A3A
        ifne *-$20A3C
        fail "ROM end moved"
        endif
