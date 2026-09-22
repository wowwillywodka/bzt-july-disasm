; $01C616..$01C653 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Nine DamagePanelCellAtPoint calls at XY plus offsets -$100,0,+$100; then StartProjectileExplosionAndWallStages. Hit-triggered detonation bypasses this nine-call tail.
        ifne *-$1C616
        fail "ROM start moved"
        endif

DamageProjectileThreeByThreePanels:
; Nine DamagePanelCellAtPoint calls at XY plus offsets -$100,0,+$100; then StartProjectileExplosionAndWallStages. Hit-triggered detonation bypasses this nine-call tail.
        move.w       #$2, d7                                       ; $01C616
        move.w       ActorX(a0), d0                                ; $01C61A
        subi.w       #$100, d0                                     ; $01C61E

loc_01C622:
        move.w       #$2, d6                                       ; $01C622
        move.w       ActorY(a0), d1                                ; $01C626
        subi.w       #$100, d1                                     ; $01C62A

loc_01C62E:
        movem.w      d0-d1/d6-d7, -(a7)                            ; $01C62E
        move.l       a0, -(a7)                                     ; $01C632
        jsr          DamagePanelCellAtPoint.l                      ; $01C634
        movea.l      (a7)+, a0                                     ; $01C63A
        movem.w      (a7)+, d0-d1/d6-d7                            ; $01C63C
        addi.w       #$100, d1                                     ; $01C640
        dbra         d6, loc_01C62E                                ; $01C644
        addi.w       #$100, d0                                     ; $01C648
        dbra         d7, loc_01C622                                ; $01C64C
        bra.w        StartProjectileExplosionAndWallStages         ; $01C650
        ifne *-$1C654
        fail "ROM end moved"
        endif
