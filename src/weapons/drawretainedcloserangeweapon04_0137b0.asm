; $0137B0..$013843 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw-only recoil/flash for weapon ID04. No item in ItemSelectionRemap selects04; its immediate close-range action remains in dispatch table.
        ifne *-$137B0
        fail "ROM start moved"
        endif

DrawRetainedCloseRangeWeapon04:
; Draw-only recoil/flash for weapon ID04. No item in ItemSelectionRemap selects04; its immediate close-range action remains in dispatch table.
        addi.w       #$d9, d0                                      ; $0137B0
        addi.w       #$114, d1                                     ; $0137B4
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $0137B8
        move.w       rWeaponActionPhase(a6), d3                    ; $0137BC
        beq.b        loc_0137DA                                    ; $0137C0
        move.b       (a0, d3.w), d2                                ; $0137C2
        ext.w        d2                                            ; $0137C6
        add.w        d2, d0                                        ; $0137C8
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0137CA
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $0137CE
        bne.b        loc_0137DA                                    ; $0137D4
        clr.w        rWeaponActionPhase(a6)                        ; $0137D6

loc_0137DA:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $0137DA
        move.w       d0, (a2)+                                     ; $0137DE
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $0137E0
        ori.w        #$b00, d2                                     ; $0137E4
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $0137E8
        move.w       d2, (a2)+                                     ; $0137EC
        move.w       #$a4ef, (a2)+                                 ; $0137EE
        move.w       d1, (a2)+                                     ; $0137F2
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $0137F4
        move.w       rWeaponActionPhase(a6), d2                    ; $0137F8
        beq.b        loc_013842                                    ; $0137FC
        lsl.w        #$3, d2                                       ; $0137FE
        subi.w       #$a, d1                                       ; $013800
        subi.w       #$1d, d0                                      ; $013804
        add.w        d2, d0                                        ; $013808
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $01380A
        move.w       d0, (a2)+                                     ; $01380E
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013810
        ori.w        #$a00, d2                                     ; $013814
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013818
        move.w       d2, (a2)+                                     ; $01381C
        move.w       #$a4fb, d3                                    ; $01381E
        btst.b       #$0, rWeaponActionPhaseLow(a6)                               ; $013822
        beq.b        loc_01382E                                    ; $013828
        ori.w        #$800, d3                                     ; $01382A

loc_01382E:
        btst.b       #$1, rWeaponActionPhaseLow(a6)                               ; $01382E
        beq.b        loc_01383A                                    ; $013834
        ori.w        #$1000, d3                                    ; $013836

loc_01383A:
        move.w       d3, (a2)+                                     ; $01383A
        move.w       d1, (a2)+                                     ; $01383C
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $01383E

loc_013842:
        rts                                                        ; $013842
        ifne *-$13844
        fail "ROM end moved"
        endif
