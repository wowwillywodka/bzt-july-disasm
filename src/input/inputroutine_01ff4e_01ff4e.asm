; $01FF4E..$01FF81 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Инициализация мастера линк-кабеля: jsr $7A7F6 (стоп IRQ), SR=$2700, VDP-регистр $8B08 (вкл. внешний IRQ), настройка CTRL порта2 ($A1000B=$A0) и DATA порта2 ($A10005 bset5) для последовательного обмена, флаг режима $2100→$FF2C66 (-0x539A,A6), SR=$2100, jsr $7A80A
        ifne *-$1FF4E
        fail "ROM start moved"
        endif

InputRoutine_01FF4E:
        jsr          AcquireZ80Bus.l                               ; $01FF4E
        move.w       #$2700, sr                                    ; $01FF54
        move.w       #$8b08, VDP_CONTROL.l                         ; $01FF58
        move.b       #$a0, PAD2_CONTROL.l                          ; $01FF60
        bset.b       #$5, PAD2_DATA.l                              ; $01FF68
        move.w       #$2100, -$539a(a6)                            ; $01FF70
        move.w       #$2100, sr                                    ; $01FF76
        jsr          ReleaseZ80Bus.l                               ; $01FF7A
        rts                                                        ; $01FF80
        ifne *-$1FF82
        fail "ROM end moved"
        endif
