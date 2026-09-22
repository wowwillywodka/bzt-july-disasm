; $001CBA..$001D15 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Хвост FUN_001CBA (капстоун-мусор в шапке): задаёт src=$22712 в (-0x7806,A6), сбрасывает флаги (-0x7802/-0x7808,A6), jsr $1A78, DMA-копия буфера (-0x7908,A6) 32 лонга в $C00000, jsr $22628, цикл до (-0x7808,A6)==2
        ifne *-$1CBA
        fail "ROM start moved"
        endif

VideoRoutine_001CBA:
        move.l       #BlackFadePalette, -$7806(a6)                 ; $001CBA
        clr.b        -$7802(a6)                                    ; $001CC2
        clr.w        -$7808(a6)                                    ; $001CC6
        movea.l      #VDP_DATA, a4                                 ; $001CCA

loc_001CD0:
        jsr          WaitForVBlank.l                               ; $001CD0
        tst.w        -$7808(a6)                                    ; $001CD6
        bne.b        loc_001D02                                    ; $001CDA
        move.l       #$c0000000, VDP_CONTROL.l                     ; $001CDC
        lea.l        -$7908(a6), a0                                ; $001CE6
        move.w       #$3, d7                                       ; $001CEA

loc_001CEE:
        move.l       (a0)+, (a4)                                   ; $001CEE
        move.l       (a0)+, (a4)                                   ; $001CF0
        move.l       (a0)+, (a4)                                   ; $001CF2
        move.l       (a0)+, (a4)                                   ; $001CF4
        move.l       (a0)+, (a4)                                   ; $001CF6
        move.l       (a0)+, (a4)                                   ; $001CF8
        move.l       (a0)+, (a4)                                   ; $001CFA
        move.l       (a0)+, (a4)                                   ; $001CFC
        dbra         d7, loc_001CEE                                ; $001CFE

loc_001D02:
        move.w       #$3f, d7                                      ; $001D02
        jsr          StepPaletteFade.l                             ; $001D06
        cmpi.w       #$2, -$7808(a6)                               ; $001D0C
        bne.b        loc_001CD0                                    ; $001D12
        rts                                                        ; $001D14
        ifne *-$1D16
        fail "ROM end moved"
        endif
