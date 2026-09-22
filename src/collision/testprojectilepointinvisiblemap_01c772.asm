; $01C772..$01C7F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Same point test but base loaded from VisibleMapBasePointer; common geometry follows at $1C776.
        ifne *-$1C772
        fail "ROM start moved"
        endif

TestProjectilePointInVisibleMap:
; Same point test but base loaded from VisibleMapBasePointer; common geometry follows at $1C776.
        movea.l      rVisibleMapBasePointer(a6), a1                ; $01C772

TestProjectilePointCommon:
        move.w       d0, d2                                        ; $01C776
        asr.w        #$8, d2                                       ; $01C778
        adda.w       d2, a1                                        ; $01C77A
        move.w       d1, d2                                        ; $01C77C
        clr.b        d2                                            ; $01C77E
        asr.w        #$3, d2                                       ; $01C780
        clr.w        d3                                            ; $01C782
        move.b       (a1, d2.w), d3                                ; $01C784
        lea.l        rCellTypeByIndex(a6), a1                      ; $01C788
        move.b       (a1, d3.w), d3                                ; $01C78C
        jsr          GetCellCollisionClass.l                       ; $01C790
        bne.b        loc_01C79A                                    ; $01C796
        rts                                                        ; $01C798

loc_01C79A:
        cmpi.b       #$1, d3                                       ; $01C79A
        beq.b        ProjectilePointBlocked                        ; $01C79E
        cmpi.b       #$6, d3                                       ; $01C7A0
        bcc.b        loc_01C7F2                                    ; $01C7A4
; Fractional X=x&255,Y=y&255. Clear sides: class2 X<=Y;3 X<=255-Y;4 X>=Y;5 X>=255-Y. Boundary equality is clear.
        clr.w        d2                                            ; $01C7A6
        move.b       d0, d2                                        ; $01C7A8
        cmpi.b       #$2, d3                                       ; $01C7AA
        beq.b        loc_01C7DE                                    ; $01C7AE
        cmpi.b       #$3, d3                                       ; $01C7B0
        beq.b        loc_01C7C8                                    ; $01C7B4
        cmpi.b       #$4, d3                                       ; $01C7B6
        beq.b        loc_01C7D4                                    ; $01C7BA
        move.w       #$ff, d3                                      ; $01C7BC
        sub.b        d1, d3                                        ; $01C7C0
        cmp.w        d3, d2                                        ; $01C7C2
        bge.b        ProjectilePointClear                          ; $01C7C4
        bra.b        ProjectilePointBlocked                        ; $01C7C6

loc_01C7C8:
        move.w       #$ff, d3                                      ; $01C7C8
        sub.b        d1, d3                                        ; $01C7CC
        cmp.w        d3, d2                                        ; $01C7CE
        ble.b        ProjectilePointClear                          ; $01C7D0
        bra.b        ProjectilePointBlocked                        ; $01C7D2

loc_01C7D4:
        clr.w        d3                                            ; $01C7D4
        move.b       d1, d3                                        ; $01C7D6
        cmp.w        d3, d2                                        ; $01C7D8
        bge.b        ProjectilePointClear                          ; $01C7DA
        bra.b        ProjectilePointBlocked                        ; $01C7DC

loc_01C7DE:
        clr.w        d3                                            ; $01C7DE
        move.b       d1, d3                                        ; $01C7E0
        cmp.w        d3, d2                                        ; $01C7E2
        bgt.b        ProjectilePointBlocked                        ; $01C7E4

ProjectilePointClear:
        move.b       #$0, d3                                       ; $01C7E6
        rts                                                        ; $01C7EA

ProjectilePointBlocked:
        move.b       #$1, d3                                       ; $01C7EC
        rts                                                        ; $01C7F0

loc_01C7F2:
        tst.b        d3                                            ; $01C7F2
        rts                                                        ; $01C7F4
        ifne *-$1C7F6
        fail "ROM end moved"
        endif
