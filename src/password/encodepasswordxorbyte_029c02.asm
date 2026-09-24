; $029C02..$029C0D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Same reversible XOR step as DecodePasswordXorByte,
; operating on the seven-byte encoded buffer through A2. This is a fixed
; rotating key, not an LFSR.
        ifne *-$29C02
        fail "ROM start moved"
        endif

EncodePasswordXorByte:
        move.b       (a2), d0                                      ; $029C02
        eor.b        d3, d0                                        ; $029C04
        ror.l        #$7, d3                                       ; $029C06
        swap         d3                                            ; $029C08
        move.b       d0, (a2)+                                     ; $029C0A
        rts                                                        ; $029C0C
        ifne *-$29C0E
        fail "ROM end moved"
        endif
