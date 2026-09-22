; $00C00A..$00C077 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Display numeric floor label derived from 165-CurrentFloor, then select per-floor color mode. This is not an episode increment.
        ifne *-$C00A
        fail "ROM start moved"
        endif

RefreshFloorLabelAndColorMode:
; Display numeric floor label derived from 165-CurrentFloor, then select per-floor color mode. This is not an episode increment.
        movem.l      d1-d7/a0-a5, -(a7)                            ; $00C00A
        move.w       rCurrentFloor(a6), d0                         ; $00C00E
        neg.w        d0                                            ; $00C012
        addi.w       #$a5, d0                                      ; $00C014
        lea.l        $e2a(a6), a0                                  ; $00C018
        move.w       #$2e, d1                                      ; $00C01C
        cmpi.w       #$64, d0                                      ; $00C020
        bcs.b        loc_00C036                                    ; $00C024
        lea.l        Data_00C07A(pc), a1                           ; $00C026

loc_00C02A:
        subi.w       #$64, d0                                      ; $00C02A
        move.w       (a1)+, d1                                     ; $00C02E
        cmpi.w       #$64, d0                                      ; $00C030
        bcc.b        loc_00C02A                                    ; $00C034

loc_00C036:
        move.w       d1, (a0)                                      ; $00C036
        move.w       #$2e, d1                                      ; $00C038
        cmpi.w       #$a, d0                                       ; $00C03C
        bcs.b        loc_00C052                                    ; $00C040
        lea.l        Data_00C07A(pc), a1                           ; $00C042

loc_00C046:
        subi.w       #$a, d0                                       ; $00C046
        move.w       (a1)+, d1                                     ; $00C04A
        cmpi.w       #$a, d0                                       ; $00C04C
        bcc.b        loc_00C046                                    ; $00C050

loc_00C052:
        move.w       d1, $4(a0)                                    ; $00C052
        lea.l        FloorNameOffsets(pc), a1                      ; $00C056
        adda.w       d0, a1                                        ; $00C05A
        adda.w       d0, a1                                        ; $00C05C
        move.w       (a1), $8(a0)                                  ; $00C05E
        movea.l      rZoneFloorColorModes(a6), a0                  ; $00C062
        adda.w       rCurrentFloor(a6), a0                         ; $00C066
        move.b       (a0), d0                                      ; $00C06A
        jsr          SelectSceneColorMode.l                        ; $00C06C
        movem.l      (a7)+, d1-d7/a0-a5                            ; $00C072
        rts                                                        ; $00C076
        ifne *-$C078
        fail "ROM end moved"
        endif
