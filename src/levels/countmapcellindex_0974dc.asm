; $0974DC..$0974F9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Подсчёт вхождений индекса D0 в карте клеток уровня (0x39fc,A6, 0x4000 байт): прибавляет число совпадений к счётчику D4
        ifne *-$974DC
        fail "ROM start moved"
        endif

CountMapCellIndex:
        clr.w        d1                                            ; $0974DC
        cmpi.b       #$ff, d0                                      ; $0974DE
        beq.b        loc_0974F6                                    ; $0974E2
; Includes unused arena tail: LoadEpisodeGeometry does not clear bytes after the packed floor grids.
        lea.l        rEpisodeMapCells(a6), a0                      ; $0974E4
        move.w       #$3fff, d7                                    ; $0974E8

loc_0974EC:
        cmp.b        (a0)+, d0                                     ; $0974EC
        bne.b        loc_0974F2                                    ; $0974EE
        addq.w       #$1, d1                                       ; $0974F0

loc_0974F2:
        dbra         d7, loc_0974EC                                ; $0974F2

loc_0974F6:
        add.w        d1, d4                                        ; $0974F6
        rts                                                        ; $0974F8
        ifne *-$974FA
        fail "ROM end moved"
        endif
