; $000804..$0008F7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Если флаг (-0x7FE8,A6) установлен — jsr к опросу пада, ставит A1=$A10003 (порт1) и A0=(-0x7FD2,A6), копирует слово состояния в (-0x7FCE,A6)
        ifne *-$804
        fail "ROM start moved"
        endif

ReadController:
        tst.b        rControllerPresent(a6)                        ; $000804
        bne.b        loc_00080C                                    ; $000808
        rts                                                        ; $00080A

loc_00080C:
        jsr          AcquireZ80Bus.l                               ; $00080C
        lea.l        PAD1_DATA.l, a1                               ; $000812
        lea.l        rControllerState(a6), a0                      ; $000818
        move.w       (a0), rPreviousControllerState(a6)            ; $00081C
        move.b       #$40, (a1)                                    ; $000820
        nop                                                        ; $000824
        nop                                                        ; $000826
        nop                                                        ; $000828
        move.b       (a1), d0                                      ; $00082A
        nop                                                        ; $00082C
        nop                                                        ; $00082E
        nop                                                        ; $000830
        move.b       #$0, (a1)                                     ; $000832
        nop                                                        ; $000836
        nop                                                        ; $000838
        nop                                                        ; $00083A
        move.b       (a1), d1                                      ; $00083C
        nop                                                        ; $00083E
        nop                                                        ; $000840
        nop                                                        ; $000842
        move.b       #$40, (a1)                                    ; $000844
        nop                                                        ; $000848
        nop                                                        ; $00084A
        nop                                                        ; $00084C
        move.b       (a1), d2                                      ; $00084E
        nop                                                        ; $000850
        nop                                                        ; $000852
        nop                                                        ; $000854
        move.b       #$0, (a1)                                     ; $000856
        nop                                                        ; $00085A
        nop                                                        ; $00085C
        nop                                                        ; $00085E
        move.b       (a1), d2                                      ; $000860
        nop                                                        ; $000862
        nop                                                        ; $000864
        nop                                                        ; $000866
        move.b       #$40, (a1)                                    ; $000868
        nop                                                        ; $00086C
        nop                                                        ; $00086E
        nop                                                        ; $000870
        move.b       (a1), d2                                      ; $000872
        nop                                                        ; $000874
        nop                                                        ; $000876
        nop                                                        ; $000878
        move.b       #$0, (a1)                                     ; $00087A
        nop                                                        ; $00087E
        nop                                                        ; $000880
        nop                                                        ; $000882
        move.b       (a1), d3                                      ; $000884
        nop                                                        ; $000886
        nop                                                        ; $000888
        nop                                                        ; $00088A
        move.b       #$40, (a1)                                    ; $00088C
        nop                                                        ; $000890
        nop                                                        ; $000892
        nop                                                        ; $000894
        move.b       (a1), d4                                      ; $000896
        nop                                                        ; $000898
        nop                                                        ; $00089A
        nop                                                        ; $00089C
        move.b       #$0, (a1)                                     ; $00089E
        nop                                                        ; $0008A2
        nop                                                        ; $0008A4
        nop                                                        ; $0008A6
        move.b       (a1), d2                                      ; $0008A8
        nop                                                        ; $0008AA
        nop                                                        ; $0008AC
        nop                                                        ; $0008AE
        move.b       #$40, (a1)                                    ; $0008B0
        andi.w       #$f, d3                                       ; $0008B4
        andi.w       #$f, d2                                       ; $0008B8
        eor.w        d3, d2                                        ; $0008BC
        cmpi.w       #$f, d2                                       ; $0008BE
        beq.b        loc_0008CA                                    ; $0008C2
        move.w       #$ff, d4                                      ; $0008C4
        bra.b        loc_0008CE                                    ; $0008C8

loc_0008CA:
        bclr.l       #$4, d4                                       ; $0008CA

loc_0008CE:
        asl.w        #$2, d1                                       ; $0008CE
        move.w       d1, d2                                        ; $0008D0
        move.b       (a1), d0                                      ; $0008D2
        andi.w       #$30, d2                                      ; $0008D4
        beq.b        loc_0008DE                                    ; $0008D8
        move.w       #$ff, d1                                      ; $0008DA

loc_0008DE:
        andi.w       #$3f, d0                                      ; $0008DE
        andi.w       #$c0, d1                                      ; $0008E2
        or.w         d1, d0                                        ; $0008E6
        not.w        d0                                            ; $0008E8
        not.w        d4                                            ; $0008EA
        move.b       d0, (a0)+                                     ; $0008EC
        move.b       d4, (a0)                                      ; $0008EE
        jsr          ReleaseZ80Bus.l                               ; $0008F0
        rts                                                        ; $0008F6
        ifne *-$8F8
        fail "ROM end moved"
        endif
