; $00BC22..$00BC57 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Request current floor -1; actual destination comes from record bytes +6..+8. Link packet writes current floor +1 in this original path.
        ifne *-$BC22
        fail "ROM start moved"
        endif

RequestLowerFloorTransition:
; Request current floor -1; actual destination comes from record bytes +6..+8. Link packet writes current floor +1 in this original path.
        movem.l      d0-d1/a0-a1, -(a7)                            ; $00BC22
        tst.w        rLinkRole(a6)                                 ; $00BC26
        beq.b        loc_00BC4C                                    ; $00BC2A
        lea.l        -$6fdc(a6), a1                                ; $00BC2C
        move.b       #$12, (a1)+                                   ; $00BC30
        clr.b        (a1)+                                         ; $00BC34
        move.b       #$fa, (a1)+                                   ; $00BC36
        move.b       rCurrentFloorLow(a6), d0                      ; $00BC3A
        addq.b       #$1, d0                                       ; $00BC3E
        move.b       d0, (a1)+                                     ; $00BC40
        lea.l        -$6fdc(a6), a0                                ; $00BC42
        jsr          QueueLinkCommand.l                            ; $00BC46

loc_00BC4C:
        movem.l      (a7)+, d0-d1/a0-a1                            ; $00BC4C
        move.w       rCurrentFloor(a6), d0                         ; $00BC50
        subq.w       #$1, d0                                       ; $00BC54
        bra.b        ResolvePlayerFloorTransition                  ; $00BC56
        ifne *-$BC58
        fail "ROM end moved"
        endif
