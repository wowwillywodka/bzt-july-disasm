; $0290DC..$029111 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: copies label 29112/2912B and RAM password; ends RTS
        ifne *-$290DC
        fail "ROM start moved"
        endif

RetainedFormatEpisodePasswordLine:
        lea.l        EpisodePasswordLabels(pc), a1                 ; $0290DC
        cmpi.w       #$1, rLegacyEpisodeSelection(a6)              ; $0290E0
        beq.b        loc_0290EC                                    ; $0290E6
        lea.l        Data_02912B(pc), a1                           ; $0290E8

loc_0290EC:
        tst.b        (a1)                                          ; $0290EC
        beq.b        loc_0290F4                                    ; $0290EE
        move.b       (a1)+, (a0)+                                  ; $0290F0
        bra.b        loc_0290EC                                    ; $0290F2

loc_0290F4:
        lea.l        -$5584(a6), a1                                ; $0290F4
        move.w       #$8, d2                                       ; $0290F8

loc_0290FC:
        move.b       (a1)+, (a0)+                                  ; $0290FC
        dbra         d2, loc_0290FC                                ; $0290FE
        move.w       #$3, d2                                       ; $029102
        bmi.b        loc_029110                                    ; $029106

loc_029108:
        move.b       #$20, (a0)+                                   ; $029108
        dbra         d2, loc_029108                                ; $02910C

loc_029110:
        rts                                                        ; $029110
        ifne *-$29112
        fail "ROM end moved"
        endif
