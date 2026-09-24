; $07B4C4..$07B4FD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        ifne *-$7B4C4
        fail "ROM start moved"
        endif

UploadDeceasedStamp:
; Character-selection UI helper (five portraits/biographies), not a geometry-episode selector. See docs/GAME_FLOW.md.
        lea.l        DeceasedStampTilemap.l, a0          ; $07B4C4
        cmpi.w       #$e102, $ff2a4c.l                             ; $07B4CA
        beq.w        loc_07B4E0                                    ; $07B4D2
        movea.l      #$d000, a1                                    ; $07B4D6
        bra.w        loc_07B4E6                                    ; $07B4DC

loc_07B4E0:
        movea.l      #$c000, a1                                    ; $07B4E0

loc_07B4E6:
        move.w       #$28, d0                                      ; $07B4E6
        move.w       #$1c, d1                                      ; $07B4EA
        move.w       #$40, d2                                      ; $07B4EE
        move.w       #$43a2, d3                                    ; $07B4F2
        jsr          UploadAttributedTilemap.l                     ; $07B4F6
        rts                                                        ; $07B4FC
        ifne *-$7B4FE
        fail "ROM end moved"
        endif
