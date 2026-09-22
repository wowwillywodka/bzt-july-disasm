; $01395A..$0139CF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Buligun recoil/phase2 flash; immediate hit belongs to FireBuligun.
        ifne *-$1395A
        fail "ROM start moved"
        endif

DrawBuligunWeapon:
; Buligun recoil/phase2 flash; immediate hit belongs to FireBuligun.
        addi.w       #$d9, d0                                      ; $01395A
        addi.w       #$114, d1                                     ; $01395E
        lea.l        WeaponRecoilOffsets(pc), a0                   ; $013962
        move.w       rWeaponActionPhase(a6), d3                    ; $013966
        beq.b        loc_013984                                    ; $01396A
        move.b       (a0, d3.w), d2                                ; $01396C
        ext.w        d2                                            ; $013970
        add.w        d2, d0                                        ; $013972
        addq.w       #$1, rWeaponActionPhase(a6)                   ; $013974
        cmpi.w       #$5, rWeaponActionPhase(a6)                   ; $013978
        bne.b        loc_013984                                    ; $01397E
        clr.w        rWeaponActionPhase(a6)                        ; $013980

loc_013984:
        movea.l      -$7fc2(a6), a2                                ; $013984
        move.w       d0, (a2)+                                     ; $013988
        move.w       -$7fbe(a6), d2                                ; $01398A
        ori.w        #$b00, d2                                     ; $01398E
        addq.w       #$1, -$7fbe(a6)                               ; $013992
        move.w       d2, (a2)+                                     ; $013996
        move.w       #$a4ef, (a2)+                                 ; $013998
        move.w       d1, (a2)+                                     ; $01399C
        move.l       a2, -$7fc2(a6)                                ; $01399E
        cmpi.w       #$2, rWeaponActionPhase(a6)                   ; $0139A2
        bne.b        loc_0139CE                                    ; $0139A8
        subq.w       #$1, d1                                       ; $0139AA
        subi.w       #$9, d0                                       ; $0139AC
        movea.l      -$7fc2(a6), a2                                ; $0139B0
        move.w       d0, (a2)+                                     ; $0139B4
        move.w       -$7fbe(a6), d2                                ; $0139B6
        ori.w        #$a00, d2                                     ; $0139BA
        addq.w       #$1, -$7fbe(a6)                               ; $0139BE
        move.w       d2, (a2)+                                     ; $0139C2
        move.w       #$a4fb, (a2)+                                 ; $0139C4
        move.w       d1, (a2)+                                     ; $0139C8
        move.l       a2, -$7fc2(a6)                                ; $0139CA

loc_0139CE:
        rts                                                        ; $0139CE
        ifne *-$139D0
        fail "ROM end moved"
        endif
