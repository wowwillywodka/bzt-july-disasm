; $013844..$0138B7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Shotgun recoil and phase2 flash; actual hit occurs in FireShotgun, not here.
        ifne *-$13844
        fail "ROM start moved"
        endif

DrawShotgunWeapon:
; Shotgun recoil and phase2 flash; actual hit occurs in FireShotgun, not here.
        addi.w       #$d9, d0                                      ; $013844
        addi.w       #$114, d1                                     ; $013848
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $01384C
        move.w       rWeaponActionPhase(a6), d3                    ; $013850
        beq.b        loc_01386E                                    ; $013854
        move.b       (a0, d3.w), d2                                ; $013856
        ext.w        d2                                            ; $01385A
        add.w        d2, d0                                        ; $01385C
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $01385E
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013862
        bne.b        loc_01386E                                    ; $013868
        clr.w        rWeaponActionPhase(a6)                        ; $01386A

loc_01386E:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $01386E
        move.w       d0, (a2)+                                     ; $013872
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013874
        ori.w        #$b00, d2                                     ; $013878
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $01387C
        move.w       d2, (a2)+                                     ; $013880
        move.w       #$a4ef, (a2)+                                 ; $013882
        move.w       d1, (a2)+                                     ; $013886
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013888
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $01388C
        bne.b        loc_0138B6                                    ; $013892
        subq.w       #$1, d1                                       ; $013894
        subq.w       #$5, d0                                       ; $013896
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013898
        move.w       d0, (a2)+                                     ; $01389C
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $01389E
        ori.w        #$a00, d2                                     ; $0138A2
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $0138A6
        move.w       d2, (a2)+                                     ; $0138AA
        move.w       #$a4fb, (a2)+                                 ; $0138AC
        move.w       d1, (a2)+                                     ; $0138B0
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $0138B2

loc_0138B6:
        rts                                                        ; $0138B6
        ifne *-$138B8
        fail "ROM end moved"
        endif
