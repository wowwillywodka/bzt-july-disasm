; $002104..$002113 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$2104
        fail "ROM start moved"
        endif

UploadTilemapColumnsFromDescriptor:
        movea.l      a0, a1                                        ; $002104
        addq.w       #$8, a1                                       ; $002106
        move.w       d0, d4                                        ; $002108
        lsr.w        #$5, d4                                       ; $00210A
        add.w        d3, d4                                        ; $00210C
        move.w       $6(a0), d7                                    ; $00210E
        subq.w       #$1, d7                                       ; $002112
        ifne *-$2114
        fail "ROM end moved"
        endif
