; $00E000..$00E023 | m68k
; Maintained assembly input; no extraction occurs during build.
; If no alternate hit slot is selected, force the vest-slot selector to -1
; for one ApplyPlayerDistanceHit call, then restore it. Otherwise consume
; one unit from the alternate slot; A0 is preserved on that branch.
        ifne *-$E000
        fail "ROM start moved"
        endif

ResolvePlayerHitOrConsumeAlternateSlot:
        tst.w        rAlternateHitSlotIndex(a6)                                    ; $00E000
        bpl.b        loc_00E018                                    ; $00E004
        move.w       rBulletProofVestSlotIndex(a6), -(a7)                             ; $00E006
        move.w       #$ffff, rBulletProofVestSlotIndex(a6)                            ; $00E00A
        bsr.b        ApplyPlayerDistanceHit                        ; $00E010
        move.w       (a7)+, rBulletProofVestSlotIndex(a6)                             ; $00E012
        rts                                                        ; $00E016

loc_00E018:
        move.l       a0, -(a7)                                     ; $00E018
        jsr          ConsumeAlternateHitSlotCharge.l                            ; $00E01A
        movea.l      (a7)+, a0                                     ; $00E020
        rts                                                        ; $00E022
        ifne *-$E024
        fail "ROM end moved"
        endif
