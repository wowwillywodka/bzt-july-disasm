; $00AEFA..$00B027 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Mode 2: $20->$40->$60->$80, then next update commits final byte and removes entry. Mode 0 checks player/flag-$10 actors before closing/restoring. Mode 1 is skipped.
        ifne *-$AEFA
        fail "ROM start moved"
        endif

UpdateTransientWallRecords:
; Mode 2: $20->$40->$60->$80, then next update commits final byte and removes entry. Mode 0 checks player/flag-$10 actors before closing/restoring. Mode 1 is skipped.
        lea.l        rTransientCellRecords(a6), a3                 ; $00AEFA

loc_00AEFE:
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $00AEFE
        bne.b        loc_00AF06                                    ; $00AF02
        rts                                                        ; $00AF04

loc_00AF06:
        cmpi.b       #$1, WallRecordMode(a3)                       ; $00AF06
        beq.w        loc_00B020                                    ; $00AF0C
        cmpi.b       #$2, WallRecordMode(a3)                       ; $00AF10
        beq.w        loc_00AFA2                                    ; $00AF16
        move.w       WallRecordX(a3), d0                           ; $00AF1A
        move.w       WallRecordY(a3), d1                           ; $00AF1E
        move.w       d0, d2                                        ; $00AF22
        move.w       d1, d3                                        ; $00AF24
        addi.w       #$ff, d2                                      ; $00AF26
        addi.w       #$ff, d3                                      ; $00AF2A
        cmp.w        rPlayerX(a6), d0                              ; $00AF2E
        bhi.b        loc_00AF46                                    ; $00AF32
        cmp.w        rPlayerX(a6), d2                              ; $00AF34
        bcs.b        loc_00AF46                                    ; $00AF38
        cmp.w        rPlayerY(a6), d1                              ; $00AF3A
        bhi.b        loc_00AF46                                    ; $00AF3E
        cmp.w        rPlayerY(a6), d3                              ; $00AF40
        bcc.b        loc_00AFBE                                    ; $00AF44

loc_00AF46:
        move.w       rActiveActorCount(a6), d7                     ; $00AF46
        beq.b        loc_00AF7A                                    ; $00AF4A
        subq.w       #$1, d7                                       ; $00AF4C
        movea.l      rActiveActorHead(a6), a0                      ; $00AF4E

loc_00AF52:
        move.w       $4(a0), d6                                    ; $00AF52
        andi.w       #$10, d6                                      ; $00AF56
        beq.b        loc_00AF74                                    ; $00AF5A
        cmp.w        $24(a0), d0                                   ; $00AF5C
        bhi.b        loc_00AF74                                    ; $00AF60
        cmp.w        $24(a0), d2                                   ; $00AF62
        bcs.b        loc_00AF74                                    ; $00AF66
        cmp.w        $26(a0), d1                                   ; $00AF68
        bhi.b        loc_00AF74                                    ; $00AF6C
        cmp.w        $26(a0), d3                                   ; $00AF6E
        bcc.b        loc_00AFBE                                    ; $00AF72

loc_00AF74:
        movea.l      (a0), a0                                      ; $00AF74
        dbra         d7, loc_00AF52                                ; $00AF76

loc_00AF7A:
        subi.w       #$20, WallRecordOpening(a3)                   ; $00AF7A
        tst.w        rLinkRole(a6)                                 ; $00AF80
        beq.b        loc_00AF8A                                    ; $00AF84
        bsr.w        SendTransientWallRecord                       ; $00AF86

loc_00AF8A:
        tst.w        WallRecordOpening(a3)                         ; $00AF8A
        bne.w        loc_00B020                                    ; $00AF8E
        move.w       #$5e, d0                                      ; $00AF92
        move.l       a3, -(a7)                                     ; $00AF96
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $00AF98
        movea.l      (a7)+, a3                                     ; $00AF9E
        bra.b        loc_00AFDA                                    ; $00AFA0

loc_00AFA2:
        cmpi.w       #$80, WallRecordOpening(a3)                   ; $00AFA2
        beq.b        loc_00AFDA                                    ; $00AFA8
        addi.w       #$20, WallRecordOpening(a3)                   ; $00AFAA
        tst.w        rLinkRole(a6)                                 ; $00AFB0
        beq.w        loc_00B020                                    ; $00AFB4
        bsr.w        SendTransientWallRecord                       ; $00AFB8
        bra.b        loc_00B020                                    ; $00AFBC

loc_00AFBE:
        cmpi.w       #$80, WallRecordOpening(a3)                   ; $00AFBE
        beq.b        loc_00B020                                    ; $00AFC4
        addi.w       #$20, WallRecordOpening(a3)                   ; $00AFC6
        tst.w        rLinkRole(a6)                                 ; $00AFCC
        beq.w        loc_00B020                                    ; $00AFD0
        bsr.w        SendTransientWallRecord                       ; $00AFD4
        bra.b        loc_00B020                                    ; $00AFD8

loc_00AFDA:
; Write record +7 to the map and commit, then compact queue by 14 bytes. Mode 2 stores zero here; mode 0 stores the original cell.
        move.w       #$1, rWallChangeRefreshFlag(a6)                               ; $00AFDA
        movea.l      (a3), a0                                      ; $00AFE0
        cmpa.l       #$ffa5fa, a0                                  ; $00AFE2
        bcs.b        loc_00AFF2                                    ; $00AFE8
        cmpa.l       #$ffe5fa, a0                                  ; $00AFEA
        bcs.b        loc_00AFF8                                    ; $00AFF0

loc_00AFF2:
        movea.l      #$ffa9fa, a0                                  ; $00AFF2

loc_00AFF8:
        move.b       WallRecordRestoreCell(a3), (a0)               ; $00AFF8
        jsr          CommitMapCellAndSendLink.l                    ; $00AFFC
        lea.l        $e(a3), a4                                    ; $00B002
        movea.l      a3, a2                                        ; $00B006

loc_00B008:
        cmpa.l       rTransientCellRecordsEnd(a6), a4              ; $00B008
        beq.b        loc_00B018                                    ; $00B00C
        move.l       (a4)+, (a2)+                                  ; $00B00E
        move.l       (a4)+, (a2)+                                  ; $00B010
        move.l       (a4)+, (a2)+                                  ; $00B012
        move.w       (a4)+, (a2)+                                  ; $00B014
        bra.b        loc_00B008                                    ; $00B016

loc_00B018:
        move.l       a2, rTransientCellRecordsEnd(a6)              ; $00B018
        bra.w        loc_00AEFE                                    ; $00B01C

loc_00B020:
        adda.w       #$e, a3                                       ; $00B020
        bra.w        loc_00AEFE                                    ; $00B024
        ifne *-$B028
        fail "ROM end moved"
        endif
