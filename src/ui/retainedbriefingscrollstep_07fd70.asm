; $07FD70..$07FD9B | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7FD70
        fail "ROM start moved"
        endif

RetainedBriefingScrollStep:
        subq.w       #$1, $ff2a4e.l                                ; $07FD70
        move.w       $ff2a4e.l, d5                                 ; $07FD76
        move.w       d5, d0                                        ; $07FD7C
        jsr          WriteVerticalScrollToVsram.l                         ; $07FD7E
        rts                                                        ; $07FD84

; Reviewed call entry (internal-helper): Increments briefing vertical-scroll word and writes it to VSRAM.
AdvanceRetainedBriefingScroll:
        addq.w       #$1, $ff2a4e.l                                ; $07FD86
        move.w       $ff2a4e.l, d5                                 ; $07FD8C
        move.w       d5, d0                                        ; $07FD92
        jsr          WriteVerticalScrollToVsram.l                         ; $07FD94
        rts                                                        ; $07FD9A
        ifne *-$7FD9C
        fail "ROM end moved"
        endif
