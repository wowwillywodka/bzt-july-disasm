; $0147A2..$0147D1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin rocket: phase/lowering guards, sound37, phase1, consume$100; allocation deferred to first draw.
        ifne *-$147A2
        fail "ROM start moved"
        endif

BeginRocketShot:
; Begin rocket: phase/lowering guards, sound37, phase1, consume$100; allocation deferred to first draw.
        tst.w        rWeaponActionPhase(a6)                        ; $0147A2
        bne.b        loc_0147D0                                    ; $0147A6
        tst.w        rWeaponLoweringOffset(a6)                     ; $0147A8
        bne.b        loc_0147D0                                    ; $0147AC
        clr.w        -$55a0(a6)                                    ; $0147AE
        clr.w        -$559e(a6)                                    ; $0147B2
        move.w       #$37, d0                                      ; $0147B6
        jsr          SoundRoutine_00DF84.l                         ; $0147BA
        move.w       #$14, -$559e(a6)                              ; $0147C0
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0147C6
        bsr.w        ConsumeSelectedItemAndUpdateHud               ; $0147CC

loc_0147D0:
        rts                                                        ; $0147D0
        ifne *-$147D2
        fail "ROM end moved"
        endif
