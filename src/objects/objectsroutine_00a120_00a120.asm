; $00A120..$00A177 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Размещение объекта/актёра по адресу клетки: bsr $d1a2 (обработка стены), клампит A0 в буфер актёров [$ffa5fa..$ffe5fa] иначе $ffa9fa, пишет байт-тип $c64(a6), jsr $20910 (триггер эффекта/объекта)
        ifne *-$A120
        fail "ROM start moved"
        endif

ObjectsRoutine_00A120:
        move.l       a0, -$42a2(a6)                                ; $00A120
        bsr.w        EnvironmentRoutine_00D1A2                     ; $00A124
        cmpa.l       #$ffa5fa, a0                                  ; $00A128
        bcs.b        loc_00A138                                    ; $00A12E
        cmpa.l       #$ffe5fa, a0                                  ; $00A130
        bcs.b        loc_00A13E                                    ; $00A136

loc_00A138:
        movea.l      #$ffa9fa, a0                                  ; $00A138

loc_00A13E:
        move.b       $c64(a6), (a0)                                ; $00A13E
        jsr          CommitMapCellAndSendLink.l                    ; $00A142
        bra.w        loc_00A298                                    ; $00A148

loc_00A14C:
        move.l       a0, -$42a2(a6)                                ; $00A14C
        bsr.w        EnvironmentRoutine_00D166                     ; $00A150
        cmpa.l       #$ffa5fa, a0                                  ; $00A154
        bcs.b        loc_00A164                                    ; $00A15A
        cmpa.l       #$ffe5fa, a0                                  ; $00A15C
        bcs.b        loc_00A16A                                    ; $00A162

loc_00A164:
        movea.l      #$ffa9fa, a0                                  ; $00A164

loc_00A16A:
        move.b       $c66(a6), (a0)                                ; $00A16A
        jsr          CommitMapCellAndSendLink.l                    ; $00A16E
        bra.w        loc_00A298                                    ; $00A174
        ifne *-$A178
        fail "ROM end moved"
        endif
