; $00C108..$00C2A9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Главный raycaster/построитель видимой геометрии: инициализирует буферы списков ($FF0FD0/$FF0FF8/$FF10E8), считает границы карты по дальности обзора (-0x7122), берёт celltype текущей клетки (-0x6fb2), цикл по 0x80 шагам D7-углов с bsr 0xC3AA (трассировка одной грани)
        ifne *-$C108
        fail "ROM start moved"
        endif

RendererRoutine_00C108:
        clr.w        -$6e3a(a6)                                    ; $00C108
        move.l       #$ffffffff, -$718a(a6)                        ; $00C10C
        move.l       #$ff0fd0, -$711c(a6)                          ; $00C114
        move.l       #$ff0ff8, -$7118(a6)                          ; $00C11C
        move.l       #$ff10e8, -$6e50(a6)                          ; $00C124
        lea.l        $a4a(a6), a5                                  ; $00C12C
        moveq        #$0, d0                                       ; $00C130
        move.w       #$3, d1                                       ; $00C132

loc_00C136:
        move.l       d0, (a5)+                                     ; $00C136
        move.l       d0, (a5)+                                     ; $00C138
        move.l       d0, (a5)+                                     ; $00C13A
        move.l       d0, (a5)+                                     ; $00C13C
        move.l       d0, (a5)+                                     ; $00C13E
        move.l       d0, (a5)+                                     ; $00C140
        move.l       d0, (a5)+                                     ; $00C142
        move.l       d0, (a5)+                                     ; $00C144
        move.l       d0, (a5)+                                     ; $00C146
        move.l       d0, (a5)+                                     ; $00C148
        move.l       d0, (a5)+                                     ; $00C14A
        move.l       d0, (a5)+                                     ; $00C14C
        move.l       d0, (a5)+                                     ; $00C14E
        move.l       d0, (a5)+                                     ; $00C150
        move.l       d0, (a5)+                                     ; $00C152
        move.l       d0, (a5)+                                     ; $00C154
        dbra         d1, loc_00C136                                ; $00C156
        clr.l        -$715e(a6)                                    ; $00C15A
        move.w       rPlayerX(a6), d0                              ; $00C15E
        asr.w        #$8, d0                                       ; $00C162
        move.w       d0, rPlayerCellX(a6)                          ; $00C164
        move.w       rPlayerY(a6), d0                              ; $00C168
        asr.w        #$8, d0                                       ; $00C16C
        move.w       d0, rPlayerCellY(a6)                          ; $00C16E
        move.w       rPlayerCellX(a6), d0                          ; $00C172
        neg.w        d0                                            ; $00C176
        move.w       d0, -$719e(a6)                                ; $00C178
        addi.w       #$1f, d0                                      ; $00C17C
        move.w       d0, -$71a0(a6)                                ; $00C180
        move.w       rPlayerCellY(a6), d0                          ; $00C184
        neg.w        d0                                            ; $00C188
        move.w       d0, -$71a4(a6)                                ; $00C18A
        addi.w       #$1f, d0                                      ; $00C18E
        move.w       d0, -$71a2(a6)                                ; $00C192
        move.w       -$7122(a6), d0                                ; $00C196
        move.w       d0, d1                                        ; $00C19A
        neg.w        d1                                            ; $00C19C
        cmp.w        -$719e(a6), d1                                ; $00C19E
        ble.b        loc_00C1A8                                    ; $00C1A2
        move.w       d1, -$719e(a6)                                ; $00C1A4

loc_00C1A8:
        cmp.w        -$71a4(a6), d1                                ; $00C1A8
        ble.b        loc_00C1B2                                    ; $00C1AC
        move.w       d1, -$71a4(a6)                                ; $00C1AE

loc_00C1B2:
        cmp.w        -$71a0(a6), d0                                ; $00C1B2
        bge.b        loc_00C1BC                                    ; $00C1B6
        move.w       d0, -$71a0(a6)                                ; $00C1B8

loc_00C1BC:
        cmp.w        -$71a2(a6), d0                                ; $00C1BC
        bge.b        loc_00C1C6                                    ; $00C1C0
        move.w       d0, -$71a2(a6)                                ; $00C1C2

loc_00C1C6:
        move.w       rPlayerX(a6), d0                              ; $00C1C6
        andi.w       #$ff, d0                                      ; $00C1CA
        move.w       d0, -$71e4(a6)                                ; $00C1CE
        neg.w        d0                                            ; $00C1D2
        addi.w       #$ff, d0                                      ; $00C1D4
        move.w       d0, -$71e8(a6)                                ; $00C1D8
        move.w       rPlayerY(a6), d0                              ; $00C1DC
        andi.w       #$ff, d0                                      ; $00C1E0
        move.w       d0, -$71e2(a6)                                ; $00C1E4
        neg.w        d0                                            ; $00C1E8
        addi.w       #$ff, d0                                      ; $00C1EA
        move.w       d0, -$71e6(a6)                                ; $00C1EE
        movea.l      rVisibleMapBasePointer(a6), a0                ; $00C1F2
        adda.w       rPlayerCellX(a6), a0                          ; $00C1F6
        move.w       rPlayerCellY(a6), d0                          ; $00C1FA
        lsl.w        #$5, d0                                       ; $00C1FE
        adda.w       d0, a0                                        ; $00C200
        move.l       a0, rPlayerCellPointer(a6)                    ; $00C202
        clr.w        -$7162(a6)                                    ; $00C206
        clr.w        d3                                            ; $00C20A
        move.b       (a0), d3                                      ; $00C20C
        lea.l        rCellTypeByIndex(a6), a5                      ; $00C20E
        move.b       (a5, d3.w), d3                                ; $00C212
        cmpi.b       #$6, d3                                       ; $00C216
        bcs.b        loc_00C23E                                    ; $00C21A
        move.w       rCurrentFloor(a6), -(a7)                      ; $00C21C
        bsr.w        DispatchTransitHeight                         ; $00C220
        move.w       (a7)+, d0                                     ; $00C224
        cmp.w        rCurrentFloor(a6), d0                         ; $00C226
        beq.b        loc_00C22E                                    ; $00C22A
        rts                                                        ; $00C22C

loc_00C22E:
        move.w       -$6e4c(a6), d0                                ; $00C22E
        sub.w        d0, -$71d8(a6)                                ; $00C232
        clr.w        d0                                            ; $00C236
        clr.w        d1                                            ; $00C238
        bsr.w        DispatchVisibleCell                           ; $00C23A

loc_00C23E:
        move.w       -$7162(a6), d0                                ; $00C23E
        lea.l        CameraAngleOffsets(pc), a0                    ; $00C242
        adda.w       d0, a0                                        ; $00C246
        adda.w       d0, a0                                        ; $00C248
        move.w       (a0), d0                                      ; $00C24A
        add.w        -$71ee(a6), d0                                ; $00C24C
        andi.w       #$1ff, d0                                     ; $00C250
        bsr.w        RendererRoutine_00C3AA                        ; $00C254
        move.w       -$213e(a6), d3                                ; $00C258
        add.w        d3, -$7162(a6)                                ; $00C25C
        cmpi.w       #$80, -$7162(a6)                              ; $00C260
        ble.b        loc_00C23E                                    ; $00C266
        movea.l      rPlayerCellPointer(a6), a0                    ; $00C268
        clr.w        d0                                            ; $00C26C
        move.b       (a0), d0                                      ; $00C26E
        lea.l        rCellTypeByIndex(a6), a0                      ; $00C270
        move.b       (a0, d0.w), d0                                ; $00C274
        move.b       CameraCollisionClasses(pc, d0.w), d0          ; $00C278
        beq.b        loc_00C294                                    ; $00C27C
        bsr.w        ComposeColumnBlocks                           ; $00C27E
        bsr.w        RendererRoutine_0096FC                        ; $00C282
        move.w       -$6e4c(a6), d0                                ; $00C286
        add.w        d0, -$71d8(a6)                                ; $00C28A
        jmp          ProjectAndDrawActors.l                        ; $00C28E

loc_00C294:
        bsr.w        RendererRoutine_0096FC                        ; $00C294
        move.w       -$6e4c(a6), d0                                ; $00C298
        add.w        d0, -$71d8(a6)                                ; $00C29C
        bsr.w        ComposeColumnBlocks                           ; $00C2A0
        jmp          ProjectAndDrawActors.l                        ; $00C2A4
        ifne *-$C2AA
        fail "ROM end moved"
        endif
