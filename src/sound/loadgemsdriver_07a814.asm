; $07A814..$07A857 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка Z80-звукодрайвера: reset+bus-request Z80, копирует драйвер из ROM 0x2A470..0x2BCFC в Z80-RAM $A00000, добивает нулями до $A02000 — заливка программы саунд-чипа
        ifne *-$7A814
        fail "ROM start moved"
        endif

LoadGemsDriver:
        move.l       a1, -(a7)                                     ; $07A814
        move.w       sr, -(a7)                                     ; $07A816
        ori.w        #$700, sr                                     ; $07A818
        move.w       #$100, Z80_RESET.l                            ; $07A81C
        jsr          AcquireZ80Bus(pc)                             ; $07A824
        lea.l        GemsZ80Driver.l, a0                           ; $07A828
        lea.l        GemsPatchBank.l, a1                           ; $07A82E
        move.l       a1, d0                                        ; $07A834
        sub.l        a0, d0                                        ; $07A836
        subq.w       #$1, d0                                       ; $07A838
        lea.l        Z80_RAM.l, a1                                 ; $07A83A

loc_07A840:
        move.b       (a0)+, (a1)+                                  ; $07A840
        dbra         d0, loc_07A840                                ; $07A842

loc_07A846:
        move.b       #$0, (a1)+                                    ; $07A846
        cmpa.l       #$a02000, a1                                  ; $07A84A
        bne.b        loc_07A846                                    ; $07A850
        move.w       (a7)+, sr                                     ; $07A852
        movea.l      (a7)+, a1                                     ; $07A854
        rts                                                        ; $07A856
        ifne *-$7A858
        fail "ROM end moved"
        endif
