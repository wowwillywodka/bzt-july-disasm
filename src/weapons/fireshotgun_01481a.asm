; $01481A..$0148D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shotgun immediate hit: linear distance (character0 halves), threshold compares LONG D0. Normal ConsumeSelectedItemAndUpdateHud clears upper D0 through MULU; aim selector updates only its word.
        ifne *-$1481A
        fail "ROM start moved"
        endif

FireShotgun:
; Shotgun immediate hit: linear distance (character0 halves), threshold compares LONG D0. Normal ConsumeSelectedItemAndUpdateHud clears upper D0 through MULU; aim selector updates only its word.
        tst.w        rWeaponLoweringOffset(a6)                     ; $01481A
        bne.w        loc_0148D0                                    ; $01481E
        clr.w        -$55a0(a6)                                    ; $014822
        clr.w        -$559e(a6)                                    ; $014826
        move.w       #$2d, d0                                      ; $01482A
        jsr          SoundRoutine_00DF84.l                         ; $01482E
        move.w       #$14, -$559e(a6)                              ; $014834
        move.w       #$1, rWeaponActionPhase(a6)                   ; $01483A
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014840
        move.l       d0, -(a7)                                     ; $014844
        move.w       #$1, d0                                       ; $014846
        move.w       rPlayerX(a6), d1                              ; $01484A
        move.w       rPlayerY(a6), d2                              ; $01484E
        bsr.w        ActivateEpisode1WallStages                    ; $014852
        move.l       (a7)+, d0                                     ; $014856
        move.w       #$8, d1                                       ; $014858
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $01485C
        bne.b        loc_014868                                    ; $014862
        move.w       #$c, d1                                       ; $014864

loc_014868:
        move.w       -$71b0(a6), d2                                ; $014868
        addi.w       #$40, d2                                      ; $01486C
        jsr          SelectPlayerWeaponAimTarget.l                 ; $014870
        cmpa.l       #$0, a1                                       ; $014876
        beq.b        loc_0148BE                                    ; $01487C
        movea.l      a1, a0                                        ; $01487E
        move.w       $24(a0), d0                                   ; $014880
        sub.w        rPlayerX(a6), d0                              ; $014884
        move.w       $26(a0), d1                                   ; $014888
        sub.w        rPlayerY(a6), d1                              ; $01488C
        bsr.w        OctagonalDistance                             ; $014890
        cmpi.w       #$0, rSelectedCharacter(a6)                   ; $014894
        bne.b        loc_01489E                                    ; $01489A
        asr.w        #$1, d0                                       ; $01489C

loc_01489E:
        cmpi.l       #$400, d0                                     ; $01489E
        bcc.b        loc_0148D0                                    ; $0148A4
        move.w       rPlayerX(a6), d3                              ; $0148A6
        move.w       rPlayerY(a6), d4                              ; $0148AA
        sub.w        $24(a0), d3                                   ; $0148AE
        sub.w        $26(a0), d4                                   ; $0148B2
        movea.l      ActorHitCallback(a0), a1                      ; $0148B6
        jsr          (a1)                                          ; $0148BA
        bra.b        loc_0148D0                                    ; $0148BC

loc_0148BE:
        jsr          ObjectsRoutine_00A3D2.l                       ; $0148BE
        bne.b        loc_0148CA                                    ; $0148C4
        bsr.w        TraceMissedShotAndSpawnImpact                 ; $0148C6

loc_0148CA:
        jsr          TraceShotToDamageablePanel.l                  ; $0148CA

loc_0148D0:
        rts                                                        ; $0148D0
        ifne *-$148D2
        fail "ROM end moved"
        endif
