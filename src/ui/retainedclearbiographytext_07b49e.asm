; $07B49E..$07B4C3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7B49E
        fail "ROM start moved"
        endif

RetainedClearBiographyText:
        lea.l        CharacterMenuBlankText.l, a0                  ; $07B49E
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B4A4
        beq.w        loc_07B4B8                                    ; $07B4AC
        move.w       #$fb82, d0                                    ; $07B4B0
        bra.w        loc_07B4BC                                    ; $07B4B4

loc_07B4B8:
        move.w       #$eb82, d0                                    ; $07B4B8

loc_07B4BC:
        jsr          PrintCharacterMenuText.l                      ; $07B4BC
        rts                                                        ; $07B4C2
        ifne *-$7B4C4
        fail "ROM end moved"
        endif
