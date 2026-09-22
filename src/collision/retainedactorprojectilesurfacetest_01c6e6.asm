; $01C6E6..$01C76B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained body after $1C6E4 RTS. Tests raw cell code by $FF2A66 and ActorZ. No decoded external literal reference into this body found.
        ifne *-$1C6E6
        fail "ROM start moved"
        endif

RetainedActorProjectileSurfaceTest:
; Retained body after $1C6E4 RTS. Tests raw cell code by $FF2A66 and ActorZ. No decoded external literal reference into this body found.
        movem.l      d0-d1/a1, -(a7)                               ; $01C6E6
        bsr.w        GetVisibleMapBase                             ; $01C6EA
        asr.w        #$8, d0                                       ; $01C6EE
        adda.w       d0, a1                                        ; $01C6F0
        clr.b        d1                                            ; $01C6F2
        asr.w        #$3, d1                                       ; $01C6F4
        adda.w       d1, a1                                        ; $01C6F6
        clr.w        d3                                            ; $01C6F8
        move.b       (a1), d3                                      ; $01C6FA
        move.w       rLegacyEpisodeSelection(a6), d0               ; $01C6FC
        beq.b        loc_01C71A                                    ; $01C700
        subq.w       #$1, d0                                       ; $01C702
        beq.b        loc_01C73A                                    ; $01C704

loc_01C706:
        movem.l      (a7)+, d0-d1/a1                               ; $01C706
        move.w       #$0, d3                                       ; $01C70A
        rts                                                        ; $01C70E

loc_01C710:
        movem.l      (a7)+, d0-d1/a1                               ; $01C710
        move.w       #$1, d3                                       ; $01C714
        rts                                                        ; $01C718

loc_01C71A:
        cmpi.b       #$1, d3                                       ; $01C71A
        beq.b        loc_01C710                                    ; $01C71E
        cmpi.b       #$6e, d3                                      ; $01C720
        beq.b        loc_01C710                                    ; $01C724
        cmpi.b       #$6f, d3                                      ; $01C726
        beq.b        loc_01C710                                    ; $01C72A
        cmpi.b       #$91, d3                                      ; $01C72C
        bcs.b        loc_01C706                                    ; $01C730
        cmpi.b       #$96, d3                                      ; $01C732
        bhi.b        loc_01C706                                    ; $01C736
        bra.b        loc_01C710                                    ; $01C738

loc_01C73A:
        cmpi.b       #$1, d3                                       ; $01C73A
        beq.b        loc_01C710                                    ; $01C73E
        cmpi.b       #$8f, d3                                      ; $01C740
        beq.b        loc_01C710                                    ; $01C744
        cmpi.b       #$a3, d3                                      ; $01C746
        beq.b        loc_01C710                                    ; $01C74A
        tst.w        ActorZ(a0)                                    ; $01C74C
        bmi.b        loc_01C706                                    ; $01C750
        cmpi.b       #$3, d3                                       ; $01C752
        beq.b        loc_01C710                                    ; $01C756
        cmpi.b       #$a2, d3                                      ; $01C758
        beq.b        loc_01C710                                    ; $01C75C
        cmpi.b       #$6, d3                                       ; $01C75E
        bcs.b        loc_01C706                                    ; $01C762
        cmpi.b       #$8, d3                                       ; $01C764
        bls.b        loc_01C710                                    ; $01C768
        bra.b        loc_01C706                                    ; $01C76A
        ifne *-$1C76C
        fail "ROM end moved"
        endif
