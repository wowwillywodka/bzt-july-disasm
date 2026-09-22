; $00079A..$000803 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Загрузка таблицы VDP-регистров из (A3)+ в $C00004 и DMA-передача (move.l (A3)+→$C00004) с busy-wait по биту 2 статуса $C00004
        ifne *-$79A
        fail "ROM start moved"
        endif

FlushDmaQueue:
        jsr          RequestGemsMailbox.l                          ; $00079A
        lea.l        -$7abc(a6), a3                                ; $0007A0
        move.w       #$8174, VDP_CONTROL.l                         ; $0007A4
        move.w       sr, -(a7)                                     ; $0007AC
        move.w       #$2700, sr                                    ; $0007AE

loc_0007B2:
        cmpi.l       #$ffffffff, (a3)                              ; $0007B2
        beq.w        loc_0007EC                                    ; $0007B8
        move.l       (a3)+, VDP_CONTROL.l                          ; $0007BC
        move.l       (a3)+, VDP_CONTROL.l                          ; $0007C2
        move.l       (a3)+, VDP_CONTROL.l                          ; $0007C8
        move.w       (a3)+, VDP_CONTROL.l                          ; $0007CE

loc_0007D4:
        move.w       VDP_CONTROL.l, d0                             ; $0007D4
        andi.w       #$2, d0                                       ; $0007DA
        bne.b        loc_0007D4                                    ; $0007DE
        move.l       #$20, VDP_CONTROL.l                           ; $0007E0
        bra.b        loc_0007B2                                    ; $0007EA

loc_0007EC:
        move.l       #$ff0544, rDmaQueueTail(a6)                   ; $0007EC
        move.w       (a7)+, sr                                     ; $0007F4
        move.w       #$8164, VDP_CONTROL.l                         ; $0007F6
        jmp          StopGemsDriver.l                              ; $0007FE
        ifne *-$804
        fail "ROM end moved"
        endif
