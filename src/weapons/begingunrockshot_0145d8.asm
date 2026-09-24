; $0145D8..$014607 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin Gunrock: phase/lowering guards, sound2A, phase1, consume$100. Allocation occurs during first draw.
        ifne *-$145D8
        fail "ROM start moved"
        endif

BeginGunrockShot:
; Begin Gunrock: phase/lowering guards, sound2A, phase1, consume$100. Allocation occurs during first draw.
        tst.w        rWeaponActionPhase(a6)                        ; $0145D8
        bne.b        loc_014606                                    ; $0145DC
        tst.w        rWeaponLoweringOffset(a6)                     ; $0145DE
        bne.b        loc_014606                                    ; $0145E2
        clr.w        rStatusSoundScriptActive(a6)                                    ; $0145E4
        clr.w        rSoundEffectCooldown(a6)                                    ; $0145E8
        move.w       #$2a, d0                                      ; $0145EC
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $0145F0
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $0145F6
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0145FC
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014602

loc_014606:
        rts                                                        ; $014606
        ifne *-$14608
        fail "ROM end moved"
        endif
