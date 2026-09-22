; $0142D4..$014303 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Begin unarmed action if phase/lowering both0; sound2A, phase1, variant=3-2*(Down bit1)-1*(Right bit3). Up-test at14304 is skipped by ordinary branch14302.
        ifne *-$142D4
        fail "ROM start moved"
        endif

BeginUnarmedAttack:
; Begin unarmed action if phase/lowering both0; sound2A, phase1, variant=3-2*(Down bit1)-1*(Right bit3). Up-test at14304 is skipped by ordinary branch14302.
        tst.w        rWeaponActionPhase(a6)                        ; $0142D4
        bne.b        loc_014326                                    ; $0142D8
        tst.w        rWeaponLoweringOffset(a6)                     ; $0142DA
        bne.b        loc_014326                                    ; $0142DE
        clr.w        -$55a0(a6)                                    ; $0142E0
        clr.w        -$559e(a6)                                    ; $0142E4
        move.w       #$2a, d0                                      ; $0142E8
        jsr          SoundRoutine_00DF84.l                         ; $0142EC
        move.w       #$f, -$559e(a6)                               ; $0142F2
        move.w       #$1, rWeaponActionPhase(a6)                   ; $0142F8
        move.w       #$3, d2                                       ; $0142FE
        bra.b        loc_01430E                                    ; $014302
        ifne *-$14304
        fail "ROM end moved"
        endif
