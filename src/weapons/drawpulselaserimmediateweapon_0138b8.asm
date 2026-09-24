; $0138B8..$013959 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Pulse Laser ID0E recoil/flash; repeats sound during nonzero phases <=4 but does not repeat hit here.
        ifne *-$138B8
        fail "ROM start moved"
        endif

DrawPulseLaserImmediateWeapon:
; Pulse Laser ID0E recoil/flash; repeats sound during nonzero phases <=4 but does not repeat hit here.
        addi.w       #$d9, d0                                      ; $0138B8
        addi.w       #$114, d1                                     ; $0138BC
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $0138C0
        move.w       rWeaponActionPhase(a6), d3                    ; $0138C4
        beq.b        loc_0138E2                                    ; $0138C8
        move.b       (a0, d3.w), d2                                ; $0138CA
        ext.w        d2                                            ; $0138CE
        add.w        d2, d0                                        ; $0138D0
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $0138D2
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $0138D6
        bne.b        loc_0138E2                                    ; $0138DC
        clr.w        rWeaponActionPhase(a6)                        ; $0138DE

loc_0138E2:
        tst.w        rWeaponActionPhase(a6)                        ; $0138E2
        beq.b        loc_013910                                    ; $0138E6
        cmpi.w       #$4, rWeaponActionPhase(a6)                   ; $0138E8
        bhi.b        loc_013910                                    ; $0138EE
        movem.w      d0-d1, -(a7)                                  ; $0138F0
        clr.w        rStatusSoundScriptActive(a6)                                    ; $0138F4
        clr.w        rSoundEffectCooldown(a6)                                    ; $0138F8
        move.w       #$1e, d0                                      ; $0138FC
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $013900
        move.w       #$f, rSoundEffectCooldown(a6)                               ; $013906
        movem.w      (a7)+, d0-d1                                  ; $01390C

loc_013910:
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $013910
        move.w       d0, (a2)+                                     ; $013914
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013916
        ori.w        #$b00, d2                                     ; $01391A
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $01391E
        move.w       d2, (a2)+                                     ; $013922
        move.w       #$a4ef, (a2)+                                 ; $013924
        move.w       d1, (a2)+                                     ; $013928
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $01392A
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $01392E
        bne.b        loc_013958                                    ; $013934
        subq.w       #$1, d1                                       ; $013936
        subq.w       #$5, d0                                       ; $013938
        movea.l      rSpriteAttributeTableWritePointer(a6), a2                                ; $01393A
        move.w       d0, (a2)+                                     ; $01393E
        move.w       rSpriteAttributeNextLink(a6), d2                                ; $013940
        ori.w        #$a00, d2                                     ; $013944
        addq.w       #$1, rSpriteAttributeNextLink(a6)                               ; $013948
        move.w       d2, (a2)+                                     ; $01394C
        move.w       #$a4fb, (a2)+                                 ; $01394E
        move.w       d1, (a2)+                                     ; $013952
        move.l       a2, rSpriteAttributeTableWritePointer(a6)                                ; $013954

loc_013958:
        rts                                                        ; $013958
        ifne *-$1395A
        fail "ROM end moved"
        endif
