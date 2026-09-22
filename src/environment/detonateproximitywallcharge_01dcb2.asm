; $01DCB2..$01DD21 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Detonation: state 2, scan nearby actor markers, open eligible wall cells in an 11x11 square, play sound $67. It does not use a circular radius or wall hit points.
        ifne *-$1DCB2
        fail "ROM start moved"
        endif

DetonateProximityWallCharge:
; Detonation: state 2, scan nearby actor markers, open eligible wall cells in an 11x11 square, play sound $67. It does not use a circular radius or wall hit points.
        move.b       #$2, ActorState(a0)                           ; $01DCB2
        move.l       a0, -(a7)                                     ; $01DCB8
        movea.l      (a7), a2                                      ; $01DCBA
        move.l       a1, -(a7)                                     ; $01DCBC
        bsr.w        GetVisibleMapBase                             ; $01DCBE
        movea.l      a1, a0                                        ; $01DCC2
        movea.l      (a7)+, a1                                     ; $01DCC4
        move.w       $24(a2), d0                                   ; $01DCC6
        move.w       $26(a2), d1                                   ; $01DCCA
        asr.w        #$8, d0                                       ; $01DCCE
        adda.w       d0, a0                                        ; $01DCD0
        clr.b        d1                                            ; $01DCD2
        asr.w        #$3, d1                                       ; $01DCD4
        adda.w       d1, a0                                        ; $01DCD6
        clr.w        d3                                            ; $01DCD8
        lea.l        rCellTypeByIndex(a6), a5                      ; $01DCDA
        movea.l      #ActorSpawnCellSelectors, a4                  ; $01DCDE
        bsr.w        EnemiesRoutine_01DE78                         ; $01DCE4
        movea.l      (a7), a2                                      ; $01DCE8
        move.w       $24(a2), d0                                   ; $01DCEA
        move.w       $26(a2), d1                                   ; $01DCEE
        move.l       a1, -(a7)                                     ; $01DCF2
        movea.l      a2, a0                                        ; $01DCF4
        bsr.w        GetVisibleMapBase                             ; $01DCF6
        movea.l      a1, a0                                        ; $01DCFA
        movea.l      (a7)+, a1                                     ; $01DCFC
        asr.w        #$8, d0                                       ; $01DCFE
        adda.w       d0, a0                                        ; $01DD00
        clr.b        d1                                            ; $01DD02
        asr.w        #$3, d1                                       ; $01DD04
        adda.w       d1, a0                                        ; $01DD06
        clr.w        d3                                            ; $01DD08
        lea.l        rCellTypeByIndex(a6), a5                      ; $01DD0A
        bsr.w        OpenWallsInChargeSquare                       ; $01DD0E
        movea.l      (a7), a0                                      ; $01DD12
        move.w       #$67, d0                                      ; $01DD14
        jsr          SoundRoutine_00DF64.l                         ; $01DD18
        movea.l      (a7)+, a0                                     ; $01DD1E
        rts                                                        ; $01DD20
        ifne *-$1DD22
        fail "ROM end moved"
        endif
