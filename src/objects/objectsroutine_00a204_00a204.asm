; $00A204..$00A2B1 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Спавн объекта по 4 токенам клетки (0x79/0x7b/0x7d/0x7f → типы $c64/$c66/$c68/$c6a) с клампом A0 в буфер актёров и jsr $20910; в хвосте d0=$2a→jsr $df84 (звук) и взвод таймера -$559e=$14
        ifne *-$A204
        fail "ROM start moved"
        endif

ObjectsRoutine_00A204:
        move.l       a0, -$42a2(a6)                                ; $00A204
        bsr.w        EnvironmentRoutine_00D1A2                     ; $00A208
        cmpa.l       #$ffa5fa, a0                                  ; $00A20C
        bcs.b        loc_00A21C                                    ; $00A212
        cmpa.l       #$ffe5fa, a0                                  ; $00A214
        bcs.b        loc_00A222                                    ; $00A21A

loc_00A21C:
        movea.l      #$ffa9fa, a0                                  ; $00A21C

loc_00A222:
        move.b       $c64(a6), (a0)                                ; $00A222
        jsr          CommitMapCellAndSendLink.l                    ; $00A226
        bra.w        loc_00A298                                    ; $00A22C

loc_00A230:
        cmpa.l       #$ffa5fa, a0                                  ; $00A230
        bcs.b        loc_00A240                                    ; $00A236
        cmpa.l       #$ffe5fa, a0                                  ; $00A238
        bcs.b        loc_00A246                                    ; $00A23E

loc_00A240:
        movea.l      #$ffa9fa, a0                                  ; $00A240

loc_00A246:
        move.b       $c66(a6), (a0)                                ; $00A246
        jsr          CommitMapCellAndSendLink.l                    ; $00A24A
        bra.w        loc_00A298                                    ; $00A250

loc_00A254:
        cmpa.l       #$ffa5fa, a0                                  ; $00A254
        bcs.b        loc_00A264                                    ; $00A25A
        cmpa.l       #$ffe5fa, a0                                  ; $00A25C
        bcs.b        loc_00A26A                                    ; $00A262

loc_00A264:
        movea.l      #$ffa9fa, a0                                  ; $00A264

loc_00A26A:
        move.b       $c68(a6), (a0)                                ; $00A26A
        jsr          CommitMapCellAndSendLink.l                    ; $00A26E
        bra.w        loc_00A298                                    ; $00A274

loc_00A278:
        cmpa.l       #$ffa5fa, a0                                  ; $00A278
        bcs.b        loc_00A288                                    ; $00A27E
        cmpa.l       #$ffe5fa, a0                                  ; $00A280
        bcs.b        loc_00A28E                                    ; $00A286

loc_00A288:
        movea.l      #$ffa9fa, a0                                  ; $00A288

loc_00A28E:
        move.b       $c6a(a6), (a0)                                ; $00A28E
        jsr          CommitMapCellAndSendLink.l                    ; $00A292

loc_00A298:
        clr.w        -$55a0(a6)                                    ; $00A298
        clr.w        -$559e(a6)                                    ; $00A29C
        move.w       #$2a, d0                                      ; $00A2A0
        jsr          SoundRoutine_00DF84.l                         ; $00A2A4
        move.w       #$14, -$559e(a6)                              ; $00A2AA
        rts                                                        ; $00A2B0
        ifne *-$A2B2
        fail "ROM end moved"
        endif
