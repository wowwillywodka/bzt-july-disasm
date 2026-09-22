; $01417C..$0141A3 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Dispatch current ID only when pending=FF or same ID. Negative current returns; unsigned IDs18..127 fall back to action0 WITHOUT changing stored current ID. All18 table entries retained.
        ifne *-$1417C
        fail "ROM start moved"
        endif

DispatchWeaponAction:
; Dispatch current ID only when pending=FF or same ID. Negative current returns; unsigned IDs18..127 fall back to action0 WITHOUT changing stored current ID. All18 table entries retained.
        clr.w        d0                                            ; $01417C
        move.b       rCurrentWeaponId(a6), d0                      ; $01417E
        bmi.b        loc_0141A2                                    ; $014182
        cmpi.b       #$ff, rPendingWeaponId(a6)                    ; $014184
        beq.b        loc_014192                                    ; $01418A
        cmp.b        rPendingWeaponId(a6), d0                      ; $01418C
        bne.b        loc_0141A2                                    ; $014190

loc_014192:
        cmpi.w       #$11, d0                                      ; $014192
        bls.b        loc_01419A                                    ; $014196
        clr.w        d0                                            ; $014198

loc_01419A:
        lsl.w        #$2, d0                                       ; $01419A
        movea.l      WeaponActionHandlers(pc, d0.w), a0            ; $01419C
        jsr          (a0)                                          ; $0141A0

loc_0141A2:
        rts                                                        ; $0141A2
        ifne *-$141A4
        fail "ROM end moved"
        endif
