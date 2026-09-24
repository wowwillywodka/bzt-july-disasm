; $01DE78..$01DEE3 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1DE78
        fail "ROM start moved"
        endif

SpawnActorsNearDetonatedWallCharge:
        move.w       ActorY(a2), d0                                   ; $01DE78
        asr.w        #$8, d0                                       ; $01DE7C
        subq.w       #$6, d0                                       ; $01DE7E
        lea.l        -$a5(a0), a1                                  ; $01DE80
        move.w       #$a, d6                                       ; $01DE84

loc_01DE88:
        addq.w       #$1, d0                                       ; $01DE88
        bmi.b        loc_01DEDA                                    ; $01DE8A
        cmpi.w       #$20, d0                                      ; $01DE8C
        bcc.b        loc_01DEE2                                    ; $01DE90
        move.w       ActorX(a2), d1                                   ; $01DE92
        asr.w        #$8, d1                                       ; $01DE96
        subq.w       #$6, d1                                       ; $01DE98
        move.w       #$a, d7                                       ; $01DE9A

loc_01DE9E:
        addq.w       #$1, d1                                       ; $01DE9E
        bmi.b        loc_01DED0                                    ; $01DEA0
        cmpi.w       #$20, d1                                      ; $01DEA2
        bcc.b        loc_01DED0                                    ; $01DEA6
        move.b       (a1), d3                                      ; $01DEA8
        move.b       (a5, d3.w), d3                                ; $01DEAA
        move.b       (a4, d3.w), d3                                ; $01DEAE
        beq.b        loc_01DED0                                    ; $01DEB2
        movem.w      d1/d5-d6, -(a7)                               ; $01DEB4
        move.w       rCurrentFloor(a6), -(a7)                      ; $01DEB8
        move.b       ActorFloor(a2), rCurrentFloorLow(a6)                 ; $01DEBC
        jsr          SelectActorDefinitionFromCell.l               ; $01DEC2
        move.w       (a7)+, rCurrentFloor(a6)                      ; $01DEC8
        movem.w      (a7)+, d1/d5-d6                               ; $01DECC

loc_01DED0:
        addq.w       #$1, a1                                       ; $01DED0
        dbra         d7, loc_01DE9E                                ; $01DED2
        suba.w       #$b, a1                                       ; $01DED6

loc_01DEDA:
        adda.w       #$20, a1                                      ; $01DEDA
        dbra         d6, loc_01DE88                                ; $01DEDE

loc_01DEE2:
        rts                                                        ; $01DEE2
        ifne *-$1DEE4
        fail "ROM end moved"
        endif
