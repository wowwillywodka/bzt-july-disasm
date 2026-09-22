; $07F4E0..$07F4FB | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7F4E0
        fail "ROM start moved"
        endif

RetainedBriefingTestLoop:
        move.w       #$5, d0                                       ; $07F4E0
        movea.l      #$7f4fa, a1                                   ; $07F4E4
        move.w       #$2, ramLegacyEpisodeSelection.l              ; $07F4EA
        jsr          DisabledBriefingEntry.l                       ; $07F4F2
        bra.b        RetainedBriefingTestLoop                      ; $07F4F8
        rts                                                        ; $07F4FA
        ifne *-$7F4FC
        fail "ROM end moved"
        endif
