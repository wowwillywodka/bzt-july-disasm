; $000976..$000A25 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$976
        fail "ROM start moved"
        endif

InitializeHardware:
        movea.l      #$0, a7                                       ; $000976
        movea.l      #WORK_RAM_BASE, a6                            ; $00097C
        move.w       #$8f02, VDP_CONTROL.l                         ; $000982
        move.w       #$100, Z80_BUS_REQUEST.l                      ; $00098A
        move.w       #$100, Z80_RESET.l                            ; $000992

loc_00099A:
        btst.b       #$0, Z80_BUS_REQUEST.l                        ; $00099A
        bne.b        loc_00099A                                    ; $0009A2
        move.b       #$40, PAD1_CONTROL.l                          ; $0009A4
        move.b       #$40, PAD2_CONTROL.l                          ; $0009AC
        move.b       #$40, $a1000d.l                               ; $0009B4
        bsr.w        ClearWorkRam                                  ; $0009BC
        bsr.w        SeedRandom                                    ; $0009C0
        move.l       #$c0000000, VDP_CONTROL.l                     ; $0009C4
        moveq        #$1f, d0                                      ; $0009CE

loc_0009D0:
        move.l       #$0, VDP_DATA.l                               ; $0009D0
        dbra         d0, loc_0009D0                                ; $0009DA
        move.l       #$40000000, VDP_CONTROL.l                     ; $0009DE
        move.w       #$3fff, d0                                    ; $0009E8

loc_0009EC:
        move.l       #$0, VDP_DATA.l                               ; $0009EC
        dbra         d0, loc_0009EC                                ; $0009F6

loc_0009FA:
        move.w       VDP_CONTROL.l, d0                             ; $0009FA
        andi.w       #$2, d0                                       ; $000A00
        bne.b        loc_0009FA                                    ; $000A04
        jsr          DetectController(pc)                          ; $000A06
        bsr.w        InitializeVdpRegisters                        ; $000A0A
        clr.w        -$7ffe(a6)                                    ; $000A0E
        jsr          InputRoutine_01FF82.l                         ; $000A12
        move.w       #$2500, sr                                    ; $000A18
        jsr          InitializeSoundState.l                        ; $000A1C
        bra.w        RunTitleAndGameFlow                           ; $000A22
        ifne *-$A26
        fail "ROM end moved"
        endif
