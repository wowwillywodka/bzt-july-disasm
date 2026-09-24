; $029C0E..$029E67 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Packs 46 progress bits and an eight-bit checksum,
; permutes and XORs seven bytes, then writes nine six-bit alphabet characters.
; This is the ordinary password encoder, not the early special-phrase path.
        ifne *-$29C0E
        fail "ROM start moved"
        endif

EncodeProgressPassword:
        move.l       a0, -(a7)                                     ; $029C0E
        lea.l        rPasswordPlainBitBuffer(a6), a1                                ; $029C10
        clr.w        d1                                            ; $029C14
        move.b       rCharacterAvailable0(a6), d0                  ; $029C16
        bsr.w        WritePasswordBit                              ; $029C1A
        move.b       rCharacterAvailable1(a6), d0                  ; $029C1E
        bsr.w        WritePasswordBit                              ; $029C22
        move.b       rCharacterAvailable2(a6), d0                  ; $029C26
        bsr.w        WritePasswordBit                              ; $029C2A
        move.b       rCharacterAvailable3(a6), d0                  ; $029C2E
        bsr.w        WritePasswordBit                              ; $029C32
        move.b       rCharacterAvailable4(a6), d0                  ; $029C36
        bsr.w        WritePasswordBit                              ; $029C3A
        clr.w        d0                                            ; $029C3E
        move.b       rSavedInventoryItem0(a6), d2                  ; $029C40
        bset.l       d2, d0                                        ; $029C44
        move.b       rSavedInventoryItem1(a6), d2                  ; $029C46
        bset.l       d2, d0                                        ; $029C4A
        move.b       rSavedInventoryItem2(a6), d2                  ; $029C4C
        bset.l       d2, d0                                        ; $029C50
        move.b       rSavedInventoryItem3(a6), d2                  ; $029C52
        bset.l       d2, d0                                        ; $029C56
        move.b       rSavedInventoryItem4(a6), d2                  ; $029C58
        bset.l       d2, d0                                        ; $029C5C
        asr.w        #$1, d0                                       ; $029C5E
        bsr.w        WritePasswordBit                              ; $029C60
        bsr.w        WritePasswordBit                              ; $029C64
        bsr.w        WritePasswordBit                              ; $029C68
        bsr.w        WritePasswordBit                              ; $029C6C
        bsr.w        WritePasswordBit                              ; $029C70
        bsr.w        WritePasswordBit                              ; $029C74
        bsr.w        WritePasswordBit                              ; $029C78
        bsr.w        WritePasswordBit                              ; $029C7C
        bsr.w        WritePasswordBit                              ; $029C80
        bsr.w        WritePasswordBit                              ; $029C84
        bsr.w        WritePasswordBit                              ; $029C88
        bsr.w        WritePasswordBit                              ; $029C8C
        bsr.w        WritePasswordBit                              ; $029C90
        bsr.w        WritePasswordBit                              ; $029C94
        move.b       rSavedInventoryAmount0(a6), d0                ; $029C98
        bsr.w        WritePasswordBit                              ; $029C9C
        bsr.w        WritePasswordBit                              ; $029CA0
        bsr.w        WritePasswordBit                              ; $029CA4
        move.b       rSavedInventoryAmount1(a6), d0                ; $029CA8
        bsr.w        WritePasswordBit                              ; $029CAC
        bsr.w        WritePasswordBit                              ; $029CB0
        bsr.w        WritePasswordBit                              ; $029CB4
        move.b       rSavedInventoryAmount2(a6), d0                ; $029CB8
        bsr.w        WritePasswordBit                              ; $029CBC
        bsr.w        WritePasswordBit                              ; $029CC0
        bsr.w        WritePasswordBit                              ; $029CC4
        move.b       rSavedInventoryAmount3(a6), d0                ; $029CC8
        bsr.w        WritePasswordBit                              ; $029CCC
        bsr.w        WritePasswordBit                              ; $029CD0
        bsr.w        WritePasswordBit                              ; $029CD4
        move.b       rSavedInventoryAmount4(a6), d0                ; $029CD8
        bsr.w        WritePasswordBit                              ; $029CDC
        bsr.w        WritePasswordBit                              ; $029CE0
        bsr.w        WritePasswordBit                              ; $029CE4
        move.b       rSavedHealth(a6), d0                          ; $029CE8
        bsr.w        WritePasswordBit                              ; $029CEC
        bsr.w        WritePasswordBit                              ; $029CF0
        bsr.w        WritePasswordBit                              ; $029CF4
        bsr.w        WritePasswordBit                              ; $029CF8
        bsr.w        WritePasswordBit                              ; $029CFC
        bsr.w        WritePasswordBit                              ; $029D00
        move.b       rLevelSelection(a6), d0                       ; $029D04
        bsr.w        WritePasswordBit                              ; $029D08
        bsr.w        WritePasswordBit                              ; $029D0C
        bsr.w        WritePasswordBit                              ; $029D10
        bsr.w        WritePasswordBit                              ; $029D14
        bsr.w        WritePasswordBit                              ; $029D18
        bsr.w        WritePasswordBit                              ; $029D1C
        lea.l        rPasswordPlainBitBuffer(a6), a2                                ; $029D20
        clr.w        d2                                            ; $029D24
        clr.w        d3                                            ; $029D26
        clr.w        d0                                            ; $029D28
        bsr.w        ReadPasswordBit                               ; $029D2A
        bsr.w        ReadPasswordBit                               ; $029D2E
        bsr.w        ReadPasswordBit                               ; $029D32
        bsr.w        ReadPasswordBit                               ; $029D36
        bsr.w        ReadPasswordBit                               ; $029D3A
        bsr.w        ReadPasswordBit                               ; $029D3E
        bsr.w        ReadPasswordBit                               ; $029D42
        bsr.w        ReadPasswordBit                               ; $029D46
        rol.w        #$7, d0                                       ; $029D4A
        add.w        d0, d3                                        ; $029D4C
        clr.w        d0                                            ; $029D4E
        bsr.w        ReadPasswordBit                               ; $029D50
        bsr.w        ReadPasswordBit                               ; $029D54
        bsr.w        ReadPasswordBit                               ; $029D58
        bsr.w        ReadPasswordBit                               ; $029D5C
        bsr.w        ReadPasswordBit                               ; $029D60
        bsr.w        ReadPasswordBit                               ; $029D64
        bsr.w        ReadPasswordBit                               ; $029D68
        bsr.w        ReadPasswordBit                               ; $029D6C
        rol.w        #$7, d0                                       ; $029D70
        add.w        d0, d3                                        ; $029D72
        clr.w        d0                                            ; $029D74
        bsr.w        ReadPasswordBit                               ; $029D76
        bsr.w        ReadPasswordBit                               ; $029D7A
        bsr.w        ReadPasswordBit                               ; $029D7E
        bsr.w        ReadPasswordBit                               ; $029D82
        bsr.w        ReadPasswordBit                               ; $029D86
        bsr.w        ReadPasswordBit                               ; $029D8A
        bsr.w        ReadPasswordBit                               ; $029D8E
        bsr.w        ReadPasswordBit                               ; $029D92
        rol.w        #$7, d0                                       ; $029D96
        add.w        d0, d3                                        ; $029D98
        clr.w        d0                                            ; $029D9A
        bsr.w        ReadPasswordBit                               ; $029D9C
        bsr.w        ReadPasswordBit                               ; $029DA0
        bsr.w        ReadPasswordBit                               ; $029DA4
        bsr.w        ReadPasswordBit                               ; $029DA8
        bsr.w        ReadPasswordBit                               ; $029DAC
        bsr.w        ReadPasswordBit                               ; $029DB0
        bsr.w        ReadPasswordBit                               ; $029DB4
        bsr.w        ReadPasswordBit                               ; $029DB8
        rol.w        #$7, d0                                       ; $029DBC
        add.w        d0, d3                                        ; $029DBE
        clr.w        d0                                            ; $029DC0
        bsr.w        ReadPasswordBit                               ; $029DC2
        bsr.w        ReadPasswordBit                               ; $029DC6
        bsr.w        ReadPasswordBit                               ; $029DCA
        bsr.w        ReadPasswordBit                               ; $029DCE
        bsr.w        ReadPasswordBit                               ; $029DD2
        bsr.w        ReadPasswordBit                               ; $029DD6
        bsr.w        ReadPasswordBit                               ; $029DDA
        bsr.w        ReadPasswordBit                               ; $029DDE
        rol.w        #$7, d0                                       ; $029DE2
        add.w        d0, d3                                        ; $029DE4
        clr.w        d0                                            ; $029DE6
        bsr.w        ReadPasswordBit                               ; $029DE8
        bsr.w        ReadPasswordBit                               ; $029DEC
        bsr.w        ReadPasswordBit                               ; $029DF0
        bsr.w        ReadPasswordBit                               ; $029DF4
        bsr.w        ReadPasswordBit                               ; $029DF8
        bsr.w        ReadPasswordBit                               ; $029DFC
        rol.w        #$5, d0                                       ; $029E00
        add.w        d0, d3                                        ; $029E02
        move.w       d3, d0                                        ; $029E04
        bsr.w        WritePasswordBit                              ; $029E06
        bsr.w        WritePasswordBit                              ; $029E0A
        bsr.w        WritePasswordBit                              ; $029E0E
        bsr.w        WritePasswordBit                              ; $029E12
        bsr.w        WritePasswordBit                              ; $029E16
        bsr.w        WritePasswordBit                              ; $029E1A
        bsr.w        WritePasswordBit                              ; $029E1E
        bsr.w        WritePasswordBit                              ; $029E22
        movea.l      (a7)+, a0                                     ; $029E26
        lea.l        rPasswordPlainBitBuffer(a6), a2                                ; $029E28
        lea.l        rPasswordEncodedBitBuffer(a6), a1                                ; $029E2C
        bsr.w        DecodePasswordBits                            ; $029E30
        lea.l        PasswordCodeAlphabet(pc), a1                  ; $029E34
        lea.l        rPasswordEncodedBitBuffer(a6), a2                                ; $029E38
        clr.w        d2                                            ; $029E3C
        move.w       #$8, d6                                       ; $029E3E

loc_029E42:
        clr.w        d0                                            ; $029E42
        bsr.w        ReadPasswordBit                               ; $029E44
        bsr.w        ReadPasswordBit                               ; $029E48
        bsr.w        ReadPasswordBit                               ; $029E4C
        bsr.w        ReadPasswordBit                               ; $029E50
        bsr.w        ReadPasswordBit                               ; $029E54
        bsr.w        ReadPasswordBit                               ; $029E58
        rol.w        #$5, d0                                       ; $029E5C
        move.b       (a1, d0.w), (a0)+                             ; $029E5E
        dbra         d6, loc_029E42                                ; $029E62
        rts                                                        ; $029E66
        ifne *-$29E68
        fail "ROM end moved"
        endif
