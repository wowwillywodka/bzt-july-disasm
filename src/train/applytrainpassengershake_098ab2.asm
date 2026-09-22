; $098AB2..$098AE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Every call shifts player X or Y by +/-2 fixed-point units from animation-tick bit 2. It does not run only every fourth frame; no centering/clamping here.
        ifne *-$98AB2
        fail "ROM start moved"
        endif

ApplyTrainPassengerShake:
; Every call shifts player X or Y by +/-2 fixed-point units from animation-tick bit 2. It does not run only every fourth frame; no centering/clamping here.
        move.w       rGameTick(a6), d0                             ; $098AB2
        andi.w       #$4, d0                                       ; $098AB6
        cmpi.b       #$1, TrainOrientation(a0)                     ; $098ABA
        beq.b        loc_098ADA                                    ; $098AC0
        cmpi.b       #$2, TrainOrientation(a0)                     ; $098AC2
        beq.b        loc_098ADA                                    ; $098AC8
        tst.w        d0                                            ; $098ACA
        beq.b        loc_098AD4                                    ; $098ACC
        addq.w       #$2, rPlayerX(a6)                             ; $098ACE
        rts                                                        ; $098AD2

loc_098AD4:
        subq.w       #$2, rPlayerX(a6)                             ; $098AD4
        rts                                                        ; $098AD8

loc_098ADA:
        tst.w        d0                                            ; $098ADA
        beq.b        loc_098AE4                                    ; $098ADC
        addq.w       #$2, rPlayerY(a6)                             ; $098ADE
        rts                                                        ; $098AE2

loc_098AE4:
        subq.w       #$2, rPlayerY(a6)                             ; $098AE4
        rts                                                        ; $098AE8
        ifne *-$98AEA
        fail "ROM end moved"
        endif
