; $00B028..$00B081 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Finish all records except mode 1: commit final/original cell and compact. Called by ExitLocalActors; writes RAM map, not VRAM.
        ifne *-$B028
        fail "ROM start moved"
        endif

FinishTransientWallRecords:
; Finish all records except mode 1: commit final/original cell and compact. Called by ExitLocalActors; writes RAM map, not VRAM.
        lea.l        rTransientCellRecords(a6), a3                 ; $00B028

loc_00B02C:
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $00B02C
        bne.b        loc_00B034                                    ; $00B030
        rts                                                        ; $00B032

loc_00B034:
        cmpi.b       #$1, WallRecordMode(a3)                       ; $00B034
        beq.w        loc_00B07C                                    ; $00B03A
        movea.l      (a3), a0                                      ; $00B03E
        cmpa.l       #$ffa5fa, a0                                  ; $00B040
        bcs.b        loc_00B050                                    ; $00B046
        cmpa.l       #$ffe5fa, a0                                  ; $00B048
        bcs.b        loc_00B056                                    ; $00B04E

loc_00B050:
        movea.l      #$ffa9fa, a0                                  ; $00B050

loc_00B056:
        move.b       WallRecordRestoreCell(a3), (a0)               ; $00B056
        jsr          CommitMapCellAndSendLink.l                    ; $00B05A
        lea.l        $e(a3), a4                                    ; $00B060
        movea.l      a3, a2                                        ; $00B064

loc_00B066:
        cmpa.l       rTransientCellRecordsEnd(a6), a4              ; $00B066
        beq.b        loc_00B076                                    ; $00B06A
        move.l       (a4)+, (a2)+                                  ; $00B06C
        move.l       (a4)+, (a2)+                                  ; $00B06E
        move.l       (a4)+, (a2)+                                  ; $00B070
        move.w       (a4)+, (a2)+                                  ; $00B072
        bra.b        loc_00B066                                    ; $00B074

loc_00B076:
        move.l       a2, rTransientCellRecordsEnd(a6)              ; $00B076
        bra.b        loc_00B02C                                    ; $00B07A

loc_00B07C:
        adda.w       #$e, a3                                       ; $00B07C
        bra.b        loc_00B02C                                    ; $00B080
        ifne *-$B082
        fail "ROM end moved"
        endif
