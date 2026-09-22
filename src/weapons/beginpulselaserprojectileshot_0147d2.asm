; $0147D2..$014801 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin Pulse Laser projectile0F: same start gate/sound as rocket, different draw/flight and hit callback.
        ifne *-$147D2
        fail "ROM start moved"
        endif

BeginPulseLaserProjectileShot:
; Begin Pulse Laser projectile0F: same start gate/sound as rocket, different draw/flight and hit callback.
        tst.w        rWeaponActionPhase(a6)                        ; $0147D2
        bne.b        loc_014800                                    ; $0147D6
        tst.w        rWeaponLoweringOffset(a6)                     ; $0147D8
        bne.b        loc_014800                                    ; $0147DC
        clr.w        -$55a0(a6)                                    ; $0147DE
        clr.w        -$559e(a6)                                    ; $0147E2
        move.w       #$37, d0                                      ; $0147E6
        jsr          SoundRoutine_00DF84.l                         ; $0147EA
        move.w       #$14, -$559e(a6)                              ; $0147F0
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0147F6
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $0147FC

loc_014800:
        rts                                                        ; $014800
        ifne *-$14802
        fail "ROM end moved"
        endif
