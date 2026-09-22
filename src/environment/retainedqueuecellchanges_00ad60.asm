; $00AD60..$00ADF9 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$AD60
        fail "ROM start moved"
        endif

RetainedQueueCellChanges:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00AD60
        cmpa.l       #$ff0fd0, a3                                  ; $00AD64
        beq.w        loc_00AD9C                                    ; $00AD6A
        move.l       a0, (a3)+                                     ; $00AD6E
        move.w       #$20, (a3)+                                   ; $00AD70
        clr.w        d2                                            ; $00AD74
        move.b       (a0), d2                                      ; $00AD76
        move.w       d2, (a3)+                                     ; $00AD78
        cmpa.l       #$ffa5fa, a0                                  ; $00AD7A
        bcs.b        loc_00AD8A                                    ; $00AD80
        cmpa.l       #$ffe5fa, a0                                  ; $00AD82
        bcs.b        loc_00AD90                                    ; $00AD88

loc_00AD8A:
        movea.l      #$ffa9fa, a0                                  ; $00AD8A

loc_00AD90:
        move.b       $c17(a6), (a0)                                ; $00AD90
        jsr          CommitMapCellAndSendLink.l                    ; $00AD94
        bra.b        loc_00ADD6                                    ; $00AD9A

loc_00AD9C:
        rts                                                        ; $00AD9C
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $00AD9E
        cmpa.l       #$ff0fd0, a3                                  ; $00ADA2
        beq.b        loc_00ADD6                                    ; $00ADA8
        move.l       a0, (a3)+                                     ; $00ADAA
        move.w       #$20, (a3)+                                   ; $00ADAC
        clr.w        d2                                            ; $00ADB0
        move.b       (a0), d2                                      ; $00ADB2
        move.w       d2, (a3)+                                     ; $00ADB4
        cmpa.l       #$ffa5fa, a0                                  ; $00ADB6
        bcs.b        loc_00ADC6                                    ; $00ADBC
        cmpa.l       #$ffe5fa, a0                                  ; $00ADBE
        bcs.b        loc_00ADCC                                    ; $00ADC4

loc_00ADC6:
        movea.l      #$ffa9fa, a0                                  ; $00ADC6

loc_00ADCC:
        move.b       $c18(a6), (a0)                                ; $00ADCC
        jsr          CommitMapCellAndSendLink.l                    ; $00ADD0

loc_00ADD6:
        move.w       #$1, -$711e(a6)                               ; $00ADD6
        move.w       d0, (a3)+                                     ; $00ADDC
        move.w       d1, (a3)+                                     ; $00ADDE
        move.b       #$0, (a3)+                                    ; $00ADE0
        move.b       rCurrentFloorLow(a6), (a3)+                   ; $00ADE4
        move.l       a3, rTransientCellRecordsEnd(a6)              ; $00ADE8
        suba.w       #$e, a3                                       ; $00ADEC
        tst.w        rLinkRole(a6)                                 ; $00ADF0
        bne.w        SendTransientWallRecord                       ; $00ADF4
        rts                                                        ; $00ADF8
        ifne *-$ADFA
        fail "ROM end moved"
        endif
