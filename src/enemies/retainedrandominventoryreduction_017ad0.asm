; $017AD0..$017B4F | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$17AD0
        fail "ROM start moved"
        endif

RetainedRandomInventoryReduction:
        movem.l      d0-d6/a0-a6, -(a7)                            ; $017AD0
        st.b         d7                                            ; $017AD4
        jsr          NextRandom.w                                  ; $017AD6
        asr.l        #$8, d2                                       ; $017ADA
        andi.w       #$7, d2                                       ; $017ADC
        move.w       d2, d3                                        ; $017AE0
        cmpi.w       #$4, d3                                       ; $017AE2
        ble.b        loc_017AFA                                    ; $017AE6

loc_017AE8:
        jsr          NextRandom.w                                  ; $017AE8
        asr.l        #$8, d2                                       ; $017AEC
        andi.w       #$3, d2                                       ; $017AEE
        sub.w        d2, d3                                        ; $017AF2
        cmpi.w       #$4, d3                                       ; $017AF4
        bgt.b        loc_017AE8                                    ; $017AF8

loc_017AFA:
        move.w       d3, d2                                        ; $017AFA
        move.w       d3, d1                                        ; $017AFC
        lea.l        rInventorySlots(a6), a0                       ; $017AFE
        mulu.w       #$4, d3                                       ; $017B02

loc_017B06:
        tst.w        (a0, d3.w)                                    ; $017B06
        bne.b        loc_017B20                                    ; $017B0A

loc_017B0C:
        addq.w       #$4, d3                                       ; $017B0C
        addq.w       #$1, d2                                       ; $017B0E
        cmp.w        d2, d1                                        ; $017B10
        beq.b        loc_017B4A                                    ; $017B12
        cmpi.w       #$5, d2                                       ; $017B14
        bne.b        loc_017B06                                    ; $017B18
        clr.w        d2                                            ; $017B1A
        clr.w        d3                                            ; $017B1C
        bra.b        loc_017B06                                    ; $017B1E

loc_017B20:
        cmpi.b       #$1, $2(a0)                                   ; $017B20
        beq.b        loc_017B0C                                    ; $017B26
        move.w       $2(a0), d0                                    ; $017B28
        lsr.w        #$8, d0                                       ; $017B2C
        cmpi.w       #$1, d0                                       ; $017B2E
        beq.b        loc_017B4A                                    ; $017B32
        lsr.w        #$2, d0                                       ; $017B34
        tst.w        d0                                            ; $017B36
        bne.b        loc_017B3E                                    ; $017B38
        move.w       #$1, d0                                       ; $017B3A

loc_017B3E:
        lsl.w        #$8, d0                                       ; $017B3E
        sub.w        d0, $2(a0)                                    ; $017B40
        bsr.w        UploadInventorySlotIconsToVram                           ; $017B44
        clr.w        d7                                            ; $017B48

loc_017B4A:
        movem.l      (a7)+, d0-d6/a0-a6                            ; $017B4A
        rts                                                        ; $017B4E
        ifne *-$17B50
        fail "ROM end moved"
        endif
