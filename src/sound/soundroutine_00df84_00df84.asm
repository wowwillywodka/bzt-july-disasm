; $00DF84..$00DF9D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главная точка вызова GEMS-звука (jsr $df84 по всему коду): при активной игре (-0x53a4,A6) сравнивает код звука (-0x6d90,A6) с (-0x6fad,A6) и либо ставит событие 0xDF9E, либо проваливается в Z80-тик 0xDFBA
        ifne *-$DF84
        fail "ROM start moved"
        endif

SoundRoutine_00DF84:
        tst.w        rLinkRole(a6)                                 ; $00DF84
        beq.b        SoundRoutine_00DFBA                           ; $00DF88
        move.w       d1, -(a7)                                     ; $00DF8A
        move.b       -$6d90(a6), d1                                ; $00DF8C
        cmp.b        rCurrentFloorLow(a6), d1                      ; $00DF90
        beq.b        loc_00DF9A                                    ; $00DF94
        move.w       (a7)+, d1                                     ; $00DF96
        bra.b        SoundRoutine_00DFBA                           ; $00DF98

loc_00DF9A:
        move.w       (a7)+, d1                                     ; $00DF9A
        bsr.b        SoundRoutine_00DFBA                           ; $00DF9C
        ifne *-$DF9E
        fail "ROM end moved"
        endif
