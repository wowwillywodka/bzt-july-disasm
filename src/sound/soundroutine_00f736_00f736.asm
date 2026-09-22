; $00F736..$00F761 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Триггер звука шагов: по курсу игрока (-0x71b2,A6) берёт 4-битное направление, читает код звука из PC-таблицы 0xf762; при смене вызывает jsr 0xdf84 (GEMS)
        ifne *-$F736
        fail "ROM start moved"
        endif

SoundRoutine_00F736:
        move.w       d0, -(a7)                                     ; $00F736
        move.w       -$71b2(a6), d0                                ; $00F738
        asr.w        #$5, d0                                       ; $00F73C
        andi.w       #$f, d0                                       ; $00F73E
        move.b       WallMotionSoundEvents(pc, d0.w), d0           ; $00F742
        cmp.b        -$5590(a6), d0                                ; $00F746
        beq.b        loc_00F75E                                    ; $00F74A
        move.b       d0, -$5590(a6)                                ; $00F74C
        movem.l      d1/a0, -(a7)                                  ; $00F750
        jsr          SoundRoutine_00DF84.l                         ; $00F754
        movem.l      (a7)+, d1/a0                                  ; $00F75A

loc_00F75E:
        move.w       (a7)+, d0                                     ; $00F75E
        rts                                                        ; $00F760
        ifne *-$F762
        fail "ROM end moved"
        endif
