; $0078BC..$007903 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Fill the zero-depth columns of the 128x80 software viewport from the two
; 80-byte scene background columns. Four interleaved columns are visited in
; each of 32 groups; nonzero depth words preserve existing viewport pixels.
; See docs/VISIBLE_RAY_PIPELINE.md.
        ifne *-$78BC
        fail "ROM start moved"
        endif

ComposeColumnBlocks:
        lea.l        rSoftwareFrameBuffer(a6), a0                                ; $0078BC
        lea.l        rScreenColumnDepthWords(a6), a4                                  ; $0078C0
        move.w       #SoftwareFrameColumnCount/4-1, d1             ; $0078C4
        lea.l        rSceneBackgroundColumns(a6), a5                                  ; $0078C8

loc_0078CC:
        lea.l        SceneBackgroundColumnBytes(a5), a5           ; $0078CC
        tst.w        (a4)+                                         ; $0078D0
        bne.b        loc_0078D6                                    ; $0078D2
        bsr.b        CopyBackgroundColumn80                          ; $0078D4

loc_0078D6:
        addq.w       #$1, a0                                       ; $0078D6
        lea.l        -SceneBackgroundColumnBytes(a5), a5          ; $0078D8
        tst.w        (a4)+                                         ; $0078DC
        bne.b        loc_0078E2                                    ; $0078DE
        bsr.b        CopyBackgroundColumn80                          ; $0078E0

loc_0078E2:
        addq.w       #$1, a0                                       ; $0078E2
        lea.l        SceneBackgroundColumnBytes(a5), a5           ; $0078E4
        tst.w        (a4)+                                         ; $0078E8
        bne.b        loc_0078EE                                    ; $0078EA
        bsr.b        CopyBackgroundColumn80                          ; $0078EC

loc_0078EE:
        addq.w       #$1, a0                                       ; $0078EE
        lea.l        -SceneBackgroundColumnBytes(a5), a5          ; $0078F0
        tst.w        (a4)+                                         ; $0078F4
        bne.b        loc_0078FA                                    ; $0078F6
        bsr.b        CopyBackgroundColumn80                          ; $0078F8

loc_0078FA:
        adda.w       #SoftwareFrameColumnSpan-3, a0               ; $0078FA
        dbra         d1, loc_0078CC                                ; $0078FE
        rts                                                        ; $007902
        ifne *-$7904
        fail "ROM end moved"
        endif
