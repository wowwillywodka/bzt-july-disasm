; $07B552..$07B5BF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B552
        fail "ROM start moved"
        endif

PrintCharacterMenuText:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        movea.l      #VDP_DATA, a4                                 ; $07B552
        lea.l        CharacterMenuGlyphPairs(pc), a1               ; $07B558
        move.w       d0, -(a7)                                     ; $07B55C
        move.l       a0, -(a7)                                     ; $07B55E
        move.w       d0, d1                                        ; $07B560
        andi.w       #$3fff, d1                                    ; $07B562
        ori.w        #$4000, d1                                    ; $07B566
        swap         d1                                            ; $07B56A
        lsr.w        #$8, d0                                       ; $07B56C
        lsr.w        #$6, d0                                       ; $07B56E
        move.w       d0, d1                                        ; $07B570
        move.l       d1, VDP_CONTROL.l                             ; $07B572

loc_07B578:
        clr.w        d0                                            ; $07B578
        move.b       (a0)+, d0                                     ; $07B57A
        beq.b        loc_07B58A                                    ; $07B57C
        subi.w       #$20, d0                                      ; $07B57E
        lsl.w        #$2, d0                                       ; $07B582
        move.w       (a1, d0.w), (a4)                              ; $07B584
        bra.b        loc_07B578                                    ; $07B588

loc_07B58A:
        addq.w       #$2, a1                                       ; $07B58A
        movea.l      (a7)+, a0                                     ; $07B58C
        move.w       (a7)+, d0                                     ; $07B58E
        addi.w       #$80, d0                                      ; $07B590
        move.w       d0, d1                                        ; $07B594
        andi.w       #$3fff, d1                                    ; $07B596
        ori.w        #$4000, d1                                    ; $07B59A
        swap         d1                                            ; $07B59E
        lsr.w        #$8, d0                                       ; $07B5A0
        lsr.w        #$6, d0                                       ; $07B5A2
        move.w       d0, d1                                        ; $07B5A4
        move.l       d1, VDP_CONTROL.l                             ; $07B5A6

loc_07B5AC:
        clr.w        d0                                            ; $07B5AC
        move.b       (a0)+, d0                                     ; $07B5AE
        beq.b        loc_07B5BE                                    ; $07B5B0
        subi.w       #$20, d0                                      ; $07B5B2
        lsl.w        #$2, d0                                       ; $07B5B6
        move.w       (a1, d0.w), (a4)                              ; $07B5B8
        bra.b        loc_07B5AC                                    ; $07B5BC

loc_07B5BE:
        rts                                                        ; $07B5BE
        ifne *-$7B5C0
        fail "ROM end moved"
        endif
