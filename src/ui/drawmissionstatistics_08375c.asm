; $08375C..$083C29 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Full reg-save then decompress(0x98b98) + many lea(string/table)+move.w#id+jsr 0x7b552 to render a HUD/briefing-stats screen; formats numbers via 0x83c2a; ends rts@83c28
        ifne *-$8375C
        fail "ROM start moved"
        endif

DrawMissionStatistics:
        move.l       a7, -(a7)                                     ; $08375C
        move.l       d7, -(a7)                                     ; $08375E
        move.l       d6, -(a7)                                     ; $083760
        move.l       d5, -(a7)                                     ; $083762
        move.l       d4, -(a7)                                     ; $083764
        move.l       d3, -(a7)                                     ; $083766
        move.l       d2, -(a7)                                     ; $083768
        move.l       d1, -(a7)                                     ; $08376A
        move.l       d0, -(a7)                                     ; $08376C
        move.l       a6, -(a7)                                     ; $08376E
        move.l       a5, -(a7)                                     ; $083770
        move.l       a4, -(a7)                                     ; $083772
        move.l       a3, -(a7)                                     ; $083774
        move.l       a2, -(a7)                                     ; $083776
        move.l       a1, -(a7)                                     ; $083778
        move.l       a0, -(a7)                                     ; $08377A
        jsr          InitializeMenuVdp.l                           ; $08377C
        jsr          ClearCram.l                                   ; $083782
        jsr          ClearAllVram.l                                ; $083788
        move.w       #$0, d0                                       ; $08378E
        jsr          VideoRoutine_021E4A.l                         ; $083792
        lea.l        InterfacePalettes.l, a0                       ; $083798
        move.w       #$3, d0                                       ; $08379E
        jsr          LoadPaletteLine.l                             ; $0837A2
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $0837A8
        move.w       #$4b0, d0                                     ; $0837AE
        jsr          DecompressBytePairToVramLong.l                ; $0837B2
        move.w       #$c59a, d0                                    ; $0837B8
        lea.l        Data_083C8E.l, a0                             ; $0837BC
        jsr          PrintCharacterMenuText.l                      ; $0837C2
        move.w       #$c082, d0                                    ; $0837C8
        lea.l        RegisterDumpStrings.l, a0                     ; $0837CC
        jsr          PrintCharacterMenuText.l                      ; $0837D2
        move.w       #$c09a, d0                                    ; $0837D8
        lea.l        Data_083C52.l, a0                             ; $0837DC
        jsr          PrintCharacterMenuText.l                      ; $0837E2
        move.w       #$c0b2, d0                                    ; $0837E8
        lea.l        Data_083C56.l, a0                             ; $0837EC
        jsr          PrintCharacterMenuText.l                      ; $0837F2
        move.w       #$c182, d0                                    ; $0837F8
        lea.l        Data_083C5A.l, a0                             ; $0837FC
        jsr          PrintCharacterMenuText.l                      ; $083802
        move.w       #$c19a, d0                                    ; $083808
        lea.l        Data_083C5E.l, a0                             ; $08380C
        jsr          PrintCharacterMenuText.l                      ; $083812
        move.w       #$c1b2, d0                                    ; $083818
        lea.l        Data_083C62.l, a0                             ; $08381C
        jsr          PrintCharacterMenuText.l                      ; $083822
        move.w       #$c282, d0                                    ; $083828
        lea.l        Data_083C66.l, a0                             ; $08382C
        jsr          PrintCharacterMenuText.l                      ; $083832
        move.w       #$c29a, d0                                    ; $083838
        lea.l        Data_083C6A.l, a0                             ; $08383C
        jsr          PrintCharacterMenuText.l                      ; $083842
        move.w       #$c2b2, d0                                    ; $083848
        lea.l        Data_083C6E.l, a0                             ; $08384C
        jsr          PrintCharacterMenuText.l                      ; $083852
        move.w       #$c382, d0                                    ; $083858
        lea.l        Data_083C72.l, a0                             ; $08385C
        jsr          PrintCharacterMenuText.l                      ; $083862
        move.w       #$c39a, d0                                    ; $083868
        lea.l        Data_083C76.l, a0                             ; $08386C
        jsr          PrintCharacterMenuText.l                      ; $083872
        move.w       #$c3b2, d0                                    ; $083878
        lea.l        Data_083C7A.l, a0                             ; $08387C
        jsr          PrintCharacterMenuText.l                      ; $083882
        move.w       #$c482, d0                                    ; $083888
        lea.l        Data_083C7E.l, a0                             ; $08388C
        jsr          PrintCharacterMenuText.l                      ; $083892
        move.w       #$c49a, d0                                    ; $083898
        lea.l        Data_083C82.l, a0                             ; $08389C
        jsr          PrintCharacterMenuText.l                      ; $0838A2
        move.w       #$c4b2, d0                                    ; $0838A8
        lea.l        Data_083C86.l, a0                             ; $0838AC
        jsr          PrintCharacterMenuText.l                      ; $0838B2
        move.w       #$c582, d0                                    ; $0838B8
        lea.l        Data_083C8A.l, a0                             ; $0838BC
        jsr          PrintCharacterMenuText.l                      ; $0838C2
        move.w       #$c5b4, d0                                    ; $0838C8
        lea.l        Data_083C93.l, a0                             ; $0838CC
        jsr          PrintCharacterMenuText.l                      ; $0838D2
        move.w       #$c6b4, d0                                    ; $0838D8
        lea.l        Data_083C96.l, a0                             ; $0838DC
        jsr          PrintCharacterMenuText.l                      ; $0838E2
        move.w       #$c7b4, d0                                    ; $0838E8
        lea.l        Data_083C99.l, a0                             ; $0838EC
        jsr          PrintCharacterMenuText.l                      ; $0838F2
        move.w       #$c8b4, d0                                    ; $0838F8
        lea.l        Data_083C9C.l, a0                             ; $0838FC
        jsr          PrintCharacterMenuText.l                      ; $083902
        move.w       #$c9b4, d0                                    ; $083908
        lea.l        Data_083CA0.l, a0                             ; $08390C
        jsr          PrintCharacterMenuText.l                      ; $083912
        move.w       #$cab4, d0                                    ; $083918
        lea.l        Data_083CA4.l, a0                             ; $08391C
        jsr          PrintCharacterMenuText.l                      ; $083922
        move.w       #$cbb4, d0                                    ; $083928
        lea.l        Data_083CA8.l, a0                             ; $08392C
        jsr          PrintCharacterMenuText.l                      ; $083932
        move.w       #$ccb4, d0                                    ; $083938
        lea.l        Data_083CAC.l, a0                             ; $08393C
        jsr          PrintCharacterMenuText.l                      ; $083942
        move.l       (a7)+, d0                                     ; $083948
        lea.l        $ff1024.l, a0                                 ; $08394A
        jsr          FormatHexLong.l                               ; $083950
        move.w       #$c088, d0                                    ; $083956
        lea.l        $ff1024.l, a0                                 ; $08395A
        jsr          PrintCharacterMenuText.l                      ; $083960
        move.l       (a7)+, d0                                     ; $083966
        lea.l        $ff1024.l, a0                                 ; $083968
        jsr          FormatHexLong.l                               ; $08396E
        move.w       #$c0a0, d0                                    ; $083974
        lea.l        $ff1024.l, a0                                 ; $083978
        jsr          PrintCharacterMenuText.l                      ; $08397E
        move.l       (a7)+, d0                                     ; $083984
        lea.l        $ff1024.l, a0                                 ; $083986
        jsr          FormatHexLong.l                               ; $08398C
        move.w       #$c0b8, d0                                    ; $083992
        lea.l        $ff1024.l, a0                                 ; $083996
        jsr          PrintCharacterMenuText.l                      ; $08399C
        move.l       (a7)+, d0                                     ; $0839A2
        lea.l        $ff1024.l, a0                                 ; $0839A4
        jsr          FormatHexLong.l                               ; $0839AA
        move.w       #$c188, d0                                    ; $0839B0
        lea.l        $ff1024.l, a0                                 ; $0839B4
        jsr          PrintCharacterMenuText.l                      ; $0839BA
        move.l       (a7)+, d0                                     ; $0839C0
        lea.l        $ff1024.l, a0                                 ; $0839C2
        jsr          FormatHexLong.l                               ; $0839C8
        move.w       #$c1a0, d0                                    ; $0839CE
        lea.l        $ff1024.l, a0                                 ; $0839D2
        jsr          PrintCharacterMenuText.l                      ; $0839D8
        move.l       (a7)+, d0                                     ; $0839DE
        lea.l        $ff1024.l, a0                                 ; $0839E0
        jsr          FormatHexLong.l                               ; $0839E6
        move.w       #$c1b8, d0                                    ; $0839EC
        lea.l        $ff1024.l, a0                                 ; $0839F0
        jsr          PrintCharacterMenuText.l                      ; $0839F6
        move.l       (a7)+, d0                                     ; $0839FC
        lea.l        $ff1024.l, a0                                 ; $0839FE
        jsr          FormatHexLong.l                               ; $083A04
        move.w       #$c288, d0                                    ; $083A0A
        lea.l        $ff1024.l, a0                                 ; $083A0E
        jsr          PrintCharacterMenuText.l                      ; $083A14
        move.l       (a7)+, d0                                     ; $083A1A
        lea.l        $ff1024.l, a0                                 ; $083A1C
        jsr          FormatHexLong.l                               ; $083A22
        move.w       #$c2b8, d0                                    ; $083A28
        lea.l        $ff1024.l, a0                                 ; $083A2C
        jsr          PrintCharacterMenuText.l                      ; $083A32
        move.l       (a7)+, d0                                     ; $083A38
        lea.l        $ff1024.l, a0                                 ; $083A3A
        jsr          FormatHexLong.l                               ; $083A40
        move.w       #$c388, d0                                    ; $083A46
        lea.l        $ff1024.l, a0                                 ; $083A4A
        jsr          PrintCharacterMenuText.l                      ; $083A50
        move.l       (a7)+, d0                                     ; $083A56
        lea.l        $ff1024.l, a0                                 ; $083A58
        jsr          FormatHexLong.l                               ; $083A5E
        move.w       #$c3a0, d0                                    ; $083A64
        lea.l        $ff1024.l, a0                                 ; $083A68
        jsr          PrintCharacterMenuText.l                      ; $083A6E
        move.l       (a7)+, d0                                     ; $083A74
        lea.l        $ff1024.l, a0                                 ; $083A76
        jsr          FormatHexLong.l                               ; $083A7C
        move.w       #$c3b8, d0                                    ; $083A82
        lea.l        $ff1024.l, a0                                 ; $083A86
        jsr          PrintCharacterMenuText.l                      ; $083A8C
        move.l       (a7)+, d0                                     ; $083A92
        lea.l        $ff1024.l, a0                                 ; $083A94
        jsr          FormatHexLong.l                               ; $083A9A
        move.w       #$c488, d0                                    ; $083AA0
        lea.l        $ff1024.l, a0                                 ; $083AA4
        jsr          PrintCharacterMenuText.l                      ; $083AAA
        move.l       (a7)+, d0                                     ; $083AB0
        lea.l        $ff1024.l, a0                                 ; $083AB2
        jsr          FormatHexLong.l                               ; $083AB8
        move.w       #$c4a0, d0                                    ; $083ABE
        lea.l        $ff1024.l, a0                                 ; $083AC2
        jsr          PrintCharacterMenuText.l                      ; $083AC8
        move.l       (a7)+, d0                                     ; $083ACE
        lea.l        $ff1024.l, a0                                 ; $083AD0
        jsr          FormatHexLong.l                               ; $083AD6
        move.w       #$c4b8, d0                                    ; $083ADC
        lea.l        $ff1024.l, a0                                 ; $083AE0
        jsr          PrintCharacterMenuText.l                      ; $083AE6
        move.l       (a7)+, d0                                     ; $083AEC
        lea.l        $ff1024.l, a0                                 ; $083AEE
        jsr          FormatHexLong.l                               ; $083AF4
        move.w       #$c588, d0                                    ; $083AFA
        lea.l        $ff1024.l, a0                                 ; $083AFE
        jsr          PrintCharacterMenuText.l                      ; $083B04
        move.l       (a7)+, d0                                     ; $083B0A
        lea.l        $ff1024.l, a0                                 ; $083B0C
        jsr          FormatHexLong.l                               ; $083B12
        move.w       #$c2a0, d0                                    ; $083B18
        lea.l        $ff1024.l, a0                                 ; $083B1C
        jsr          PrintCharacterMenuText.l                      ; $083B22
        move.l       $4(a7), d0                                    ; $083B28
        lea.l        $ff1024.l, a0                                 ; $083B2C
        jsr          FormatHexLong.l                               ; $083B32
        move.w       #$c5a2, d0                                    ; $083B38
        lea.l        $ff1024.l, a0                                 ; $083B3C
        jsr          PrintCharacterMenuText.l                      ; $083B42
        move.l       $8(a7), d0                                    ; $083B48
        lea.l        $ff1024.l, a0                                 ; $083B4C
        jsr          FormatHexLong.l                               ; $083B52
        move.w       #$c6a2, d0                                    ; $083B58
        lea.l        $ff1024.l, a0                                 ; $083B5C
        jsr          PrintCharacterMenuText.l                      ; $083B62
        move.l       $c(a7), d0                                    ; $083B68
        lea.l        $ff1024.l, a0                                 ; $083B6C
        jsr          FormatHexLong.l                               ; $083B72
        move.w       #$c7a2, d0                                    ; $083B78
        lea.l        $ff1024.l, a0                                 ; $083B7C
        jsr          PrintCharacterMenuText.l                      ; $083B82
        move.l       $10(a7), d0                                   ; $083B88
        lea.l        $ff1024.l, a0                                 ; $083B8C
        jsr          FormatHexLong.l                               ; $083B92
        move.w       #$c8a2, d0                                    ; $083B98
        lea.l        $ff1024.l, a0                                 ; $083B9C
        jsr          PrintCharacterMenuText.l                      ; $083BA2
        move.l       $14(a7), d0                                   ; $083BA8
        lea.l        $ff1024.l, a0                                 ; $083BAC
        jsr          FormatHexLong.l                               ; $083BB2
        move.w       #$c9a2, d0                                    ; $083BB8
        lea.l        $ff1024.l, a0                                 ; $083BBC
        jsr          PrintCharacterMenuText.l                      ; $083BC2
        move.l       $18(a7), d0                                   ; $083BC8
        lea.l        $ff1024.l, a0                                 ; $083BCC
        jsr          FormatHexLong.l                               ; $083BD2
        move.w       #$caa2, d0                                    ; $083BD8
        lea.l        $ff1024.l, a0                                 ; $083BDC
        jsr          PrintCharacterMenuText.l                      ; $083BE2
        move.l       $1c(a7), d0                                   ; $083BE8
        lea.l        $ff1024.l, a0                                 ; $083BEC
        jsr          FormatHexLong.l                               ; $083BF2
        move.w       #$cba2, d0                                    ; $083BF8
        lea.l        $ff1024.l, a0                                 ; $083BFC
        jsr          PrintCharacterMenuText.l                      ; $083C02
        move.l       $20(a7), d0                                   ; $083C08
        lea.l        $ff1024.l, a0                                 ; $083C0C
        jsr          FormatHexLong.l                               ; $083C12
        move.w       #$cca2, d0                                    ; $083C18
        lea.l        $ff1024.l, a0                                 ; $083C1C
        jsr          PrintCharacterMenuText.l                      ; $083C22
        rts                                                        ; $083C28
        ifne *-$83C2A
        fail "ROM end moved"
        endif
