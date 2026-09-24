; $01209A..$0120ED | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Read queued TYPE (not map-cell index), remap $85 to $25, accept $18..$82 and dispatch 107 entries. Some entries select actor banks instead of ZoneObjectTiles.
        ifne *-$1209A
        fail "ROM start moved"
        endif

DispatchWorldObjectDrawing:
; Read queued TYPE (not map-cell index), remap $85 to $25, accept $18..$82 and dispatch 107 entries. Some entries select actor banks instead of ZoneObjectTiles.
        suba.w       #ProjectedWorldObjectEntryBytes, a3          ; $01209A
        move.w       $4(a3), d2                                    ; $01209E
        andi.w       #$ff, d2                                      ; $0120A2
        cmpi.w       #$85, d2                                      ; $0120A6
        bne.b        loc_0120B0                                    ; $0120AA
        move.w       #$25, d2                                      ; $0120AC

loc_0120B0:
        subi.w       #$18, d2                                      ; $0120B0
        cmpi.w       #$6b, d2                                      ; $0120B4
        bcc.b        loc_0120EC                                    ; $0120B8
        lsl.w        #$2, d2                                       ; $0120BA
        lea.l        WorldObjectDrawHandlers(pc), a5               ; $0120BC
        movea.l      (a5, d2.w), a5                                ; $0120C0
        move.w       $6(a3), d5                                    ; $0120C4
        move.w       $8(a3), d1                                    ; $0120C8
        move.w       d5, rSoftwareSpriteProjectionScale(a6)                                ; $0120CC
        move.w       d5, d2                                        ; $0120D0
        move.w       rPlayerViewOffsetZ(a6), d3                                ; $0120D2
        sub.w        rTransitHeightOffset(a6), d3                                ; $0120D6
        addi.w       #$20, d3                                      ; $0120DA
        muls.w       d3, d2                                        ; $0120DE
        asr.l        #$6, d2                                       ; $0120E0
        addi.w       #$28, d2                                      ; $0120E2
        move.l       a3, -(a7)                                     ; $0120E6
        jsr          (a5)                                          ; $0120E8
        movea.l      (a7)+, a3                                     ; $0120EA

loc_0120EC:
        rts                                                        ; $0120EC
        ifne *-$120EE
        fail "ROM end moved"
        endif
