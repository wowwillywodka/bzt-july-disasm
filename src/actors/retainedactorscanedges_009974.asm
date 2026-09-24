; $009974..$009A87 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$9974
        fail "ROM start moved"
        endif

RetainedActorScanEdges:
        bsr.w        ScanRetainedActorColumnNearHighX                                    ; $009974
        bra.w        loc_009994                                    ; $009978
        bsr.w        ScanRetainedActorColumnNearLowX                                    ; $00997C
        bra.w        loc_009994                                    ; $009980
        bsr.w        ScanRetainedActorColumnNearHighX                                    ; $009984
        bra.w        loc_009A4C                                    ; $009988
        bsr.w        ScanRetainedActorColumnNearLowX                                    ; $00998C
        bra.w        loc_009A4C                                    ; $009990

loc_009994:
        cmpi.w       #$200, rPlayerY(a6)                           ; $009994
        bcs.b        loc_0099CE                                    ; $00999A
        move.w       rPlayerX(a6), d0                              ; $00999C
        asr.w        #$8, d0                                       ; $0099A0
        subq.w       #$3, d0                                       ; $0099A2
        lea.l        -$42(a0), a1                                  ; $0099A4
        move.w       #$4, d7                                       ; $0099A8

loc_0099AC:
        addq.w       #$1, d0                                       ; $0099AC
        bmi.b        loc_0099C8                                    ; $0099AE
        cmpi.w       #$20, d0                                      ; $0099B0
        bcc.b        loc_0099CE                                    ; $0099B4
        clr.w        d3                                            ; $0099B6
        move.b       (a1), d3                                      ; $0099B8
        move.b       (a5, d3.w), d3                                ; $0099BA
        move.b       (a4, d3.w), d3                                ; $0099BE
        beq.b        loc_0099C8                                    ; $0099C2
        bsr.w        SelectActorDefinitionFromCell                 ; $0099C4

loc_0099C8:
        addq.w       #$1, a1                                       ; $0099C8
        dbra         d7, loc_0099AC                                ; $0099CA

loc_0099CE:
        rts                                                        ; $0099CE

; Reviewed call entry (internal-helper): Uses player X/Y and A0/A4/A5 to scan five candidate cells near high X.
ScanRetainedActorColumnNearHighX:
        cmpi.w       #$1e00, rPlayerX(a6)                          ; $0099D0
        bcc.b        loc_009A0C                                    ; $0099D6
        move.w       rPlayerY(a6), d0                              ; $0099D8
        asr.w        #$8, d0                                       ; $0099DC
        subq.w       #$3, d0                                       ; $0099DE
        lea.l        -$3e(a0), a1                                  ; $0099E0
        move.w       #$4, d7                                       ; $0099E4

loc_0099E8:
        addq.w       #$1, d0                                       ; $0099E8
        bmi.b        loc_009A04                                    ; $0099EA
        cmpi.w       #$20, d0                                      ; $0099EC
        bcc.b        loc_009A0C                                    ; $0099F0
        clr.w        d3                                            ; $0099F2
        move.b       (a1), d3                                      ; $0099F4
        move.b       (a5, d3.w), d3                                ; $0099F6
        move.b       (a4, d3.w), d3                                ; $0099FA
        beq.b        loc_009A04                                    ; $0099FE
        bsr.w        SelectActorDefinitionFromCell                 ; $009A00

loc_009A04:
        adda.w       #$20, a1                                      ; $009A04
        dbra         d7, loc_0099E8                                ; $009A08

loc_009A0C:
        rts                                                        ; $009A0C

; Reviewed call entry (internal-helper): Uses player X/Y and A0/A4/A5 to scan five candidate cells near low X.
ScanRetainedActorColumnNearLowX:
        cmpi.w       #$200, rPlayerX(a6)                           ; $009A0E
        bcs.b        loc_009A4A                                    ; $009A14
        move.w       rPlayerY(a6), d0                              ; $009A16
        asr.w        #$8, d0                                       ; $009A1A
        subq.w       #$3, d0                                       ; $009A1C
        lea.l        -$42(a0), a1                                  ; $009A1E
        move.w       #$4, d7                                       ; $009A22

loc_009A26:
        addq.w       #$1, d0                                       ; $009A26
        bmi.b        loc_009A42                                    ; $009A28
        cmpi.w       #$20, d0                                      ; $009A2A
        bcc.b        loc_009A4A                                    ; $009A2E
        clr.w        d3                                            ; $009A30
        move.b       (a1), d3                                      ; $009A32
        move.b       (a5, d3.w), d3                                ; $009A34
        move.b       (a4, d3.w), d3                                ; $009A38
        beq.b        loc_009A42                                    ; $009A3C
        bsr.w        SelectActorDefinitionFromCell                 ; $009A3E

loc_009A42:
        adda.w       #$20, a1                                      ; $009A42
        dbra         d7, loc_009A26                                ; $009A46

loc_009A4A:
        rts                                                        ; $009A4A

loc_009A4C:
        cmpi.w       #$1e00, rPlayerY(a6)                          ; $009A4C
        bcc.b        loc_009A86                                    ; $009A52
        move.w       rPlayerX(a6), d0                              ; $009A54
        asr.w        #$8, d0                                       ; $009A58
        subq.w       #$3, d0                                       ; $009A5A
        lea.l        $3e(a0), a1                                   ; $009A5C
        move.w       #$4, d7                                       ; $009A60

loc_009A64:
        addq.w       #$1, d0                                       ; $009A64
        bmi.b        loc_009A80                                    ; $009A66
        cmpi.w       #$20, d0                                      ; $009A68
        bcc.b        loc_009A86                                    ; $009A6C
        clr.w        d3                                            ; $009A6E
        move.b       (a1), d3                                      ; $009A70
        move.b       (a5, d3.w), d3                                ; $009A72
        move.b       (a4, d3.w), d3                                ; $009A76
        beq.b        loc_009A80                                    ; $009A7A
        bsr.w        SelectActorDefinitionFromCell                 ; $009A7C

loc_009A80:
        addq.w       #$1, a1                                       ; $009A80
        dbra         d7, loc_009A64                                ; $009A82

loc_009A86:
        rts                                                        ; $009A86
        ifne *-$9A88
        fail "ROM end moved"
        endif
