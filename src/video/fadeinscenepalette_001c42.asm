; $001C42..$001CB9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Покадровое обновление ПАЛИТРЫ (CRAM): чистит 0x20 лонгов буфера (-0x7908,A6), по флагу (-0x6F6C,A6)==-1 берёт указатель палитры (-0x42EC,A6) иначе (-0x42E8,A6) в (-0x7806,A6), jsr $1A78 (кадр), команда $C0000000 (CRAM-write addr 0) и CPU-копия 32 лонгов (64 цвета) в $C00000, jsr $22628, повтор до (-0x7808,A6)==2
        ifne *-$1C42
        fail "ROM start moved"
        endif

FadeInScenePalette:
        lea.l        -$7908(a6), a0                                ; $001C42
        move.w       #$1f, d7                                      ; $001C46

loc_001C4A:
        clr.l        (a0)+                                         ; $001C4A
        dbra         d7, loc_001C4A                                ; $001C4C
        movea.l      #VDP_DATA, a4                                 ; $001C50
        cmpi.w       #$ffff, -$6f6c(a6)                            ; $001C56
        bne.b        loc_001C66                                    ; $001C5C
        move.l       rZoneScenePalette(a6), -$7806(a6)             ; $001C5E
        bra.b        loc_001C6C                                    ; $001C64

loc_001C66:
        move.l       rZoneEffectPalette(a6), -$7806(a6)            ; $001C66

loc_001C6C:
        clr.b        -$7802(a6)                                    ; $001C6C
        clr.w        -$7808(a6)                                    ; $001C70

loc_001C74:
        jsr          WaitForVBlank.l                               ; $001C74
        tst.w        -$7808(a6)                                    ; $001C7A
        bne.b        loc_001CA6                                    ; $001C7E
        move.l       #$c0000000, VDP_CONTROL.l                     ; $001C80
        lea.l        -$7908(a6), a0                                ; $001C8A
        move.w       #$3, d7                                       ; $001C8E

loc_001C92:
        move.l       (a0)+, (a4)                                   ; $001C92
        move.l       (a0)+, (a4)                                   ; $001C94
        move.l       (a0)+, (a4)                                   ; $001C96
        move.l       (a0)+, (a4)                                   ; $001C98
        move.l       (a0)+, (a4)                                   ; $001C9A
        move.l       (a0)+, (a4)                                   ; $001C9C
        move.l       (a0)+, (a4)                                   ; $001C9E
        move.l       (a0)+, (a4)                                   ; $001CA0
        dbra         d7, loc_001C92                                ; $001CA2

loc_001CA6:
        move.w       #$3f, d7                                      ; $001CA6
        jsr          StepPaletteFade.l                             ; $001CAA
        cmpi.w       #$2, -$7808(a6)                               ; $001CB0
        bne.b        loc_001C74                                    ; $001CB6
        rts                                                        ; $001CB8
        ifne *-$1CBA
        fail "ROM end moved"
        endif
