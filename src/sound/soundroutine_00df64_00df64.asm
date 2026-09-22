; $00DF64..$00DF83 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Триггер звука по кадру анимации объекта: читает frame-байт (0x36,A0), при совпадении с (-0x6fad,A6) зовёт GEMS-тик 0xDFBA; при активной игре (-0x53a4,A6) и совпадении с (-0x6d90,A6) ставит событие через 0xDF9E
        ifne *-$DF64
        fail "ROM start moved"
        endif

SoundRoutine_00DF64:
        move.w       d1, -(a7)                                     ; $00DF64
        move.b       $36(a0), d1                                   ; $00DF66
        cmp.b        rCurrentFloorLow(a6), d1                      ; $00DF6A
        bne.b        loc_00DF72                                    ; $00DF6E
        bsr.b        SoundRoutine_00DFBA                           ; $00DF70

loc_00DF72:
        tst.w        rLinkRole(a6)                                 ; $00DF72
        beq.b        loc_00DF80                                    ; $00DF76
        cmp.b        -$6d90(a6), d1                                ; $00DF78
        bne.b        loc_00DF80                                    ; $00DF7C
        bsr.b        SoundRoutine_00DF9E                           ; $00DF7E

loc_00DF80:
        move.w       (a7)+, d1                                     ; $00DF80
        rts                                                        ; $00DF82
        ifne *-$DF84
        fail "ROM end moved"
        endif
