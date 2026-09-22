; $098C32..$098C75 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Depth-first expansion: save right symbol, recurse left then right; cyclic dictionaries have no native guard.
        ifne *-$98C32
        fail "ROM start moved"
        endif

ExpandBytePairToVramLong:
; Depth-first expansion: save right symbol, recurse left then right; cyclic dictionaries have no native guard.
        movem.w      d2, -(a7)                                     ; $098C32
        moveq        #$0, d1                                       ; $098C36
        move.b       (a0, d0.w), d1                                ; $098C38
        beq.w        loc_098C58                                    ; $098C3C
        move.b       (a2, d0.w), d2                                ; $098C40
        move.b       (a1, d0.w), d0                                ; $098C44
        jsr          ExpandBytePairToVramLong(pc)                  ; $098C48
        move.b       d2, d0                                        ; $098C4C
        jsr          ExpandBytePairToVramLong(pc)                  ; $098C4E
        movem.w      (a7)+, d2                                     ; $098C52
        rts                                                        ; $098C56

loc_098C58:
        asl.l        #$8, d3                                       ; $098C58
        bcc.w        loc_098C6E                                    ; $098C5A
        move.b       d0, d3                                        ; $098C5E
        move.l       d3, VDP_DATA.l                                ; $098C60
        moveq        #$1, d3                                       ; $098C66
        movem.w      (a7)+, d2                                     ; $098C68
        rts                                                        ; $098C6C

loc_098C6E:
        move.b       d0, d3                                        ; $098C6E
        movem.w      (a7)+, d2                                     ; $098C70
        rts                                                        ; $098C74
        ifne *-$98C76
        fail "ROM end moved"
        endif
