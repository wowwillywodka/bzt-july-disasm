; $012A1E..$012A67 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Internal continuation of UpdatePlayerWeaponAndDraw, NOT a standalone routine; pending=current clears pending to FF and skips raising this call.
        ifne *-$12A1E
        fail "ROM start moved"
        endif

ContinuePlayerWeaponSwitchAndDraw:
; Internal continuation of UpdatePlayerWeaponAndDraw, NOT a standalone routine; pending=current clears pending to FF and skips raising this call.
        move.b       #$ff, rPendingWeaponId(a6)                    ; $012A1E
        bra.b        WeaponDrawCurrent                             ; $012A24

WeaponRaiseAndDraw:
; Pending FF permits raising by8 even with active phase. Current draw table itself has NO ID bounds check.
        cmpi.b       #$ff, rPendingWeaponId(a6)                    ; $012A26
        bne.b        WeaponDrawCurrent                             ; $012A2C
        tst.w        rWeaponLoweringOffset(a6)                     ; $012A2E
        beq.b        WeaponDrawCurrent                             ; $012A32
        subq.w       #$8, rWeaponLoweringOffset(a6)                ; $012A34

WeaponDrawCurrent:
        move.w       rWeaponLoweringOffset(a6), d0                 ; $012A38
        move.w       -$71ae(a6), d1                                ; $012A3C
        add.w        d1, d0                                        ; $012A40
        move.w       -$71b0(a6), d1                                ; $012A42
        add.w        d1, d1                                        ; $012A46
        clr.w        d2                                            ; $012A48
        move.b       rCurrentWeaponId(a6), d2                      ; $012A4A
        lsl.w        #$2, d2                                       ; $012A4E
        movea.l      HeldWeaponDrawHandlers(pc, d2.w), a1          ; $012A50
; FF5EC4 nonzero restores SAT write pointer after draw call, but does not undo phase, ammo, allocations, damage or sprite-link counter.
        tst.w        -$213c(a6)                                    ; $012A54
        beq.b        loc_012A66                                    ; $012A58
        move.l       -$7fc2(a6), -(a7)                             ; $012A5A
        jsr          (a1)                                          ; $012A5E
        move.l       (a7)+, -$7fc2(a6)                             ; $012A60
        rts                                                        ; $012A64

loc_012A66:
        jmp          (a1)                                          ; $012A66
        ifne *-$12A68
        fail "ROM end moved"
        endif
