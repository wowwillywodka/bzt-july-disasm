; $2B951E..$2B956F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed 82-byte retained 68000 block after demo records. Boot-table loads, ROM word sum, call DrawMissionStatistics, then permanent loop. No ordinary caller established; do not enable. See docs/CODE_DATA_BOUNDARIES.md.
        ifne *-$2B951E
        fail "ROM start moved"
        endif

RetainedRomChecksumAndStatsLoop:
; Reviewed 82-byte retained 68000 block after demo records. Boot-table loads, ROM word sum, call DrawMissionStatistics, then permanent loop. No ordinary caller established; do not enable. See docs/CODE_DATA_BOUNDARIES.md.
        lea.l        BootHardwareTables.w, a5                      ; $2B951E
        movem.w      (a5)+, d5-d7                                  ; $2B9522
        movem.l      (a5)+, a0-a4                                  ; $2B9526
        move.l       #$53454741, $2f00(a1)                         ; $2B952A
; Reads original header ROM-end long at $1A4 ($001FFFFF), not actual July file length $300000.
        lea.l        Data_0001A4.w, a0                             ; $2B9532
        move.l       (a0), d1                                      ; $2B9536
        addq.l       #$1, d1                                       ; $2B9538
        movea.l      #ResetEntry, a0                               ; $2B953A
        sub.l        a0, d1                                        ; $2B9540
        asr.l        #$1, d1                                       ; $2B9542
        move.w       d1, d2                                        ; $2B9544
        subq.w       #$1, d2                                       ; $2B9546
        swap         d1                                            ; $2B9548
        moveq        #$0, d0                                       ; $2B954A

loc_2B954C:
; Accumulate words from $000200 through $1FFFFF into D0.w. No comparison with checksum header is present.
        add.w        (a0)+, d0                                     ; $2B954C
        dbra         d2, loc_2B954C                                ; $2B954E
        dbra         d1, loc_2B954C                                ; $2B9552
; Seven original NOPs are preserved; no historical patch purpose inferred.
        nop                                                        ; $2B9556
        nop                                                        ; $2B9558
        nop                                                        ; $2B955A
        nop                                                        ; $2B955C
        nop                                                        ; $2B955E
        nop                                                        ; $2B9560
        nop                                                        ; $2B9562
; Direct call into known July DrawMissionStatistics; returns to two NOPs and an infinite BRA loop.
        jsr          DrawMissionStatistics.l                       ; $2B9564

loc_2B956A:
        nop                                                        ; $2B956A
        nop                                                        ; $2B956C
        bra.b        loc_2B956A                                    ; $2B956E
        ifne *-$2B9570
        fail "ROM end moved"
        endif
