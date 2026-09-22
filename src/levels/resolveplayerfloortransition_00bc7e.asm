; $00BC7E..$00C009 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Snapshot progress; match one of 64 nine-byte records by current floor and GLOBAL cell coordinates. Request direction selects +3/+6 destination triple. No missing-record or $FF-destination guard.
        ifne *-$BC7E
        fail "ROM start moved"
        endif

ResolvePlayerFloorTransition:
; Snapshot progress; match one of 64 nine-byte records by current floor and GLOBAL cell coordinates. Request direction selects +3/+6 destination triple. No missing-record or $FF-destination guard.
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00BC7E
        jsr          CountLegacyObjectiveFloorEnemies.l            ; $00BC82
        jsr          EncodeCurrentProgressSnapshot.l               ; $00BC88
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00BC8E
        move.w       rPlayerX(a6), d1                              ; $00BC92
        move.w       rPlayerY(a6), d2                              ; $00BC96
        lsr.w        #$8, d1                                       ; $00BC9A
        lsr.w        #$8, d2                                       ; $00BC9C
        lsl.w        #$5, d2                                       ; $00BC9E
        add.w        d1, d2                                        ; $00BCA0
        lea.l        rVisibleMapWindow(a6), a0                     ; $00BCA2
        move.b       (a0, d2.w), d2                                ; $00BCA6
        andi.w       #$ff, d2                                      ; $00BCAA
        lea.l        rCellTypeByIndex(a6), a0                      ; $00BCAE
        move.b       (a0, d2.w), d2                                ; $00BCB2
        move.w       d2, -(a7)                                     ; $00BCB6
        movea.l      rEpisodeGeometryRom(a6), a0                   ; $00BCB8
        adda.w       rFloorTransitionRomOffset(a6), a0             ; $00BCBC
        move.w       rPlayerX(a6), d2                              ; $00BCC0
        move.w       rPlayerY(a6), d3                              ; $00BCC4
        lsr.w        #$8, d2                                       ; $00BCC8
        lsr.w        #$8, d3                                       ; $00BCCA
        add.w        rMapWindowOriginX(a6), d2                     ; $00BCCC
        add.w        rMapWindowOriginY(a6), d3                     ; $00BCD0
        move.w       rCurrentFloor(a6), d4                         ; $00BCD4
        move.w       #$3f, d7                                      ; $00BCD8

loc_00BCDC:
        cmp.b        (a0), d4                                      ; $00BCDC
        bne.b        loc_00BD14                                    ; $00BCDE
        cmp.b        $1(a0), d2                                    ; $00BCE0
        bne.b        loc_00BD14                                    ; $00BCE4
        cmp.b        $2(a0), d3                                    ; $00BCE6
        bne.b        loc_00BD14                                    ; $00BCEA
        cmp.b        d0, d4                                        ; $00BCEC
        bhi.b        loc_00BD02                                    ; $00BCEE
        move.b       $3(a0), d0                                    ; $00BCF0
        move.b       d0, rCurrentFloorLow(a6)                      ; $00BCF4
        move.b       $4(a0), d4                                    ; $00BCF8
        move.b       $5(a0), d5                                    ; $00BCFC
        bra.b        loc_00BD1C                                    ; $00BD00

loc_00BD02:
        move.b       $6(a0), d0                                    ; $00BD02
        move.b       d0, rCurrentFloorLow(a6)                      ; $00BD06
        move.b       $7(a0), d4                                    ; $00BD0A
        move.b       $8(a0), d5                                    ; $00BD0E
        bra.b        loc_00BD1C                                    ; $00BD12

loc_00BD14:
        adda.w       #$9, a0                                       ; $00BD14
        dbra         d7, loc_00BCDC                                ; $00BD18

loc_00BD1C:
; Reached even when all 64 records miss. D4/D5 are not valid destination coordinates in that case; never describe this as a safe fallback.
        ext.w        d0                                            ; $00BD1C
        move.b       -$7205(a6), d2                                ; $00BD1E
        move.b       -$7203(a6), d3                                ; $00BD22
        andi.w       #$ff, d2                                      ; $00BD26
        andi.w       #$ff, d3                                      ; $00BD2A
        lsl.w        #$8, d4                                       ; $00BD2E
        lsl.w        #$8, d5                                       ; $00BD30
        or.w         d4, d2                                        ; $00BD32
        or.w         d5, d3                                        ; $00BD34
        jsr          SetPlayerMapOrigin.l                          ; $00BD36
        move.w       rPlayerX(a6), d0                              ; $00BD3C
        move.w       rPlayerY(a6), d1                              ; $00BD40
        lsr.w        #$8, d0                                       ; $00BD44
        lsr.w        #$8, d1                                       ; $00BD46
        lsl.w        #$5, d1                                       ; $00BD48
        add.w        d0, d1                                        ; $00BD4A
        lea.l        rVisibleMapWindow(a6), a0                     ; $00BD4C
        move.b       (a0, d1.w), d1                                ; $00BD50
        andi.w       #$ff, d1                                      ; $00BD54
        lea.l        rCellTypeByIndex(a6), a0                      ; $00BD58
        move.b       (a0, d1.w), d1                                ; $00BD5C
        move.w       (a7)+, d0                                     ; $00BD60
        cmpi.b       #$32, d0                                      ; $00BD62
        beq.w        loc_00BE8E                                    ; $00BD66
        cmpi.b       #$33, d0                                      ; $00BD6A
        beq.w        loc_00BE8E                                    ; $00BD6E
        cmpi.b       #$34, d0                                      ; $00BD72
        beq.w        loc_00BE8E                                    ; $00BD76
        cmpi.b       #$51, d0                                      ; $00BD7A
        beq.w        loc_00BEF2                                    ; $00BD7E
        cmpi.b       #$52, d0                                      ; $00BD82
        beq.w        loc_00BEF2                                    ; $00BD86
        cmpi.b       #$53, d0                                      ; $00BD8A
        beq.w        loc_00BEF2                                    ; $00BD8E
        cmpi.b       #$55, d0                                      ; $00BD92
        beq.w        loc_00BDC6                                    ; $00BD96
        cmpi.b       #$56, d0                                      ; $00BD9A
        beq.w        loc_00BDC6                                    ; $00BD9E
        cmpi.b       #$57, d0                                      ; $00BDA2
        beq.w        loc_00BDC6                                    ; $00BDA6
        cmpi.b       #$59, d0                                      ; $00BDAA
        beq.w        loc_00BE2A                                    ; $00BDAE
        cmpi.b       #$5a, d0                                      ; $00BDB2
        beq.w        loc_00BE2A                                    ; $00BDB6
        cmpi.b       #$5b, d0                                      ; $00BDBA
        beq.w        loc_00BE2A                                    ; $00BDBE
        bra.w        loc_00BFEE                                    ; $00BDC2

loc_00BDC6:
        cmpi.b       #$32, d1                                      ; $00BDC6
        beq.w        loc_00BF56                                    ; $00BDCA
        cmpi.b       #$33, d1                                      ; $00BDCE
        beq.w        loc_00BF56                                    ; $00BDD2
        cmpi.b       #$34, d1                                      ; $00BDD6
        beq.w        loc_00BF56                                    ; $00BDDA
        cmpi.b       #$51, d1                                      ; $00BDDE
        beq.w        loc_00BF8A                                    ; $00BDE2
        cmpi.b       #$52, d1                                      ; $00BDE6
        beq.w        loc_00BF8A                                    ; $00BDEA
        cmpi.b       #$53, d1                                      ; $00BDEE
        beq.w        loc_00BF8A                                    ; $00BDF2
        cmpi.b       #$55, d1                                      ; $00BDF6
        beq.w        loc_00BFEE                                    ; $00BDFA
        cmpi.b       #$56, d1                                      ; $00BDFE
        beq.w        loc_00BFEE                                    ; $00BE02
        cmpi.b       #$57, d1                                      ; $00BE06
        beq.w        loc_00BFEE                                    ; $00BE0A
        cmpi.b       #$59, d1                                      ; $00BE0E
        beq.w        loc_00BFBE                                    ; $00BE12
        cmpi.b       #$5a, d1                                      ; $00BE16
        beq.w        loc_00BFBE                                    ; $00BE1A
        cmpi.b       #$5b, d1                                      ; $00BE1E
        beq.w        loc_00BFBE                                    ; $00BE22
        bra.w        loc_00BFEE                                    ; $00BE26

loc_00BE2A:
        cmpi.b       #$32, d1                                      ; $00BE2A
        beq.w        loc_00BF8A                                    ; $00BE2E
        cmpi.b       #$33, d1                                      ; $00BE32
        beq.w        loc_00BF8A                                    ; $00BE36
        cmpi.b       #$34, d1                                      ; $00BE3A
        beq.w        loc_00BF8A                                    ; $00BE3E
        cmpi.b       #$51, d1                                      ; $00BE42
        beq.w        loc_00BF56                                    ; $00BE46
        cmpi.b       #$52, d1                                      ; $00BE4A
        beq.w        loc_00BF56                                    ; $00BE4E
        cmpi.b       #$53, d1                                      ; $00BE52
        beq.w        loc_00BF56                                    ; $00BE56
        cmpi.b       #$55, d1                                      ; $00BE5A
        beq.w        loc_00BFBE                                    ; $00BE5E
        cmpi.b       #$56, d1                                      ; $00BE62
        beq.w        loc_00BFBE                                    ; $00BE66
        cmpi.b       #$57, d1                                      ; $00BE6A
        beq.w        loc_00BFBE                                    ; $00BE6E
        cmpi.b       #$59, d1                                      ; $00BE72
        beq.w        loc_00BFEE                                    ; $00BE76
        cmpi.b       #$5a, d1                                      ; $00BE7A
        beq.w        loc_00BFEE                                    ; $00BE7E
        cmpi.b       #$5b, d1                                      ; $00BE82
        beq.w        loc_00BFEE                                    ; $00BE86
        bra.w        loc_00BFEE                                    ; $00BE8A

loc_00BE8E:
        cmpi.b       #$32, d1                                      ; $00BE8E
        beq.w        loc_00BFEE                                    ; $00BE92
        cmpi.b       #$33, d1                                      ; $00BE96
        beq.w        loc_00BFEE                                    ; $00BE9A
        cmpi.b       #$34, d1                                      ; $00BE9E
        beq.w        loc_00BFEE                                    ; $00BEA2
        cmpi.b       #$51, d1                                      ; $00BEA6
        beq.w        loc_00BFBE                                    ; $00BEAA
        cmpi.b       #$52, d1                                      ; $00BEAE
        beq.w        loc_00BFBE                                    ; $00BEB2
        cmpi.b       #$53, d1                                      ; $00BEB6
        beq.w        loc_00BFBE                                    ; $00BEBA
        cmpi.b       #$55, d1                                      ; $00BEBE
        beq.w        loc_00BF8A                                    ; $00BEC2
        cmpi.b       #$56, d1                                      ; $00BEC6
        beq.w        loc_00BF8A                                    ; $00BECA
        cmpi.b       #$57, d1                                      ; $00BECE
        beq.w        loc_00BF8A                                    ; $00BED2
        cmpi.b       #$59, d1                                      ; $00BED6
        beq.w        loc_00BF56                                    ; $00BEDA
        cmpi.b       #$5a, d1                                      ; $00BEDE
        beq.w        loc_00BF56                                    ; $00BEE2
        cmpi.b       #$5b, d1                                      ; $00BEE6
        beq.w        loc_00BF56                                    ; $00BEEA
        bra.w        loc_00BFEE                                    ; $00BEEE

loc_00BEF2:
        cmpi.b       #$32, d1                                      ; $00BEF2
        beq.w        loc_00BFBE                                    ; $00BEF6
        cmpi.b       #$33, d1                                      ; $00BEFA
        beq.w        loc_00BFBE                                    ; $00BEFE
        cmpi.b       #$34, d1                                      ; $00BF02
        beq.w        loc_00BFBE                                    ; $00BF06
        cmpi.b       #$51, d1                                      ; $00BF0A
        beq.w        loc_00BFEE                                    ; $00BF0E
        cmpi.b       #$52, d1                                      ; $00BF12
        beq.w        loc_00BFEE                                    ; $00BF16
        cmpi.b       #$53, d1                                      ; $00BF1A
        beq.w        loc_00BFEE                                    ; $00BF1E
        cmpi.b       #$55, d1                                      ; $00BF22
        beq.w        loc_00BF56                                    ; $00BF26
        cmpi.b       #$56, d1                                      ; $00BF2A
        beq.w        loc_00BF56                                    ; $00BF2E
        cmpi.b       #$57, d1                                      ; $00BF32
        beq.w        loc_00BF56                                    ; $00BF36
        cmpi.b       #$59, d1                                      ; $00BF3A
        beq.w        loc_00BF8A                                    ; $00BF3E
        cmpi.b       #$5a, d1                                      ; $00BF42
        beq.w        loc_00BF8A                                    ; $00BF46
        cmpi.b       #$5b, d1                                      ; $00BF4A
        beq.w        loc_00BF8A                                    ; $00BF4E
        bra.w        loc_00BFEE                                    ; $00BF52

loc_00BF56:
        addi.w       #$80, -$71ee(a6)                              ; $00BF56
        move.b       -$7205(a6), d0                                ; $00BF5C
        move.b       -$7203(a6), d1                                ; $00BF60
        subi.b       #$80, d0                                      ; $00BF64
        subi.b       #$80, d1                                      ; $00BF68
        ext.w        d0                                            ; $00BF6C
        ext.w        d1                                            ; $00BF6E
        jsr          RotateVectorPlusQuarterTurn.l                 ; $00BF70
        addi.b       #$80, d0                                      ; $00BF76
        addi.b       #$80, d1                                      ; $00BF7A
        move.b       d0, -$7205(a6)                                ; $00BF7E
        move.b       d1, -$7203(a6)                                ; $00BF82
        bra.w        loc_00BFEE                                    ; $00BF86

loc_00BF8A:
        subi.w       #$80, -$71ee(a6)                              ; $00BF8A
        move.b       -$7205(a6), d0                                ; $00BF90
        move.b       -$7203(a6), d1                                ; $00BF94
        subi.b       #$80, d0                                      ; $00BF98
        subi.b       #$80, d1                                      ; $00BF9C
        ext.w        d0                                            ; $00BFA0
        ext.w        d1                                            ; $00BFA2
        jsr          RotateVectorMinusQuarterTurn.l                ; $00BFA4
        addi.b       #$80, d0                                      ; $00BFAA
        addi.b       #$80, d1                                      ; $00BFAE
        move.b       d0, -$7205(a6)                                ; $00BFB2
        move.b       d1, -$7203(a6)                                ; $00BFB6
        bra.w        loc_00BFEE                                    ; $00BFBA

loc_00BFBE:
        addi.w       #$100, -$71ee(a6)                             ; $00BFBE
        move.b       -$7205(a6), d0                                ; $00BFC4
        move.b       -$7203(a6), d1                                ; $00BFC8
        subi.b       #$80, d0                                      ; $00BFCC
        subi.b       #$80, d1                                      ; $00BFD0
        ext.w        d0                                            ; $00BFD4
        ext.w        d1                                            ; $00BFD6
        jsr          loc_098AA2.l                                  ; $00BFD8
        addi.b       #$80, d0                                      ; $00BFDE
        addi.b       #$80, d1                                      ; $00BFE2
        move.b       d0, -$7205(a6)                                ; $00BFE6
        move.b       d1, -$7203(a6)                                ; $00BFEA

loc_00BFEE:
        andi.w       #$1ff, -$71ee(a6)                             ; $00BFEE
        lea.l        AngleVectorPairs(pc), a0                      ; $00BFF4
        move.w       -$71ee(a6), d0                                ; $00BFF8
        lsl.w        #$2, d0                                       ; $00BFFC
        move.w       (a0, d0.w), -$71f2(a6)                        ; $00BFFE
        move.w       $2(a0, d0.w), -$71f0(a6)                      ; $00C004
        ifne *-$C00A
        fail "ROM end moved"
        endif
