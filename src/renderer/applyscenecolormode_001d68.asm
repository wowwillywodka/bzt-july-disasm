; $001D68..$002029 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Apply scene color mode 0..4 (larger values become 0). Select sprite/wall color remaps, background profile and wall scaler family. See docs/WALL_GRAPHICS.md.
        ifne *-$1D68
        fail "ROM start moved"
        endif

ApplySceneColorMode:
; Apply scene color mode 0..4 (larger values become 0). Select sprite/wall color remaps, background profile and wall scaler family. See docs/WALL_GRAPHICS.md.
        cmpi.w       #$4, d0                                       ; $001D68
        bls.b        loc_001D70                                    ; $001D6C
        clr.w        d0                                            ; $001D6E

loc_001D70:
        cmp.w        rSceneColorMode(a6), d0                       ; $001D70
        bne.b        loc_001D78                                    ; $001D74
        rts                                                        ; $001D76

loc_001D78:
        move.w       d0, rSceneColorMode(a6)                       ; $001D78
        beq.w        loc_001ECE                                    ; $001D7C
        cmpi.w       #$1, d0                                       ; $001D80
        beq.w        loc_001E36                                    ; $001D84
        cmpi.w       #$3, d0                                       ; $001D88
        beq.w        loc_001EFA                                    ; $001D8C
        cmpi.w       #$4, d0                                       ; $001D90
        beq.w        loc_001F92                                    ; $001D94
        move.l       rZoneWallColorRemaps(a6), d1                  ; $001D98
        addi.l       #$800, d1                                     ; $001D9C
        move.l       d1, rActiveWallColorRemap0(a6)                ; $001DA2
        addi.l       #$100, d1                                     ; $001DA6
        move.l       d1, rActiveWallColorRemap1(a6)                ; $001DAC
        addi.l       #$100, d1                                     ; $001DB0
        move.l       d1, rActiveWallColorRemap2(a6)                ; $001DB6
        addi.l       #$100, d1                                     ; $001DBA
        move.l       d1, rActiveWallColorRemap3(a6)                ; $001DC0
        addi.l       #$100, d1                                     ; $001DC4
        move.l       d1, rActiveWallColorRemap4(a6)                ; $001DCA
        addi.l       #$100, d1                                     ; $001DCE
        move.l       d1, rActiveWallColorRemap5(a6)                ; $001DD4
        addi.l       #$100, d1                                     ; $001DD8
        move.l       d1, rActiveWallColorRemap6(a6)                ; $001DDE
        addi.l       #$100, d1                                     ; $001DE2
        move.l       d1, rActiveWallColorRemap7(a6)                ; $001DE8
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $001DEC
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $001DF0
        addi.l       #$600, d1                                     ; $001DF4
        move.l       d1, (a0)+                                     ; $001DFA
        addi.l       #$100, d1                                     ; $001DFC
        move.l       d1, (a0)+                                     ; $001E02
        addi.l       #$100, d1                                     ; $001E04
        move.l       d1, (a0)+                                     ; $001E0A
        addi.l       #$100, d1                                     ; $001E0C
        move.l       d1, (a0)+                                     ; $001E12
        addi.l       #$100, d1                                     ; $001E14
        move.l       d1, (a0)                                      ; $001E1A
        move.l       #WallColumnScalers, rWallColumnScalerTable(a6) ; $001E1C
        move.l       rZoneBackgroundProfile2(a6), rActiveSceneBackgroundProfile(a6) ; $001E24
        move.w       #$5, -$7122(a6)                               ; $001E2A
        jmp          loc_00DCB8.l                                  ; $001E30

loc_001E36:
        move.l       rZoneWallColorRemaps(a6), d1                  ; $001E36
        move.l       d1, rActiveWallColorRemap0(a6)                ; $001E3A
        addi.l       #$100, d1                                     ; $001E3E
        move.l       d1, rActiveWallColorRemap1(a6)                ; $001E44
        addi.l       #$100, d1                                     ; $001E48
        move.l       d1, rActiveWallColorRemap2(a6)                ; $001E4E
        addi.l       #$100, d1                                     ; $001E52
        move.l       d1, rActiveWallColorRemap3(a6)                ; $001E58
        addi.l       #$100, d1                                     ; $001E5C
        move.l       d1, rActiveWallColorRemap4(a6)                ; $001E62
        addi.l       #$100, d1                                     ; $001E66
        move.l       d1, rActiveWallColorRemap5(a6)                ; $001E6C
        addi.l       #$100, d1                                     ; $001E70
        move.l       d1, rActiveWallColorRemap6(a6)                ; $001E76
        addi.l       #$100, d1                                     ; $001E7A
        move.l       d1, rActiveWallColorRemap7(a6)                ; $001E80
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $001E84
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $001E88
        addi.l       #$100, d1                                     ; $001E8C
        move.l       d1, (a0)+                                     ; $001E92
        addi.l       #$100, d1                                     ; $001E94
        move.l       d1, (a0)+                                     ; $001E9A
        addi.l       #$100, d1                                     ; $001E9C
        move.l       d1, (a0)+                                     ; $001EA2
        addi.l       #$100, d1                                     ; $001EA4
        move.l       d1, (a0)+                                     ; $001EAA
        addi.l       #$100, d1                                     ; $001EAC
        move.l       d1, (a0)                                      ; $001EB2
        move.l       #WallColumnScalers, rWallColumnScalerTable(a6) ; $001EB4
        move.l       rZoneBackgroundProfile1(a6), rActiveSceneBackgroundProfile(a6) ; $001EBC
        move.w       #$5, -$7122(a6)                               ; $001EC2
        jmp          loc_00DCB8.l                                  ; $001EC8

loc_001ECE:
; Mode 0: sprite remap page 0 and direct-copy wall scalers; background profile 0. Existing wall LUT pointers are not rewritten or consumed by that scaler family.
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $001ECE
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $001ED2
        move.l       d1, (a0)+                                     ; $001ED6
        move.l       d1, (a0)+                                     ; $001ED8
        move.l       d1, (a0)+                                     ; $001EDA
        move.l       d1, (a0)+                                     ; $001EDC
        move.l       d1, (a0)                                      ; $001EDE
        move.l       #AlternateWallColumnScalers, rWallColumnScalerTable(a6) ; $001EE0
        move.l       rZoneBackgroundProfile0(a6), rActiveSceneBackgroundProfile(a6) ; $001EE8
        move.w       #$10, -$7122(a6)                              ; $001EEE
        jmp          loc_00DCB8.l                                  ; $001EF4

loc_001EFA:
        move.l       rZoneWallColorRemaps(a6), d1                  ; $001EFA
        move.l       d1, rActiveWallColorRemap0(a6)                ; $001EFE
        addi.l       #$100, d1                                     ; $001F02
        move.l       d1, rActiveWallColorRemap1(a6)                ; $001F08
        addi.l       #$100, d1                                     ; $001F0C
        move.l       d1, rActiveWallColorRemap2(a6)                ; $001F12
        addi.l       #$100, d1                                     ; $001F16
        move.l       d1, rActiveWallColorRemap3(a6)                ; $001F1C
        addi.l       #$100, d1                                     ; $001F20
        move.l       d1, rActiveWallColorRemap4(a6)                ; $001F26
        addi.l       #$100, d1                                     ; $001F2A
        move.l       d1, rActiveWallColorRemap5(a6)                ; $001F30
        addi.l       #$100, d1                                     ; $001F34
        move.l       d1, rActiveWallColorRemap6(a6)                ; $001F3A
        addi.l       #$100, d1                                     ; $001F3E
        move.l       d1, rActiveWallColorRemap7(a6)                ; $001F44
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $001F48
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $001F4C
        addi.l       #$100, d1                                     ; $001F50
        move.l       d1, (a0)+                                     ; $001F56
        addi.l       #$100, d1                                     ; $001F58
        move.l       d1, (a0)+                                     ; $001F5E
        addi.l       #$100, d1                                     ; $001F60
        move.l       d1, (a0)+                                     ; $001F66
        addi.l       #$100, d1                                     ; $001F68
        move.l       d1, (a0)+                                     ; $001F6E
        addi.l       #$100, d1                                     ; $001F70
        move.l       d1, (a0)                                      ; $001F76
        move.l       #WallColumnScalers, rWallColumnScalerTable(a6) ; $001F78
        move.l       rZoneBackgroundProfile3(a6), rActiveSceneBackgroundProfile(a6) ; $001F80
        move.w       #$c, -$7122(a6)                               ; $001F86
        jmp          loc_00DCB8.l                                  ; $001F8C

loc_001F92:
        move.l       rZoneWallColorRemaps(a6), d1                  ; $001F92
        move.l       d1, rActiveWallColorRemap0(a6)                ; $001F96
        addi.l       #$100, d1                                     ; $001F9A
        move.l       d1, rActiveWallColorRemap1(a6)                ; $001FA0
        addi.l       #$100, d1                                     ; $001FA4
        move.l       d1, rActiveWallColorRemap2(a6)                ; $001FAA
        addi.l       #$100, d1                                     ; $001FAE
        move.l       d1, rActiveWallColorRemap3(a6)                ; $001FB4
        addi.l       #$100, d1                                     ; $001FB8
        move.l       d1, rActiveWallColorRemap4(a6)                ; $001FBE
        addi.l       #$100, d1                                     ; $001FC2
        move.l       d1, rActiveWallColorRemap5(a6)                ; $001FC8
        addi.l       #$100, d1                                     ; $001FCC
        move.l       d1, rActiveWallColorRemap6(a6)                ; $001FD2
        addi.l       #$100, d1                                     ; $001FD6
        move.l       d1, rActiveWallColorRemap7(a6)                ; $001FDC
        lea.l        rActiveSpriteColorRemaps(a6), a0              ; $001FE0
        move.l       rZoneSpriteColorRemaps(a6), d1                ; $001FE4
        addi.l       #$100, d1                                     ; $001FE8
        move.l       d1, (a0)+                                     ; $001FEE
        addi.l       #$100, d1                                     ; $001FF0
        move.l       d1, (a0)+                                     ; $001FF6
        addi.l       #$100, d1                                     ; $001FF8
        move.l       d1, (a0)+                                     ; $001FFE
        addi.l       #$100, d1                                     ; $002000
        move.l       d1, (a0)+                                     ; $002006
        addi.l       #$100, d1                                     ; $002008
        move.l       d1, (a0)                                      ; $00200E
        move.l       #WallColumnScalers, rWallColumnScalerTable(a6) ; $002010
        move.l       rZoneBackgroundProfile4(a6), rActiveSceneBackgroundProfile(a6) ; $002018
        move.w       #$5, -$7122(a6)                               ; $00201E
        jmp          loc_00DCB8.l                                  ; $002024
        ifne *-$202A
        fail "ROM end moved"
        endif
