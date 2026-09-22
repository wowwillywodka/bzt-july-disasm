; $011F48..$011F6F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$11F48
        fail "ROM start moved"
        endif

loc_011F48:
        move.w       #$62, d0                                      ; $011F48
        jsr          SoundRoutine_00DF84.l                         ; $011F4C
        lea.l        rSelectedInventorySlot(a6), a0                ; $011F52
        move.b       (a0), d0                                      ; $011F56
        move.b       $1(a0), (a0)+                                 ; $011F58
        move.b       $1(a0), (a0)+                                 ; $011F5C
        move.b       $1(a0), (a0)+                                 ; $011F60
        move.b       $1(a0), (a0)+                                 ; $011F64
        move.b       d0, (a0)                                      ; $011F68
        bsr.w        RequestWeaponFromSelectedItem                 ; $011F6A
        rts                                                        ; $011F6E
        ifne *-$11F70
        fail "ROM end moved"
        endif
