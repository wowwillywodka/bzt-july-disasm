; $01C65A..$01C6DF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained body after disabled entry RTS. Uses VisibleMapBasePointer and RAW cell bytes, branch by RAM $FF2A66 and player scene height; not current active projectile geometry.
        ifne *-$1C65A
        fail "ROM start moved"
        endif

RetainedPlayerProjectileSurfaceTest:
; Retained body after disabled entry RTS. Uses VisibleMapBasePointer and RAW cell bytes, branch by RAM $FF2A66 and player scene height; not current active projectile geometry.
        movem.l      d0-d1/a1, -(a7)                               ; $01C65A
        movea.l      rVisibleMapBasePointer(a6), a1                ; $01C65E
        asr.w        #$8, d0                                       ; $01C662
        adda.w       d0, a1                                        ; $01C664
        clr.b        d1                                            ; $01C666
        asr.w        #$3, d1                                       ; $01C668
        adda.w       d1, a1                                        ; $01C66A
        clr.w        d3                                            ; $01C66C
        move.b       (a1), d3                                      ; $01C66E
        move.w       rLegacyEpisodeSelection(a6), d0               ; $01C670
        beq.b        loc_01C68E                                    ; $01C674
        subq.w       #$1, d0                                       ; $01C676
        beq.b        loc_01C6AE                                    ; $01C678

loc_01C67A:
        movem.l      (a7)+, d0-d1/a1                               ; $01C67A
        move.w       #$0, d3                                       ; $01C67E
        rts                                                        ; $01C682

loc_01C684:
        movem.l      (a7)+, d0-d1/a1                               ; $01C684
        move.w       #$1, d3                                       ; $01C688
        rts                                                        ; $01C68C

loc_01C68E:
        cmpi.b       #$1, d3                                       ; $01C68E
        beq.b        loc_01C684                                    ; $01C692
        cmpi.b       #$6e, d3                                      ; $01C694
        beq.b        loc_01C684                                    ; $01C698
        cmpi.b       #$6f, d3                                      ; $01C69A
        beq.b        loc_01C684                                    ; $01C69E
        cmpi.b       #$91, d3                                      ; $01C6A0
        bcs.b        loc_01C67A                                    ; $01C6A4
        cmpi.b       #$96, d3                                      ; $01C6A6
        bhi.b        loc_01C67A                                    ; $01C6AA
        bra.b        loc_01C684                                    ; $01C6AC

loc_01C6AE:
        cmpi.b       #$1, d3                                       ; $01C6AE
        beq.b        loc_01C684                                    ; $01C6B2
        cmpi.b       #$8f, d3                                      ; $01C6B4
        beq.b        loc_01C684                                    ; $01C6B8
        cmpi.b       #$a3, d3                                      ; $01C6BA
        beq.b        loc_01C684                                    ; $01C6BE
        tst.w        -$71d8(a6)                                    ; $01C6C0
        bmi.b        loc_01C67A                                    ; $01C6C4
        cmpi.b       #$3, d3                                       ; $01C6C6
        beq.b        loc_01C684                                    ; $01C6CA
        cmpi.b       #$a2, d3                                      ; $01C6CC
        beq.b        loc_01C684                                    ; $01C6D0
        cmpi.b       #$6, d3                                       ; $01C6D2
        bcs.b        loc_01C67A                                    ; $01C6D6
        cmpi.b       #$8, d3                                       ; $01C6D8
        bls.b        loc_01C684                                    ; $01C6DC
        bra.b        loc_01C67A                                    ; $01C6DE
        ifne *-$1C6E0
        fail "ROM end moved"
        endif
