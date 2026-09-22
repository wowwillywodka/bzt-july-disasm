; $002700..$002733 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер звукового события по коду D0: код $10→$274e, $16→сброс флага $272e; коды $0a..$0f играют звуки $5f и $83 через jsr $df84 (вызов GEMS), иначе rts
        ifne *-$2700
        fail "ROM start moved"
        endif

SoundRoutine_002700:
        cmpi.b       #$10, d0                                      ; $002700
        beq.b        UiRoutine_00274E                              ; $002704
        cmpi.b       #$16, d0                                      ; $002706
        beq.b        loc_00272E                                    ; $00270A
        cmpi.b       #$a, d0                                       ; $00270C
        bcs.b        loc_00272C                                    ; $002710
        cmpi.b       #$10, d0                                      ; $002712
        bcc.b        loc_00272C                                    ; $002716
        move.w       #$5f, d0                                      ; $002718
        jsr          SoundRoutine_00DF84.l                         ; $00271C
        move.w       #$83, d0                                      ; $002722
        jmp          SoundRoutine_00DF84.l                         ; $002726

loc_00272C:
        rts                                                        ; $00272C

loc_00272E:
        clr.b        -$6f51(a6)                                    ; $00272E
        rts                                                        ; $002732
        ifne *-$2734
        fail "ROM end moved"
        endif
