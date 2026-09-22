; $07A71C..$07A73D | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; ИНИЦ. музыки GEMS July: push 4 банков (patches 0x2BCFC, env 0x2C5B8, seq 0x2C5C4, samples 0x2E8D4) → Z80-драйвер (аналог ZT c5b38)
        ifne *-$7A71C
        fail "ROM start moved"
        endif

InitializeGems:
        move.l       #GemsSampleDescriptors, -(a7)                 ; $07A71C
        move.l       #GemsSequenceBank, -(a7)                      ; $07A722
        move.l       #GemsEnvelopeBank, -(a7)                      ; $07A728
        move.l       #GemsPatchBank, -(a7)                         ; $07A72E
        bsr.w        InitializeGemsBanks                           ; $07A734
        adda.w       #$10, a7                                      ; $07A738
        rts                                                        ; $07A73C
        ifne *-$7A73E
        fail "ROM end moved"
        endif
