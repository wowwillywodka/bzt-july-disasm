; $01E91E..$01EA19 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D1.w=aim allowance,D2.w=aim center+64. A1=selected target or0. Flags by scene-height sign (40/80/08), same floor, projected depth/cross-product gates and strict reciprocal-depth improvement over FF8ACA. No five-ray LOS. Floor0 retained scene-effect tail may call $28A4.
        ifne *-$1E91E
        fail "ROM start moved"
        endif

SelectPlayerWeaponAimTarget:
; D1.w=aim allowance,D2.w=aim center+64. A1=selected target or0. Flags by scene-height sign (40/80/08), same floor, projected depth/cross-product gates and strict reciprocal-depth improvement over FF8ACA. No five-ray LOS. Floor0 retained scene-effect tail may call $28A4.
        movea.l      #$0, a1                                       ; $01E91E
        move.w       rActiveActorCount(a6), d7                     ; $01E924
        beq.w        WeaponAimLegacySceneEffect                    ; $01E928
        subq.w       #$1, d7                                       ; $01E92C
        movea.l      rActiveActorHead(a6), a0                      ; $01E92E
        move.w       rCenterScreenColumnDepthWord(a6), d0                                  ; $01E932
        move.w       #ActorFlagAimLevel, rWeaponTargetFlagsMask(a6)              ; $01E936
        tst.w        rPlayerViewOffsetZ(a6)                                    ; $01E93C
        beq.b        WeaponAimVisitActor                           ; $01E940
        bmi.b        loc_01E94C                                    ; $01E942
        move.w       #ActorFlagAimAbove, rWeaponTargetFlagsMask(a6)              ; $01E944
        bra.b        WeaponAimVisitActor                           ; $01E94A

loc_01E94C:
        move.w       #ActorFlagAimBelow, rWeaponTargetFlagsMask(a6)               ; $01E94C

WeaponAimVisitActor:
        move.w       ActorFlags(a0), d4                            ; $01E952
        and.w        rWeaponTargetFlagsMask(a6), d4                ; $01E956
        beq.w        WeaponAimNextActor                            ; $01E95A
        move.w       rCurrentFloor(a6), d4                         ; $01E95E
        cmp.b        ActorFloor(a0), d4                            ; $01E962
        bne.w        WeaponAimNextActor                            ; $01E966
        move.w       ActorX(a0), d4                                ; $01E96A
        sub.w        rPlayerX(a6), d4                              ; $01E96E
        move.w       d4, d5                                        ; $01E972
        muls.w       rPlayerFacingVectorX(a6), d4                                ; $01E974
        move.w       ActorY(a0), d3                                ; $01E978
        sub.w        rPlayerY(a6), d3                              ; $01E97C
        move.w       d3, d6                                        ; $01E980
        muls.w       rPlayerFacingVectorY(a6), d3                                ; $01E982
        add.l        d3, d4                                        ; $01E986
        muls.w       rPlayerFacingVectorX(a6), d6                                ; $01E988
        muls.w       rPlayerFacingVectorY(a6), d5                                ; $01E98C
        sub.l        d5, d6                                        ; $01E990
        asr.l        #$6, d4                                       ; $01E992
        cmpi.l       #$2, d4                                       ; $01E994
        blt.b        WeaponAimNextActor                            ; $01E99A
; D5=DIVS($10000,forwardDepth) packs remainder in HIGH word. Candidate commit at1E9C0 copies only D5.w into D0.w; remainder is NOT returned in D0. Upper D0 remains caller-owned.
        move.l       #$10000, d5                                   ; $01E99C
        divs.w       d4, d5                                        ; $01E9A2
        cmp.w        d0, d5                                        ; $01E9A4
        bls.b        WeaponAimNextActor                            ; $01E9A6
        divs.w       d4, d6                                        ; $01E9A8
        bpl.b        loc_01E9AE                                    ; $01E9AA
        neg.w        d6                                            ; $01E9AC

loc_01E9AE:
        addi.w       #$40, d6                                      ; $01E9AE
        sub.w        d2, d6                                        ; $01E9B2
        move.w       d5, d4                                        ; $01E9B4
        asr.w        #$3, d4                                       ; $01E9B6
        add.w        d1, d4                                        ; $01E9B8
        cmp.w        d4, d6                                        ; $01E9BA
        bhi.b        WeaponAimNextActor                            ; $01E9BC
        movea.l      a0, a1                                        ; $01E9BE
        move.w       d5, d0                                        ; $01E9C0

WeaponAimNextActor:
        movea.l      (a0), a0                                      ; $01E9C2
        dbra         d7, WeaponAimVisitActor                       ; $01E9C4

WeaponAimLegacySceneEffect:
        tst.w        rCurrentFloor(a6)                             ; $01E9C8
        beq.b        loc_01E9D0                                    ; $01E9CC
        rts                                                        ; $01E9CE

loc_01E9D0:
        tst.b        rRetainedPanoramaEffectActive(a6)                                    ; $01E9D0
        beq.b        loc_01E9FA                                    ; $01E9D4
        movea.l      rPlayerCellPointer(a6), a0                    ; $01E9D6
        clr.w        d3                                            ; $01E9DA
        move.b       (a0), d3                                      ; $01E9DC
        lea.l        rCellTypeByIndex(a6), a5                      ; $01E9DE
        move.b       (a5, d3.w), d3                                ; $01E9E2
        cmpi.b       #$28, d3                                      ; $01E9E6
        beq.b        loc_01E9FC                                    ; $01E9EA
        cmpi.w       #$fffb, rPlayerViewOffsetZ(a6)                            ; $01E9EC
        blt.b        loc_01E9FA                                    ; $01E9F2
        cmpi.b       #$27, d3                                      ; $01E9F4
        beq.b        loc_01E9FC                                    ; $01E9F8

loc_01E9FA:
        rts                                                        ; $01E9FA

loc_01E9FC:
        lsl.w        #$1, d2                                       ; $01E9FC
        addi.w       #$9e, d2                                      ; $01E9FE
        sub.w        rRetainedPanoramaSpriteScreenX(a6), d2                                ; $01EA02
        bpl.b        loc_01EA0A                                    ; $01EA06
        neg.w        d2                                            ; $01EA08

loc_01EA0A:
        cmpi.w       #$3, d2                                       ; $01EA0A
        bhi.b        loc_01E9FA                                    ; $01EA0E
        move.b       #$20, rRetainedPanoramaEffectFrame(a6)                              ; $01EA10
        jmp          QueueRetainedEffectLinkCommandIfConnected.w                                  ; $01EA16
        ifne *-$1EA1A
        fail "ROM end moved"
        endif
