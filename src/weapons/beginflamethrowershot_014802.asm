; $014802..$014819 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin flamethrower: phase/lowering guards, phase1, consume$100; draw emits first particle and sound.
        ifne *-$14802
        fail "ROM start moved"
        endif

BeginFlamethrowerShot:
; Begin flamethrower: phase/lowering guards, phase1, consume$100; draw emits first particle and sound.
        tst.w        rWeaponActionPhase(a6)                        ; $014802
        bne.b        loc_014818                                    ; $014806
        tst.w        rWeaponLoweringOffset(a6)                     ; $014808
        bne.b        loc_014818                                    ; $01480C
        move.w       #$1, rWeaponActionPhase(a6)                   ; $01480E
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $014814

loc_014818:
        rts                                                        ; $014818
        ifne *-$1481A
        fail "ROM end moved"
        endif
