; $0145A8..$0145D7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin grenade: phase/lowering guards, sound2A, phase1, consume$100. Actual allocation later in draw at old phase3.
        ifne *-$145A8
        fail "ROM start moved"
        endif

BeginHandGrenadeThrow:
; Begin grenade: phase/lowering guards, sound2A, phase1, consume$100. Actual allocation later in draw at old phase3.
        tst.w        rWeaponActionPhase(a6)                        ; $0145A8
        bne.b        loc_0145D6                                    ; $0145AC
        tst.w        rWeaponLoweringOffset(a6)                     ; $0145AE
        bne.b        loc_0145D6                                    ; $0145B2
        clr.w        rStatusSoundScriptActive(a6)                                    ; $0145B4
        clr.w        rSoundEffectCooldown(a6)                                    ; $0145B8
        move.w       #$2a, d0                                      ; $0145BC
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $0145C0
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $0145C6
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0145CC
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $0145D2

loc_0145D6:
        rts                                                        ; $0145D6
        ifne *-$145D8
        fail "ROM end moved"
        endif
