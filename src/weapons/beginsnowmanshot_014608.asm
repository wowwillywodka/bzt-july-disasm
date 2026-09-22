; $014608..$01461F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin Snowman: phase/lowering guards, phase1, consume$100; sound and emissions happen in draw.
        ifne *-$14608
        fail "ROM start moved"
        endif

BeginSnowmanShot:
; Begin Snowman: phase/lowering guards, phase1, consume$100; sound and emissions happen in draw.
        tst.w        rWeaponActionPhase(a6)                        ; $014608
        bne.b        loc_01461E                                    ; $01460C
        tst.w        rWeaponLoweringOffset(a6)                     ; $01460E
        bne.b        loc_01461E                                    ; $014612
        move.w       #$1, rWeaponActionPhase(a6)                   ; $014614
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $01461A

loc_01461E:
        rts                                                        ; $01461E
        ifne *-$14620
        fail "ROM end moved"
        endif
