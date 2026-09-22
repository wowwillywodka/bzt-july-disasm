; $00CD8A..$00CE67 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Проверка попадания луча в клетку (ветка A1, грань 3): celltype=(A5,D3), код 3 с add (2,A4),D3>D7 даёт промах; celltype>=6 — exg регистров и рекурсия в диспетчер 0x8b50 на встречном ходу; hit через Z-флаг
        ifne *-$CD8A
        fail "ROM start moved"
        endif

RendererRoutine_00CD8A:
        andi.w       #$ff, d3                                      ; $00CD8A
        move.b       (a5, d3.w), d3                                ; $00CD8E
        bne.b        loc_00CD96                                    ; $00CD92
        rts                                                        ; $00CD94

loc_00CD96:
        cmpi.b       #$6, d3                                       ; $00CD96
        bcc.b        loc_00CDB0                                    ; $00CD9A
        cmpi.b       #$3, d3                                       ; $00CD9C
        bne.b        loc_00CDAE                                    ; $00CDA0
        move.w       d6, d3                                        ; $00CDA2
        add.w        $2(a4), d3                                    ; $00CDA4
        cmp.w        d7, d3                                        ; $00CDA8
        bhi.b        loc_00CDCA                                    ; $00CDAA
        moveq        #$3, d3                                       ; $00CDAC

loc_00CDAE:
        rts                                                        ; $00CDAE

loc_00CDB0:
        exg.l        d0, d4                                        ; $00CDB0
        exg.l        d1, d5                                        ; $00CDB2
        exg.l        d2, d6                                        ; $00CDB4
        exg.l        a0, a1                                        ; $00CDB6
        bsr.w        DispatchVisibleCell                           ; $00CDB8
        exg.l        d0, d4                                        ; $00CDBC
        exg.l        d1, d5                                        ; $00CDBE
        exg.l        d2, d6                                        ; $00CDC0
        exg.l        a0, a1                                        ; $00CDC2
        tst.b        d3                                            ; $00CDC4
        bne.b        loc_00CD96                                    ; $00CDC6
        rts                                                        ; $00CDC8

loc_00CDCA:
        clr.w        d3                                            ; $00CDCA
        rts                                                        ; $00CDCC

loc_00CDCE:
        cmpa.l       -$715e(a6), a0                                ; $00CDCE
        beq.w        loc_00CD26                                    ; $00CDD2
        move.l       a0, -$715e(a6)                                ; $00CDD6
        clr.w        d4                                            ; $00CDDA
        move.b       (a0), d4                                      ; $00CDDC
        lsl.w        #$3, d4                                       ; $00CDDE
        lea.l        rTextureOrder(a6), a2                         ; $00CDE0
        adda.w       d4, a2                                        ; $00CDE4
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CDE6
        move.l       a0, -$42a2(a6)                                ; $00CDEA
        add.w        rPlayerCellX(a6), d0                          ; $00CDEE
        lsl.w        #$8, d0                                       ; $00CDF2
        add.w        rPlayerCellY(a6), d1                          ; $00CDF4
        lsl.w        #$8, d1                                       ; $00CDF8
        clr.w        d4                                            ; $00CDFA
        move.b       -$20(a0), d4                                  ; $00CDFC
        move.b       (a5, d4.w), d4                                ; $00CE00
        cmpi.b       #$1, d4                                       ; $00CE04
        beq.b        loc_00CE2C                                    ; $00CE08
        cmpi.b       #$2, d4                                       ; $00CE0A
        beq.b        loc_00CE2C                                    ; $00CE0E
        cmpi.b       #$3, d4                                       ; $00CE10
        beq.b        loc_00CE2C                                    ; $00CE14
        cmpi.b       #$4, d4                                       ; $00CE16
        beq.b        loc_00CE2C                                    ; $00CE1A
        movem.w      d0-d1/d3, -(a7)                               ; $00CE1C
        bsr.w        RendererRoutine_00CF2A                        ; $00CE20
        movem.w      (a7)+, d0-d1/d3                               ; $00CE24
        bra.w        RendererRoutine_00CE68                        ; $00CE28

loc_00CE2C:
        bra.w        RendererRoutine_00CF2A                        ; $00CE2C

loc_00CE30:
        cmpa.l       -$715e(a6), a1                                ; $00CE30
        beq.w        loc_00CD26                                    ; $00CE34
        move.w       d4, d0                                        ; $00CE38
        move.w       d5, d1                                        ; $00CE3A
        move.w       d6, d2                                        ; $00CE3C
        movea.l      a1, a0                                        ; $00CE3E
        move.l       a0, -$715e(a6)                                ; $00CE40
        clr.w        d4                                            ; $00CE44
        move.b       (a0), d4                                      ; $00CE46
        lsl.w        #$3, d4                                       ; $00CE48
        lea.l        rTextureOrder(a6), a2                         ; $00CE4A
        adda.w       d4, a2                                        ; $00CE4E
        move.l       a2, rCurrentCellTextureOrder(a6)              ; $00CE50
        move.l       a0, -$42a2(a6)                                ; $00CE54
        add.w        rPlayerCellX(a6), d0                          ; $00CE58
        lsl.w        #$8, d0                                       ; $00CE5C
        add.w        rPlayerCellY(a6), d1                          ; $00CE5E
        lsl.w        #$8, d1                                       ; $00CE62
        bra.w        RendererRoutine_00CE68                        ; $00CE64
        ifne *-$CE68
        fail "ROM end moved"
        endif
