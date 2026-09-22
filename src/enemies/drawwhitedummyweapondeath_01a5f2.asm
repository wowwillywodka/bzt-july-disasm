; $01A5F2..$01A669 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Active weapon-death draw: counters7/6 ->2/1; 5/4 ->5/1; 3 ->5/2; 2/1 ->5/3. Bank animation5 has last frame1: requests2/3 fall back to frame0 in renderer.
        ifne *-$1A5F2
        fail "ROM start moved"
        endif

DrawWhiteDummyWeaponDeath:
; Active weapon-death draw: counters7/6 ->2/1; 5/4 ->5/1; 3 ->5/2; 2/1 ->5/3. Bank animation5 has last frame1: requests2/3 fall back to frame0 in renderer.
        move.b       ActorStateCounter(a0), d7                     ; $01A5F2
        cmpi.b       #$7, d7                                       ; $01A5F6
        beq.b        loc_01A622                                    ; $01A5FA
        cmpi.b       #$6, d7                                       ; $01A5FC
        beq.b        loc_01A622                                    ; $01A600
        cmpi.b       #$5, d7                                       ; $01A602
        beq.b        loc_01A630                                    ; $01A606
        cmpi.b       #$4, d7                                       ; $01A608
        beq.b        loc_01A630                                    ; $01A60C
        cmpi.b       #$3, d7                                       ; $01A60E
        beq.b        loc_01A63E                                    ; $01A612
        cmpi.b       #$2, d7                                       ; $01A614
        beq.b        loc_01A64C                                    ; $01A618
        cmpi.b       #$1, d7                                       ; $01A61A
        beq.b        loc_01A65A                                    ; $01A61E
        rts                                                        ; $01A620

loc_01A622:
        move.w       #$2, d0                                       ; $01A622
        move.w       #$1, d2                                       ; $01A626
        jmp          DrawActorAnimation.l                          ; $01A62A

loc_01A630:
        move.w       #$5, d0                                       ; $01A630
        move.w       #$1, d2                                       ; $01A634
        jmp          DrawActorAnimation.l                          ; $01A638

loc_01A63E:
        move.w       #$5, d0                                       ; $01A63E
        move.w       #$2, d2                                       ; $01A642
        jmp          DrawActorAnimation.l                          ; $01A646

loc_01A64C:
        move.w       #$5, d0                                       ; $01A64C
        move.w       #$3, d2                                       ; $01A650
        jmp          DrawActorAnimation.l                          ; $01A654

loc_01A65A:
        move.w       #$5, d0                                       ; $01A65A
        move.w       #$3, d2                                       ; $01A65E
        jmp          DrawActorAnimation.l                          ; $01A662

WhiteDummySkipStateSixDrawing:
        rts                                                        ; $01A668
        ifne *-$1A66A
        fail "ROM end moved"
        endif
