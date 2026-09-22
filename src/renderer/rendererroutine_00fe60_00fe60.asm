; $00FE60..$0101FB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; развёрнутый span-цикл текстурного рендера (=June ED7E/ZT F2B0)
        ifne *-$FE60
        fail "ROM start moved"
        endif

RendererRoutine_00FE60:
        move.b       (a2)+, d1                                     ; $00FE60
        move.b       (a1, d1.w), d1                                ; $00FE62
        beq.b        loc_00FE6C                                    ; $00FE66
        move.b       (a3, d1.w), (a0)                              ; $00FE68

loc_00FE6C:
        addq.w       #$4, a0                                       ; $00FE6C
        move.b       (a2)+, d1                                     ; $00FE6E
        move.b       (a1, d1.w), d1                                ; $00FE70
        beq.b        loc_00FE7A                                    ; $00FE74
        move.b       (a3, d1.w), (a0)                              ; $00FE76

loc_00FE7A:
        addq.w       #$4, a0                                       ; $00FE7A
        move.b       (a2)+, d1                                     ; $00FE7C
        move.b       (a1, d1.w), d1                                ; $00FE7E
        beq.b        loc_00FE88                                    ; $00FE82
        move.b       (a3, d1.w), (a0)                              ; $00FE84

loc_00FE88:
        addq.w       #$4, a0                                       ; $00FE88
        move.b       (a2)+, d1                                     ; $00FE8A
        move.b       (a1, d1.w), d1                                ; $00FE8C
        beq.b        loc_00FE96                                    ; $00FE90
        move.b       (a3, d1.w), (a0)                              ; $00FE92

loc_00FE96:
        addq.w       #$4, a0                                       ; $00FE96
        move.b       (a2)+, d1                                     ; $00FE98
        move.b       (a1, d1.w), d1                                ; $00FE9A
        beq.b        loc_00FEA4                                    ; $00FE9E
        move.b       (a3, d1.w), (a0)                              ; $00FEA0

loc_00FEA4:
        addq.w       #$4, a0                                       ; $00FEA4
        move.b       (a2)+, d1                                     ; $00FEA6
        move.b       (a1, d1.w), d1                                ; $00FEA8
        beq.b        loc_00FEB2                                    ; $00FEAC
        move.b       (a3, d1.w), (a0)                              ; $00FEAE

loc_00FEB2:
        addq.w       #$4, a0                                       ; $00FEB2
        move.b       (a2)+, d1                                     ; $00FEB4
        move.b       (a1, d1.w), d1                                ; $00FEB6
        beq.b        loc_00FEC0                                    ; $00FEBA
        move.b       (a3, d1.w), (a0)                              ; $00FEBC

loc_00FEC0:
        addq.w       #$4, a0                                       ; $00FEC0
        move.b       (a2)+, d1                                     ; $00FEC2
        move.b       (a1, d1.w), d1                                ; $00FEC4
        beq.b        loc_00FECE                                    ; $00FEC8
        move.b       (a3, d1.w), (a0)                              ; $00FECA

loc_00FECE:
        addq.w       #$4, a0                                       ; $00FECE
        move.b       (a2)+, d1                                     ; $00FED0
        move.b       (a1, d1.w), d1                                ; $00FED2
        beq.b        loc_00FEDC                                    ; $00FED6
        move.b       (a3, d1.w), (a0)                              ; $00FED8

loc_00FEDC:
        addq.w       #$4, a0                                       ; $00FEDC
        move.b       (a2)+, d1                                     ; $00FEDE
        move.b       (a1, d1.w), d1                                ; $00FEE0
        beq.b        loc_00FEEA                                    ; $00FEE4
        move.b       (a3, d1.w), (a0)                              ; $00FEE6

loc_00FEEA:
        addq.w       #$4, a0                                       ; $00FEEA
        move.b       (a2)+, d1                                     ; $00FEEC
        move.b       (a1, d1.w), d1                                ; $00FEEE
        beq.b        loc_00FEF8                                    ; $00FEF2
        move.b       (a3, d1.w), (a0)                              ; $00FEF4

loc_00FEF8:
        addq.w       #$4, a0                                       ; $00FEF8
        move.b       (a2)+, d1                                     ; $00FEFA
        move.b       (a1, d1.w), d1                                ; $00FEFC
        beq.b        loc_00FF06                                    ; $00FF00
        move.b       (a3, d1.w), (a0)                              ; $00FF02

loc_00FF06:
        addq.w       #$4, a0                                       ; $00FF06
        move.b       (a2)+, d1                                     ; $00FF08
        move.b       (a1, d1.w), d1                                ; $00FF0A
        beq.b        loc_00FF14                                    ; $00FF0E
        move.b       (a3, d1.w), (a0)                              ; $00FF10

loc_00FF14:
        addq.w       #$4, a0                                       ; $00FF14
        move.b       (a2)+, d1                                     ; $00FF16
        move.b       (a1, d1.w), d1                                ; $00FF18
        beq.b        loc_00FF22                                    ; $00FF1C
        move.b       (a3, d1.w), (a0)                              ; $00FF1E

loc_00FF22:
        addq.w       #$4, a0                                       ; $00FF22
        move.b       (a2)+, d1                                     ; $00FF24
        move.b       (a1, d1.w), d1                                ; $00FF26
        beq.b        loc_00FF30                                    ; $00FF2A
        move.b       (a3, d1.w), (a0)                              ; $00FF2C

loc_00FF30:
        addq.w       #$4, a0                                       ; $00FF30
        move.b       (a2)+, d1                                     ; $00FF32
        move.b       (a1, d1.w), d1                                ; $00FF34
        beq.b        loc_00FF3E                                    ; $00FF38
        move.b       (a3, d1.w), (a0)                              ; $00FF3A

loc_00FF3E:
        addq.w       #$4, a0                                       ; $00FF3E
        move.b       (a2)+, d1                                     ; $00FF40
        move.b       (a1, d1.w), d1                                ; $00FF42
        beq.b        loc_00FF4C                                    ; $00FF46
        move.b       (a3, d1.w), (a0)                              ; $00FF48

loc_00FF4C:
        addq.w       #$4, a0                                       ; $00FF4C
        move.b       (a2)+, d1                                     ; $00FF4E
        move.b       (a1, d1.w), d1                                ; $00FF50
        beq.b        loc_00FF5A                                    ; $00FF54
        move.b       (a3, d1.w), (a0)                              ; $00FF56

loc_00FF5A:
        addq.w       #$4, a0                                       ; $00FF5A
        move.b       (a2)+, d1                                     ; $00FF5C
        move.b       (a1, d1.w), d1                                ; $00FF5E
        beq.b        loc_00FF68                                    ; $00FF62
        move.b       (a3, d1.w), (a0)                              ; $00FF64

loc_00FF68:
        addq.w       #$4, a0                                       ; $00FF68
        move.b       (a2)+, d1                                     ; $00FF6A
        move.b       (a1, d1.w), d1                                ; $00FF6C
        beq.b        loc_00FF76                                    ; $00FF70
        move.b       (a3, d1.w), (a0)                              ; $00FF72

loc_00FF76:
        addq.w       #$4, a0                                       ; $00FF76
        move.b       (a2)+, d1                                     ; $00FF78
        move.b       (a1, d1.w), d1                                ; $00FF7A
        beq.b        loc_00FF84                                    ; $00FF7E
        move.b       (a3, d1.w), (a0)                              ; $00FF80

loc_00FF84:
        addq.w       #$4, a0                                       ; $00FF84
        move.b       (a2)+, d1                                     ; $00FF86
        move.b       (a1, d1.w), d1                                ; $00FF88
        beq.b        loc_00FF92                                    ; $00FF8C
        move.b       (a3, d1.w), (a0)                              ; $00FF8E

loc_00FF92:
        addq.w       #$4, a0                                       ; $00FF92
        move.b       (a2)+, d1                                     ; $00FF94
        move.b       (a1, d1.w), d1                                ; $00FF96
        beq.b        loc_00FFA0                                    ; $00FF9A
        move.b       (a3, d1.w), (a0)                              ; $00FF9C

loc_00FFA0:
        addq.w       #$4, a0                                       ; $00FFA0
        move.b       (a2)+, d1                                     ; $00FFA2
        move.b       (a1, d1.w), d1                                ; $00FFA4
        beq.b        loc_00FFAE                                    ; $00FFA8
        move.b       (a3, d1.w), (a0)                              ; $00FFAA

loc_00FFAE:
        addq.w       #$4, a0                                       ; $00FFAE
        move.b       (a2)+, d1                                     ; $00FFB0
        move.b       (a1, d1.w), d1                                ; $00FFB2
        beq.b        loc_00FFBC                                    ; $00FFB6
        move.b       (a3, d1.w), (a0)                              ; $00FFB8

loc_00FFBC:
        addq.w       #$4, a0                                       ; $00FFBC
        move.b       (a2)+, d1                                     ; $00FFBE
        move.b       (a1, d1.w), d1                                ; $00FFC0
        beq.b        loc_00FFCA                                    ; $00FFC4
        move.b       (a3, d1.w), (a0)                              ; $00FFC6

loc_00FFCA:
        addq.w       #$4, a0                                       ; $00FFCA
        move.b       (a2)+, d1                                     ; $00FFCC
        move.b       (a1, d1.w), d1                                ; $00FFCE
        beq.b        loc_00FFD8                                    ; $00FFD2
        move.b       (a3, d1.w), (a0)                              ; $00FFD4

loc_00FFD8:
        addq.w       #$4, a0                                       ; $00FFD8
        move.b       (a2)+, d1                                     ; $00FFDA
        move.b       (a1, d1.w), d1                                ; $00FFDC
        beq.b        loc_00FFE6                                    ; $00FFE0
        move.b       (a3, d1.w), (a0)                              ; $00FFE2

loc_00FFE6:
        addq.w       #$4, a0                                       ; $00FFE6
        move.b       (a2)+, d1                                     ; $00FFE8
        move.b       (a1, d1.w), d1                                ; $00FFEA
        beq.b        loc_00FFF4                                    ; $00FFEE
        move.b       (a3, d1.w), (a0)                              ; $00FFF0

loc_00FFF4:
        addq.w       #$4, a0                                       ; $00FFF4
        move.b       (a2)+, d1                                     ; $00FFF6
        move.b       (a1, d1.w), d1                                ; $00FFF8
        beq.b        loc_010002                                    ; $00FFFC
        move.b       (a3, d1.w), (a0)                              ; $00FFFE

loc_010002:
        addq.w       #$4, a0                                       ; $010002
        move.b       (a2)+, d1                                     ; $010004
        move.b       (a1, d1.w), d1                                ; $010006
        beq.b        loc_010010                                    ; $01000A
        move.b       (a3, d1.w), (a0)                              ; $01000C

loc_010010:
        addq.w       #$4, a0                                       ; $010010
        move.b       (a2)+, d1                                     ; $010012
        move.b       (a1, d1.w), d1                                ; $010014
        beq.b        loc_01001E                                    ; $010018
        move.b       (a3, d1.w), (a0)                              ; $01001A

loc_01001E:
        addq.w       #$4, a0                                       ; $01001E
        move.b       (a2)+, d1                                     ; $010020
        move.b       (a1, d1.w), d1                                ; $010022
        beq.b        loc_01002C                                    ; $010026
        move.b       (a3, d1.w), (a0)                              ; $010028

loc_01002C:
        addq.w       #$4, a0                                       ; $01002C
        move.b       (a2)+, d1                                     ; $01002E
        move.b       (a1, d1.w), d1                                ; $010030
        beq.b        loc_01003A                                    ; $010034
        move.b       (a3, d1.w), (a0)                              ; $010036

loc_01003A:
        addq.w       #$4, a0                                       ; $01003A
        move.b       (a2)+, d1                                     ; $01003C
        move.b       (a1, d1.w), d1                                ; $01003E
        beq.b        loc_010048                                    ; $010042
        move.b       (a3, d1.w), (a0)                              ; $010044

loc_010048:
        addq.w       #$4, a0                                       ; $010048
        move.b       (a2)+, d1                                     ; $01004A
        move.b       (a1, d1.w), d1                                ; $01004C
        beq.b        loc_010056                                    ; $010050
        move.b       (a3, d1.w), (a0)                              ; $010052

loc_010056:
        addq.w       #$4, a0                                       ; $010056
        move.b       (a2)+, d1                                     ; $010058
        move.b       (a1, d1.w), d1                                ; $01005A
        beq.b        loc_010064                                    ; $01005E
        move.b       (a3, d1.w), (a0)                              ; $010060

loc_010064:
        addq.w       #$4, a0                                       ; $010064
        move.b       (a2)+, d1                                     ; $010066
        move.b       (a1, d1.w), d1                                ; $010068
        beq.b        loc_010072                                    ; $01006C
        move.b       (a3, d1.w), (a0)                              ; $01006E

loc_010072:
        addq.w       #$4, a0                                       ; $010072
        move.b       (a2)+, d1                                     ; $010074
        move.b       (a1, d1.w), d1                                ; $010076
        beq.b        loc_010080                                    ; $01007A
        move.b       (a3, d1.w), (a0)                              ; $01007C

loc_010080:
        addq.w       #$4, a0                                       ; $010080
        move.b       (a2)+, d1                                     ; $010082
        move.b       (a1, d1.w), d1                                ; $010084
        beq.b        loc_01008E                                    ; $010088
        move.b       (a3, d1.w), (a0)                              ; $01008A

loc_01008E:
        addq.w       #$4, a0                                       ; $01008E
        move.b       (a2)+, d1                                     ; $010090
        move.b       (a1, d1.w), d1                                ; $010092
        beq.b        loc_01009C                                    ; $010096
        move.b       (a3, d1.w), (a0)                              ; $010098

loc_01009C:
        addq.w       #$4, a0                                       ; $01009C
        move.b       (a2)+, d1                                     ; $01009E
        move.b       (a1, d1.w), d1                                ; $0100A0
        beq.b        loc_0100AA                                    ; $0100A4
        move.b       (a3, d1.w), (a0)                              ; $0100A6

loc_0100AA:
        addq.w       #$4, a0                                       ; $0100AA
        move.b       (a2)+, d1                                     ; $0100AC
        move.b       (a1, d1.w), d1                                ; $0100AE
        beq.b        loc_0100B8                                    ; $0100B2
        move.b       (a3, d1.w), (a0)                              ; $0100B4

loc_0100B8:
        addq.w       #$4, a0                                       ; $0100B8
        move.b       (a2)+, d1                                     ; $0100BA
        move.b       (a1, d1.w), d1                                ; $0100BC
        beq.b        loc_0100C6                                    ; $0100C0
        move.b       (a3, d1.w), (a0)                              ; $0100C2

loc_0100C6:
        addq.w       #$4, a0                                       ; $0100C6
        move.b       (a2)+, d1                                     ; $0100C8
        move.b       (a1, d1.w), d1                                ; $0100CA
        beq.b        loc_0100D4                                    ; $0100CE
        move.b       (a3, d1.w), (a0)                              ; $0100D0

loc_0100D4:
        addq.w       #$4, a0                                       ; $0100D4
        move.b       (a2)+, d1                                     ; $0100D6
        move.b       (a1, d1.w), d1                                ; $0100D8
        beq.b        loc_0100E2                                    ; $0100DC
        move.b       (a3, d1.w), (a0)                              ; $0100DE

loc_0100E2:
        addq.w       #$4, a0                                       ; $0100E2
        move.b       (a2)+, d1                                     ; $0100E4
        move.b       (a1, d1.w), d1                                ; $0100E6
        beq.b        loc_0100F0                                    ; $0100EA
        move.b       (a3, d1.w), (a0)                              ; $0100EC

loc_0100F0:
        addq.w       #$4, a0                                       ; $0100F0
        move.b       (a2)+, d1                                     ; $0100F2
        move.b       (a1, d1.w), d1                                ; $0100F4
        beq.b        loc_0100FE                                    ; $0100F8
        move.b       (a3, d1.w), (a0)                              ; $0100FA

loc_0100FE:
        addq.w       #$4, a0                                       ; $0100FE
        move.b       (a2)+, d1                                     ; $010100
        move.b       (a1, d1.w), d1                                ; $010102
        beq.b        loc_01010C                                    ; $010106
        move.b       (a3, d1.w), (a0)                              ; $010108

loc_01010C:
        addq.w       #$4, a0                                       ; $01010C
        move.b       (a2)+, d1                                     ; $01010E
        move.b       (a1, d1.w), d1                                ; $010110
        beq.b        loc_01011A                                    ; $010114
        move.b       (a3, d1.w), (a0)                              ; $010116

loc_01011A:
        addq.w       #$4, a0                                       ; $01011A
        move.b       (a2)+, d1                                     ; $01011C
        move.b       (a1, d1.w), d1                                ; $01011E
        beq.b        loc_010128                                    ; $010122
        move.b       (a3, d1.w), (a0)                              ; $010124

loc_010128:
        addq.w       #$4, a0                                       ; $010128
        move.b       (a2)+, d1                                     ; $01012A
        move.b       (a1, d1.w), d1                                ; $01012C
        beq.b        loc_010136                                    ; $010130
        move.b       (a3, d1.w), (a0)                              ; $010132

loc_010136:
        addq.w       #$4, a0                                       ; $010136
        move.b       (a2)+, d1                                     ; $010138
        move.b       (a1, d1.w), d1                                ; $01013A
        beq.b        loc_010144                                    ; $01013E
        move.b       (a3, d1.w), (a0)                              ; $010140

loc_010144:
        addq.w       #$4, a0                                       ; $010144
        move.b       (a2)+, d1                                     ; $010146
        move.b       (a1, d1.w), d1                                ; $010148
        beq.b        loc_010152                                    ; $01014C
        move.b       (a3, d1.w), (a0)                              ; $01014E

loc_010152:
        addq.w       #$4, a0                                       ; $010152
        move.b       (a2)+, d1                                     ; $010154
        move.b       (a1, d1.w), d1                                ; $010156
        beq.b        loc_010160                                    ; $01015A
        move.b       (a3, d1.w), (a0)                              ; $01015C

loc_010160:
        addq.w       #$4, a0                                       ; $010160
        move.b       (a2)+, d1                                     ; $010162
        move.b       (a1, d1.w), d1                                ; $010164
        beq.b        loc_01016E                                    ; $010168
        move.b       (a3, d1.w), (a0)                              ; $01016A

loc_01016E:
        addq.w       #$4, a0                                       ; $01016E
        move.b       (a2)+, d1                                     ; $010170
        move.b       (a1, d1.w), d1                                ; $010172
        beq.b        loc_01017C                                    ; $010176
        move.b       (a3, d1.w), (a0)                              ; $010178

loc_01017C:
        addq.w       #$4, a0                                       ; $01017C
        move.b       (a2)+, d1                                     ; $01017E
        move.b       (a1, d1.w), d1                                ; $010180
        beq.b        loc_01018A                                    ; $010184
        move.b       (a3, d1.w), (a0)                              ; $010186

loc_01018A:
        addq.w       #$4, a0                                       ; $01018A
        move.b       (a2)+, d1                                     ; $01018C
        move.b       (a1, d1.w), d1                                ; $01018E
        beq.b        loc_010198                                    ; $010192
        move.b       (a3, d1.w), (a0)                              ; $010194

loc_010198:
        addq.w       #$4, a0                                       ; $010198
        move.b       (a2)+, d1                                     ; $01019A
        move.b       (a1, d1.w), d1                                ; $01019C
        beq.b        loc_0101A6                                    ; $0101A0
        move.b       (a3, d1.w), (a0)                              ; $0101A2

loc_0101A6:
        addq.w       #$4, a0                                       ; $0101A6
        move.b       (a2)+, d1                                     ; $0101A8
        move.b       (a1, d1.w), d1                                ; $0101AA
        beq.b        loc_0101B4                                    ; $0101AE
        move.b       (a3, d1.w), (a0)                              ; $0101B0

loc_0101B4:
        addq.w       #$4, a0                                       ; $0101B4
        move.b       (a2)+, d1                                     ; $0101B6
        move.b       (a1, d1.w), d1                                ; $0101B8
        beq.b        loc_0101C2                                    ; $0101BC
        move.b       (a3, d1.w), (a0)                              ; $0101BE

loc_0101C2:
        addq.w       #$4, a0                                       ; $0101C2
        move.b       (a2)+, d1                                     ; $0101C4
        move.b       (a1, d1.w), d1                                ; $0101C6
        beq.b        loc_0101D0                                    ; $0101CA
        move.b       (a3, d1.w), (a0)                              ; $0101CC

loc_0101D0:
        addq.w       #$4, a0                                       ; $0101D0
        move.b       (a2)+, d1                                     ; $0101D2
        move.b       (a1, d1.w), d1                                ; $0101D4
        beq.b        loc_0101DE                                    ; $0101D8
        move.b       (a3, d1.w), (a0)                              ; $0101DA

loc_0101DE:
        addq.w       #$4, a0                                       ; $0101DE
        move.b       (a2)+, d1                                     ; $0101E0
        move.b       (a1, d1.w), d1                                ; $0101E2
        beq.b        loc_0101EC                                    ; $0101E6
        move.b       (a3, d1.w), (a0)                              ; $0101E8

loc_0101EC:
        addq.w       #$4, a0                                       ; $0101EC
        move.b       (a2)+, d1                                     ; $0101EE
        move.b       (a1, d1.w), d1                                ; $0101F0
        beq.b        loc_0101FA                                    ; $0101F4
        move.b       (a3, d1.w), (a0)                              ; $0101F6

loc_0101FA:
        rts                                                        ; $0101FA
        ifne *-$101FC
        fail "ROM end moved"
        endif
