; $07F4FC..$07F4FD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Immediate RTS disables ordinary briefing/death text calls. Retained body begins at $07F4FE and is not reached by falling through this entry.
        ifne *-$7F4FC
        fail "ROM start moved"
        endif

DisabledBriefingEntry:
; The original July ROM returns immediately. The following briefing body is retained but bypassed.
; Immediate RTS disables ordinary briefing/death text calls. Retained body begins at $07F4FE and is not reached by falling through this entry.
        rts                                                        ; $07F4FC
        ifne *-$7F4FE
        fail "ROM end moved"
        endif
