; $014A1A..$014AE5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Scan (2*D0+1)^2 cells in the 32-wide local window, right-to-left within each row. Match raw indices $EC..$EF/$F4..$F7, not cell types. No window-edge clipping.
        ifne *-$14A1A
        fail "ROM start moved"
        endif

QueueWallStagesInSquare:
; Scan (2*D0+1)^2 cells in the 32-wide local window, right-to-left within each row. Match raw indices $EC..$EF/$F4..$F7, not cell types. No window-edge clipping.
        movem.l      d1-d7/a0-a6, -(a7)                            ; $014A1A
        lea.l        rVisibleMapWindow(a6), a1                     ; $014A1E
        lsr.w        #$8, d1                                       ; $014A22
        lsr.w        #$8, d2                                       ; $014A24
        sub.w        d0, d1                                        ; $014A26
        sub.w        d0, d2                                        ; $014A28
        move.w       d1, d3                                        ; $014A2A
        move.w       d2, d4                                        ; $014A2C
        lsl.w        #$5, d2                                       ; $014A2E
        add.w        d1, d2                                        ; $014A30
        adda.w       d2, a1                                        ; $014A32
        lsl.w        #$1, d0                                       ; $014A34
        move.w       d0, d7                                        ; $014A36
        move.w       d0, d6                                        ; $014A38
        add.w        d0, d3                                        ; $014A3A
        lsl.w        #$8, d3                                       ; $014A3C
        lsl.w        #$8, d4                                       ; $014A3E

loc_014A40:
        movem.w      d0/d3, -(a7)                                  ; $014A40

loc_014A44:
        movem.w      d6-d7, -(a7)                                  ; $014A44
        move.b       DestructibleWallCellVariants(pc), d5          ; $014A48
        cmp.b        (a1, d6.w), d5                                ; $014A4C
        beq.b        loc_014A9C                                    ; $014A50
        move.b       Data_0149F4(pc), d5                           ; $014A52
        cmp.b        (a1, d6.w), d5                                ; $014A56
        beq.b        loc_014AB0                                    ; $014A5A
        move.b       Data_0149F1(pc), d5                           ; $014A5C
        cmp.b        (a1, d6.w), d5                                ; $014A60
        beq.b        loc_014A9C                                    ; $014A64
        move.b       Data_0149F5(pc), d5                           ; $014A66
        cmp.b        (a1, d6.w), d5                                ; $014A6A
        beq.b        loc_014AB0                                    ; $014A6E
        move.b       Data_0149F2(pc), d5                           ; $014A70
        cmp.b        (a1, d6.w), d5                                ; $014A74
        beq.w        loc_014A9C                                    ; $014A78
        move.b       Data_0149F6(pc), d5                           ; $014A7C
        cmp.b        (a1, d6.w), d5                                ; $014A80
        beq.b        loc_014AB0                                    ; $014A84
        move.b       Data_0149F3(pc), d5                           ; $014A86
        cmp.b        (a1, d6.w), d5                                ; $014A8A
        beq.b        loc_014A9C                                    ; $014A8E
        move.b       Data_0149F7(pc), d5                           ; $014A90
        cmp.b        (a1, d6.w), d5                                ; $014A94
        beq.b        loc_014AB0                                    ; $014A98
        bra.b        loc_014AC2                                    ; $014A9A

loc_014A9C:
        movem.l      d3-d4/a1, -(a7)                               ; $014A9C
        lea.l        (a1, d6.w), a0                                ; $014AA0
        jsr          QueueEnemyReleaseWall.l                       ; $014AA4
        movem.l      (a7)+, d3-d4/a1                               ; $014AAA
        bra.b        loc_014AC2                                    ; $014AAE

loc_014AB0:
        movem.l      d3-d4/a1, -(a7)                               ; $014AB0
        lea.l        (a1, d6.w), a0                                ; $014AB4
        jsr          QueueEnemyReleaseWall.l                       ; $014AB8
        movem.l      (a7)+, d3-d4/a1                               ; $014ABE

loc_014AC2:
        subi.w       #$100, d3                                     ; $014AC2
        movem.w      (a7)+, d6-d7                                  ; $014AC6
        dbra         d6, loc_014A44                                ; $014ACA
        movem.w      (a7)+, d0/d3                                  ; $014ACE
        adda.w       #$20, a1                                      ; $014AD2
        move.w       d0, d6                                        ; $014AD6
        addi.w       #$100, d4                                     ; $014AD8
        dbra         d7, loc_014A40                                ; $014ADC
        movem.l      (a7)+, d1-d7/a0-a6                            ; $014AE0
        rts                                                        ; $014AE4
        ifne *-$14AE6
        fail "ROM end moved"
        endif
