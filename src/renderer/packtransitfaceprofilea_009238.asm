; $009238..$009257 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 9098] профили ct 0x12,0x14 (лестн. площадки)
        ifne *-$9238
        fail "ROM start moved"
        endif

PackTransitFaceProfileA:
        tst.w        d1                                            ; $009238
        bpl.b        loc_009254                                    ; $00923A
        move.b       d0, d3                                        ; $00923C
        lsl.w        #$8, d3                                       ; $00923E
        move.b       d1, d3                                        ; $009240
        addq.b       #$1, d3                                       ; $009242
        swap         d3                                            ; $009244
        move.b       d0, d3                                        ; $009246
        addq.b       #$1, d3                                       ; $009248
        lsl.w        #$8, d3                                       ; $00924A
        move.b       d1, d3                                        ; $00924C
        addq.b       #$1, d3                                       ; $00924E
        bsr.w        EnemiesRoutine_0096CC                         ; $009250

loc_009254:
        clr.w        d3                                            ; $009254
        rts                                                        ; $009256
        ifne *-$9258
        fail "ROM end moved"
        endif
