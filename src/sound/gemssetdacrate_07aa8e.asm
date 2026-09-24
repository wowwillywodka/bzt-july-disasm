; $07AA8E..$07AA97 | m68k
; Maintained assembly input; no extraction occurs during build.
; Z80 host command $1A: (channel, DAC rate). Z80 applies the rate only
; when that channel's current patch is a DAC patch (type 1).
        ifne *-$7AA8E
        fail "ROM start moved"
        endif

GemsSetDacRate:
        jsr          BeginGemsCommand(pc)                          ; $07AA8E
        moveq        #$1a, d0                                      ; $07AA92
        bra.w        WriteGemsTwoArgumentCommand                                    ; $07AA94
        ifne *-$7AA98
        fail "ROM end moved"
        endif
