; $029BCA..$029BD5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: XOR one buffer byte with the low key byte, then update
; the fixed rolling key by ROR.L #7 and SWAP. A1 advances to the next byte.
        ifne *-$29BCA
        fail "ROM start moved"
        endif

DecodePasswordXorByte:
        move.b       (a1), d0                                      ; $029BCA
        eor.b        d3, d0                                        ; $029BCC
        ror.l        #$7, d3                                       ; $029BCE
        swap         d3                                            ; $029BD0
        move.b       d0, (a1)+                                     ; $029BD2
        rts                                                        ; $029BD4
        ifne *-$29BD6
        fail "ROM end moved"
        endif
