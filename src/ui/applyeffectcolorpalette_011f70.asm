; $011F70..$011FE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Экранный переход со сменой палитры при особом предмете: грузит CRAM-палитру из (-0x42e8,A6) через 0xbce, заполняет 5 лонгов координат буфера, ставит состояние перехода (-0x7122,A6)=0x10 и прыгает в 0xdcb8
        ifne *-$11F70
        fail "ROM start moved"
        endif

ApplyEffectColorPalette:
        move.w       #$3f, d0                                      ; $011F70
        movea.l      rZoneEffectPalette(a6), a0                    ; $011F74
        jsr          UploadPalette.l                               ; $011F78
        cmpi.w       #$3, rSceneColorMode(a6)                      ; $011F7E
        beq.b        loc_011FB8                                    ; $011F84
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $011F86
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $011F8A
        addi.l       #$b00, d1                                     ; $011F8E
        move.l       d1, (a0)+                                     ; $011F94
        move.l       d1, (a0)+                                     ; $011F96
        move.l       d1, (a0)+                                     ; $011F98
        move.l       d1, (a0)+                                     ; $011F9A
        move.l       d1, (a0)                                      ; $011F9C
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $011F9E
        move.l       rZoneBackgroundProfile0(a6), rActiveSceneBackgroundProfile(a6) ; $011FA6
        move.w       #$10, rVisibleRayCellRadius(a6)                              ; $011FAC
        jmp          ForceResampleSceneBackgroundForColorMode.l                                  ; $011FB2

loc_011FB8:
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $011FB8
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $011FBC
        addi.l       #$b00, d1                                     ; $011FC0
        move.l       d1, (a0)+                                     ; $011FC6
        move.l       d1, (a0)+                                     ; $011FC8
        move.l       d1, (a0)+                                     ; $011FCA
        move.l       d1, (a0)+                                     ; $011FCC
        move.l       d1, (a0)                                      ; $011FCE
        move.l       #DirectWallColumnScalers, rWallColumnScalerTable(a6) ; $011FD0
        move.l       rZoneBackgroundProfile3(a6), rActiveSceneBackgroundProfile(a6) ; $011FD8
        move.w       #$10, rVisibleRayCellRadius(a6)                              ; $011FDE
        jmp          ForceResampleSceneBackgroundForColorMode.l                                  ; $011FE4
        ifne *-$11FEA
        fail "ROM end moved"
        endif
