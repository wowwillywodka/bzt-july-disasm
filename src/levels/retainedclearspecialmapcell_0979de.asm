; $0979DE..$0979F5 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$979DE
        fail "ROM start moved"
        endif

RetainedClearSpecialMapCell:
        cmpi.b       #$8c, (a0)                                    ; $0979DE
        bne.b        loc_0979EE                                    ; $0979E2
        move.b       #$0, (a0)                                     ; $0979E4
        jsr          CommitMapCellAndSendLink.l                    ; $0979E8

loc_0979EE:
        move.w       #$1, rWallOpeningPermit(a6)                   ; $0979EE
        rts                                                        ; $0979F4
        ifne *-$979F6
        fail "ROM end moved"
        endif
