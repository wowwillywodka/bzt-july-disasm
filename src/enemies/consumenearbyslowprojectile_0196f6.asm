; $0196F6..$019761 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Called from $E30C player movement: remove FIRST listed actor with update$1CBEE at distance<=$32; set PlayerMovementSlowCounter=70. No floor/owner/LOS check, no direct HP callback. Shared projectile update also used by player weapon.
        ifne *-$196F6
        fail "ROM start moved"
        endif

ConsumeNearbySlowProjectile:
; Called from $E30C player movement: remove FIRST listed actor with update$1CBEE at distance<=$32; set PlayerMovementSlowCounter=70. No floor/owner/LOS check, no direct HP callback. Shared projectile update also used by player weapon.
        movem.l      d0-d4/a0-a6, -(a7)                            ; $0196F6
        clr.w        d0                                            ; $0196FA
        clr.w        d1                                            ; $0196FC
        clr.w        d2                                            ; $0196FE
        clr.w        d5                                            ; $019700
        move.w       rActiveActorCount(a6), d7                     ; $019702
        bne.b        loc_01970E                                    ; $019706
        movem.l      (a7)+, d0-d4/a0-a6                            ; $019708
        rts                                                        ; $01970C

loc_01970E:
        subq.w       #$1, d7                                       ; $01970E
        movea.l      rActiveActorHead(a6), a1                      ; $019710

loc_019714:
        move.l       (a1), -(a7)                                   ; $019714
        cmpi.l       #$1cbee, $16(a1)                              ; $019716
        bne.b        loc_01973E                                    ; $01971E
        move.w       $24(a1), d0                                   ; $019720
        sub.w        rPlayerX(a6), d0                              ; $019724
        move.w       $26(a1), d1                                   ; $019728
        sub.w        rPlayerY(a6), d1                              ; $01972C
        jsr          OctagonalDistance.l                           ; $019730
        cmpi.w       #$32, d0                                      ; $019736
        bls.w        loc_01974A                                    ; $01973A

loc_01973E:
        movea.l      (a7)+, a1                                     ; $01973E
        dbra         d7, loc_019714                                ; $019740
        movem.l      (a7)+, d0-d4/a0-a6                            ; $019744
        rts                                                        ; $019748

loc_01974A:
        move.l       a1, -(a7)                                     ; $01974A
        movea.l      (a7)+, a0                                     ; $01974C
        jsr          RemoveActor.l                                 ; $01974E
; 70 is a byte movement-slow counter, not a boolean. Five accepted-motion paths decrement it and ASR3 movement components; not necessarily70 video frames.
        move.b       #$46, rPlayerMovementSlowCounter(a6)          ; $019754
        movea.l      (a7)+, a1                                     ; $01975A
        movem.l      (a7)+, d0-d4/a0-a6                            ; $01975C
        rts                                                        ; $019760
        ifne *-$19762
        fail "ROM end moved"
        endif
