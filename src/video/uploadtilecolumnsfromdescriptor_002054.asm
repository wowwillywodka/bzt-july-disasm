; $002054..$002063 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2054
        fail "ROM start moved"
        endif

UploadTileColumnsFromDescriptor:
        movea.l      a0, a1                                        ; $002054
        addq.w       #$8, a1                                       ; $002056
        move.w       d0, d4                                        ; $002058
        lsr.w        #$5, d4                                       ; $00205A
        add.w        d3, d4                                        ; $00205C
        move.w       $6(a0), d7                                    ; $00205E
        subq.w       #$1, d7                                       ; $002062
        ifne *-$2064
        fail "ROM end moved"
        endif
