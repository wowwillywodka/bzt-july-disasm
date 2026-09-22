; $000744..$000799 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; сборка списка команд VDP DMA: из ptr (-0x7fca,A6)→A3 формирует слова регистров $93-$97 (длина/адрес источника DMA) из D4/D6 со сдвигами и масками $7f/$3fff/+$4000/+$80, пишет в (A3)+, сохраняет A3 обратно
        ifne *-$744
        fail "ROM start moved"
        endif

QueueVramDma:
        movea.l      rDmaQueueTail(a6), a3                         ; $000744
        move.w       #$9300, d3                                    ; $000748
        move.b       d6, d3                                        ; $00074C
        move.w       d3, (a3)+                                     ; $00074E
        move.w       #$9400, d3                                    ; $000750
        lsr.w        #$8, d6                                       ; $000754
        move.b       d6, d3                                        ; $000756
        move.w       d3, (a3)+                                     ; $000758
        lsr.l        #$1, d4                                       ; $00075A
        move.w       #$9500, d3                                    ; $00075C
        move.b       d4, d3                                        ; $000760
        move.w       d3, (a3)+                                     ; $000762
        move.w       #$9600, d3                                    ; $000764
        asr.l        #$8, d4                                       ; $000768
        move.b       d4, d3                                        ; $00076A
        move.w       d3, (a3)+                                     ; $00076C
        move.w       #$9700, d3                                    ; $00076E
        asr.l        #$8, d4                                       ; $000772
        andi.b       #$7f, d4                                      ; $000774
        move.b       d4, d3                                        ; $000778
        move.w       d3, (a3)+                                     ; $00077A
        move.w       d5, d4                                        ; $00077C
        andi.w       #$3fff, d4                                    ; $00077E
        addi.w       #$4000, d4                                    ; $000782
        move.w       d4, (a3)+                                     ; $000786
        move.w       d5, d4                                        ; $000788
        lsr.w        #$8, d4                                       ; $00078A
        lsr.w        #$6, d4                                       ; $00078C
        ori.w        #$80, d4                                      ; $00078E
        move.w       d4, (a3)+                                     ; $000792
        move.l       a3, rDmaQueueTail(a6)                         ; $000794
        rts                                                        ; $000798
        ifne *-$79A
        fail "ROM end moved"
        endif
