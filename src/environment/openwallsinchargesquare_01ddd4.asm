; $01DDD4..$01DE77 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A2=charge actor, A0=center cell. Nominal 11x11 square; types $06/$83 -> opening $2D, $07/$84 -> $2E. Bounds skip rows/columns but no line-of-sight test. 16-record queue can fill.
        ifne *-$1DDD4
        fail "ROM start moved"
        endif

OpenWallsInChargeSquare:
; A2=charge actor, A0=center cell. Nominal 11x11 square; types $06/$83 -> opening $2D, $07/$84 -> $2E. Bounds skip rows/columns but no line-of-sight test. 16-record queue can fill.
        move.w       $26(a2), d0                                   ; $01DDD4
        asr.w        #$8, d0                                       ; $01DDD8
        subq.w       #$6, d0                                       ; $01DDDA
        lea.l        -$a5(a0), a1                                  ; $01DDDC
        move.w       #$a, d6                                       ; $01DDE0

loc_01DDE4:
        addq.w       #$1, d0                                       ; $01DDE4
        bmi.b        loc_01DE64                                    ; $01DDE6
        cmpi.w       #$20, d0                                      ; $01DDE8
        bcc.b        loc_01DE6C                                    ; $01DDEC
        move.w       $24(a2), d1                                   ; $01DDEE
        asr.w        #$8, d1                                       ; $01DDF2
        subq.w       #$6, d1                                       ; $01DDF4
        move.w       #$a, d7                                       ; $01DDF6

loc_01DDFA:
        addq.w       #$1, d1                                       ; $01DDFA
        bmi.b        loc_01DE5A                                    ; $01DDFC
        cmpi.w       #$20, d1                                      ; $01DDFE
        bcc.b        loc_01DE5A                                    ; $01DE02
        clr.w        d3                                            ; $01DE04
        move.b       (a1), d3                                      ; $01DE06
        lea.l        rCellTypeByIndex(a6), a5                      ; $01DE08
        move.b       (a5, d3.w), d3                                ; $01DE0C
        cmpi.b       #$6, d3                                       ; $01DE10
        beq.b        loc_01DE44                                    ; $01DE14
        cmpi.b       #$83, d3                                      ; $01DE16
        beq.b        loc_01DE44                                    ; $01DE1A
        cmpi.b       #$84, d3                                      ; $01DE1C
        beq.b        loc_01DE2A                                    ; $01DE20
        cmpi.b       #$7, d3                                       ; $01DE22
        bne.w        loc_01DE5A                                    ; $01DE26

loc_01DE2A:
        movem.l      d0-d1/d6-d7/a0-a2/a5, -(a7)                   ; $01DE2A
        movea.l      a1, a0                                        ; $01DE2E
        exg.l        d0, d1                                        ; $01DE30
        lsl.w        #$8, d0                                       ; $01DE32
        lsl.w        #$8, d1                                       ; $01DE34
        jsr          QueuePermanentWallOpeningType2E.l             ; $01DE36
        movem.l      (a7)+, d0-d1/d6-d7/a0-a2/a5                   ; $01DE3C
        bra.w        loc_01DE5A                                    ; $01DE40

loc_01DE44:
        movem.l      d0-d1/d6-d7/a0-a2/a5, -(a7)                   ; $01DE44
        movea.l      a1, a0                                        ; $01DE48
        exg.l        d0, d1                                        ; $01DE4A
        lsl.w        #$8, d0                                       ; $01DE4C
        lsl.w        #$8, d1                                       ; $01DE4E
        jsr          QueuePermanentWallOpeningType2D.l             ; $01DE50
        movem.l      (a7)+, d0-d1/d6-d7/a0-a2/a5                   ; $01DE56

loc_01DE5A:
        addq.w       #$1, a1                                       ; $01DE5A
        dbra         d7, loc_01DDFA                                ; $01DE5C
        suba.w       #$b, a1                                       ; $01DE60

loc_01DE64:
        adda.w       #$20, a1                                      ; $01DE64
        dbra         d6, loc_01DDE4                                ; $01DE68

loc_01DE6C:
        move.w       #$5e, d0                                      ; $01DE6C
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $01DE70
        rts                                                        ; $01DE76
        ifne *-$1DE78
        fail "ROM end moved"
        endif
