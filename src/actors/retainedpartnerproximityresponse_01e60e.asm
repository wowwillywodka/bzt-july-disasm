; $01E60E..$01E6EB | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$1E60E
        fail "ROM start moved"
        endif

RetainedPartnerProximityResponse:
        tst.w        rLinkRole(a6)                                 ; $01E60E
        beq.w        loc_01E6D6                                    ; $01E612
        movea.l      rActiveActorHead(a6), a1                      ; $01E616
        move.b       $36(a1), d0                                   ; $01E61A
        cmp.b        $36(a0), d0                                   ; $01E61E
        bne.w        loc_01E6D6                                    ; $01E622
        move.w       rCurrentFloor(a6), d0                         ; $01E626
        cmp.b        $36(a0), d0                                   ; $01E62A
        bne.w        loc_01E6E6                                    ; $01E62E
        move.w       $24(a1), d0                                   ; $01E632
        move.w       $26(a1), d1                                   ; $01E636
        move.w       $24(a0), d3                                   ; $01E63A
        move.w       $26(a0), d4                                   ; $01E63E
        movem.l      d5-d6/a0-a1/a5, -(a7)                         ; $01E642
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01E646
        movem.l      (a7)+, d5-d6/a0-a1/a5                         ; $01E64A
        bne.w        loc_01E676                                    ; $01E64E
        move.w       rPlayerX(a6), d0                              ; $01E652
        move.w       rPlayerY(a6), d1                              ; $01E656
        move.w       $24(a0), d3                                   ; $01E65A
        move.w       $26(a0), d4                                   ; $01E65E
        movem.l      d5-d6/a0-a1/a5, -(a7)                         ; $01E662
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01E666
        movem.l      (a7)+, d5-d6/a0-a1/a5                         ; $01E66A
        bne.w        loc_01E6E6                                    ; $01E66E
        bra.w        loc_01E69A                                    ; $01E672

loc_01E676:
        move.w       rPlayerX(a6), d0                              ; $01E676
        move.w       rPlayerY(a6), d1                              ; $01E67A
        move.w       $24(a0), d3                                   ; $01E67E
        move.w       $26(a0), d4                                   ; $01E682
        movem.l      d5-d6/a0-a1/a5, -(a7)                         ; $01E686
        bsr.w        TraceFiveRayObstructionInActiveWindow         ; $01E68A
        movem.l      (a7)+, d5-d6/a0-a1/a5                         ; $01E68E
        bne.w        loc_01E69A                                    ; $01E692
        bra.w        loc_01E6E0                                    ; $01E696

loc_01E69A:
        move.w       $24(a1), d0                                   ; $01E69A
        sub.w        $24(a0), d0                                   ; $01E69E
        move.w       $26(a1), d1                                   ; $01E6A2
        sub.w        $26(a0), d1                                   ; $01E6A6
        jsr          OctagonalDistance.l                           ; $01E6AA
        move.w       d0, d6                                        ; $01E6B0
        move.w       rPlayerX(a6), d0                              ; $01E6B2
        sub.w        $24(a0), d0                                   ; $01E6B6
        move.w       rPlayerY(a6), d1                              ; $01E6BA
        sub.w        $26(a0), d1                                   ; $01E6BE
        jsr          OctagonalDistance.l                           ; $01E6C2
        cmp.w        d0, d6                                        ; $01E6C8
        bcs.b        loc_01E6E6                                    ; $01E6CA
        bra.b        loc_01E6E0                                    ; $01E6CC

loc_01E6CE:
        movea.l      #$0, a1                                       ; $01E6CE
        rts                                                        ; $01E6D4

loc_01E6D6:
        move.w       rCurrentFloor(a6), d0                         ; $01E6D6
        cmp.b        $36(a0), d0                                   ; $01E6DA
        bne.b        loc_01E6CE                                    ; $01E6DE

loc_01E6E0:
        lea.l        rPlayerActorProxy(a6), a1                     ; $01E6E0
        rts                                                        ; $01E6E4

loc_01E6E6:
        movea.l      rActiveActorHead(a6), a1                      ; $01E6E6
        rts                                                        ; $01E6EA
        ifne *-$1E6EC
        fail "ROM end moved"
        endif
