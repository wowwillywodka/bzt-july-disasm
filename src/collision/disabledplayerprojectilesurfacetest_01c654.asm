; $01C654..$01C659 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Always D3.w=0/Z=1 then RTS. The original player-height/zone surface test below is retained but skipped.
        ifne *-$1C654
        fail "ROM start moved"
        endif

DisabledPlayerProjectileSurfaceTest:
; Always D3.w=0/Z=1 then RTS. The original player-height/zone surface test below is retained but skipped.
        move.w       #$0, d3                                       ; $01C654
        rts                                                        ; $01C658
        ifne *-$1C65A
        fail "ROM end moved"
        endif
