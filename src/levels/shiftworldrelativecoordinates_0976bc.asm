; $0976BC..$097739 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: rebase transient records, actor X/Y and episode-0 special-cell records; then extract the window.
        ifne *-$976BC
        fail "ROM start moved"
        endif

ShiftWorldRelativeCoordinates:
; For ordinary scroll: D2/D3=old origin, RAM=new origin; delta=(old-new). Falls through to extraction.
        move.w       rMapWindowOriginX(a6), d4                     ; $0976BC
        move.w       rMapWindowOriginY(a6), d5                     ; $0976C0
        lea.l        rTransientCellRecords(a6), a0                 ; $0976C4
        move.w       #$f, d0                                       ; $0976C8
        sub.w        d4, d2                                        ; $0976CC
        sub.w        d5, d3                                        ; $0976CE
        move.w       d3, d1                                        ; $0976D0
        lsl.w        #$5, d1                                       ; $0976D2
        add.w        d2, d1                                        ; $0976D4
        ext.l        d1                                            ; $0976D6
        lsl.w        #$8, d2                                       ; $0976D8
        lsl.w        #$8, d3                                       ; $0976DA

loc_0976DC:
        add.w        d2, $8(a0)                                    ; $0976DC
        add.w        d3, $a(a0)                                    ; $0976E0
        add.l        d1, (a0)                                      ; $0976E4
        adda.l       #$e, a0                                       ; $0976E6
        dbra         d0, loc_0976DC                                ; $0976EC
        move.w       rActiveActorCount(a6), d7                     ; $0976F0
        bne.b        loc_0976F8                                    ; $0976F4
        bra.b        loc_09770E                                    ; $0976F6

loc_0976F8:
        subq.w       #$1, d7                                       ; $0976F8
        movea.l      rActiveActorHead(a6), a1                      ; $0976FA

loc_0976FE:
        move.l       (a1), -(a7)                                   ; $0976FE
; Only ActorX/Y shift. Goal, saved point, previous XY and floor are not rebased by this loop.
        add.w        d2, ActorX(a1)                                ; $097700
        add.w        d3, ActorY(a1)                                ; $097704
        movea.l      (a7)+, a1                                     ; $097708
        dbra         d7, loc_0976FE                                ; $09770A

loc_09770E:
        cmpi.w       #$0, rGeometryEpisode(a6)                     ; $09770E
        bne.b        ExtractVisibleMapWindow                       ; $097714
; Episode index 0 only: 30 eight-byte special-cell records, not the actor pool or hardware sprites.
        lea.l        rEpisode1CellRecords(a6), a0                  ; $097716
        move.w       #$1d, d0                                      ; $09771A
        movem.w      d2-d3, -(a7)                                  ; $09771E
        lsr.w        #$8, d2                                       ; $097722
        lsr.w        #$8, d3                                       ; $097724

loc_097726:
        add.l        d1, (a0)                                      ; $097726
        add.b        d2, WallStageCellX(a0)                        ; $097728
        add.b        d3, WallStageCellY(a0)                        ; $09772C
        addq.l       #$8, a0                                       ; $097730
        dbra         d0, loc_097726                                ; $097732
        movem.w      (a7)+, d2-d3                                  ; $097736
        ifne *-$9773A
        fail "ROM end moved"
        endif
