; $00F030..$00F1CF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Cell interaction type $81 sets SceneExitRequested unconditionally; no enemy-count condition in this handler.
        ifne *-$F030
        fail "ROM start moved"
        endif

RequestEpisodeExit:
; Cell interaction type $81 sets SceneExitRequested unconditionally; no enemy-count condition in this handler.
        move.w       #$1, rSceneExitRequested(a6)                  ; $00F030
        rts                                                        ; $00F036

loc_00F038:
        clr.w        d0                                            ; $00F038
        jmp          SelectSceneColorMode.l                        ; $00F03A

loc_00F040:
        move.w       #$1, d0                                       ; $00F040
        jmp          SelectSceneColorMode.l                        ; $00F044

loc_00F04A:
        move.w       #$2, d0                                       ; $00F04A
        jmp          SelectSceneColorMode.l                        ; $00F04E

loc_00F054:
        move.w       #$3, d0                                       ; $00F054
        jmp          SelectSceneColorMode.l                        ; $00F058

loc_00F05E:
        move.w       rPlayerX(a6), d0                              ; $00F05E
        move.b       #$80, d0                                      ; $00F062
        move.w       rPlayerY(a6), d1                              ; $00F066
        move.b       #$80, d1                                      ; $00F06A
        sub.w        rPlayerX(a6), d0                              ; $00F06E
        sub.w        rPlayerY(a6), d1                              ; $00F072
        move.w       d0, d3                                        ; $00F076
        move.w       d1, d4                                        ; $00F078
        bsr.w        OctagonalDistance                             ; $00F07A
        tst.w        -$6f64(a6)                                    ; $00F07E
        bpl.b        loc_00F092                                    ; $00F082
        bsr.w        UiRoutine_00E000                              ; $00F084
        move.w       #$2a, d0                                      ; $00F088
        jmp          SoundRoutine_00DF84.l                         ; $00F08C

loc_00F092:
        jmp          UiRoutine_00E000.l                            ; $00F092

loc_00F098:
        rts                                                        ; $00F098

loc_00F09A:
; FLOOR NOT SECURED is a message path, not a return blocking the following lift-motion setup.
        move.l       d0, -(a7)                                     ; $00F09A
        tst.w        rFloorClearMessageTimer(a6)                   ; $00F09C
        bne.b        loc_00F0C0                                    ; $00F0A0
        move.w       rLegacyObjectiveFloor(a6), d0                 ; $00F0A2
        cmp.w        rCurrentFloor(a6), d0                         ; $00F0A6
        bne.b        loc_00F0C0                                    ; $00F0AA
        movem.l      a0-a1, -(a7)                                  ; $00F0AC
        movea.l      #StatusMessageFloorNotSecured, a0             ; $00F0B0
        jsr          QueueStatusMessage.l                          ; $00F0B6
        movem.l      (a7)+, a0-a1                                  ; $00F0BC

loc_00F0C0:
        move.l       (a7)+, d0                                     ; $00F0C0
        tst.w        -$6e4c(a6)                                    ; $00F0C2
        bne.b        loc_00F0F8                                    ; $00F0C6
        cmpi.w       #$42, -$55ae(a6)                              ; $00F0C8
        beq.b        loc_00F0E8                                    ; $00F0CE
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00F0D0
        jsr          PlayPendingSequence.l                         ; $00F0D4
        move.w       #$42, d0                                      ; $00F0DA
        jsr          loc_07ACE4.l                                  ; $00F0DE
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00F0E4

loc_00F0E8:
        move.w       #$1, -$6e4a(a6)                               ; $00F0E8
        move.w       #$66, d0                                      ; $00F0EE
        jmp          SoundRoutine_00DF84.l                         ; $00F0F2

loc_00F0F8:
        rts                                                        ; $00F0F8

loc_00F0FA:
        move.l       d0, -(a7)                                     ; $00F0FA
        tst.w        rFloorClearMessageTimer(a6)                   ; $00F0FC
        bne.b        loc_00F120                                    ; $00F100
        move.w       rLegacyObjectiveFloor(a6), d0                 ; $00F102
        cmp.w        rCurrentFloor(a6), d0                         ; $00F106
        bne.b        loc_00F120                                    ; $00F10A
        movem.l      a0-a1, -(a7)                                  ; $00F10C
        movea.l      #StatusMessageFloorNotSecured, a0             ; $00F110
        jsr          QueueStatusMessage.l                          ; $00F116
        movem.l      (a7)+, a0-a1                                  ; $00F11C

loc_00F120:
        move.l       (a7)+, d0                                     ; $00F120
        tst.w        -$6e4c(a6)                                    ; $00F122
        bne.b        loc_00F158                                    ; $00F126
        cmpi.w       #$42, -$55ae(a6)                              ; $00F128
        beq.b        loc_00F148                                    ; $00F12E
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00F130
        jsr          PlayPendingSequence.l                         ; $00F134
        move.w       #$42, d0                                      ; $00F13A
        jsr          loc_07ACE4.l                                  ; $00F13E
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00F144

loc_00F148:
        move.w       #$ffff, -$6e4a(a6)                            ; $00F148
        move.w       #$66, d0                                      ; $00F14E
        jmp          SoundRoutine_00DF84.l                         ; $00F152

loc_00F158:
        rts                                                        ; $00F158

loc_00F15A:
        move.l       d0, -(a7)                                     ; $00F15A
        tst.w        rFloorClearMessageTimer(a6)                   ; $00F15C
        bne.b        loc_00F180                                    ; $00F160
        move.w       rLegacyObjectiveFloor(a6), d0                 ; $00F162
        cmp.w        rCurrentFloor(a6), d0                         ; $00F166
        bne.b        loc_00F180                                    ; $00F16A
        movem.l      a0-a1, -(a7)                                  ; $00F16C
        movea.l      #StatusMessageFloorNotSecured, a0             ; $00F170
        jsr          QueueStatusMessage.l                          ; $00F176
        movem.l      (a7)+, a0-a1                                  ; $00F17C

loc_00F180:
        move.l       (a7)+, d0                                     ; $00F180
        tst.w        -$6e4c(a6)                                    ; $00F182
        bne.b        loc_00F1BE                                    ; $00F186
        cmpi.w       #$42, -$55ae(a6)                              ; $00F188
        beq.b        loc_00F1A8                                    ; $00F18E
        movem.l      d0-d7/a0-a5, -(a7)                            ; $00F190
        jsr          PlayPendingSequence.l                         ; $00F194
        move.w       #$42, d0                                      ; $00F19A
        jsr          loc_07ACE4.l                                  ; $00F19E
        movem.l      (a7)+, d0-d7/a0-a5                            ; $00F1A4

loc_00F1A8:
        tst.w        -$6e4a(a6)                                    ; $00F1A8
        bmi.b        loc_00F1C0                                    ; $00F1AC
        move.w       #$1, -$6e4a(a6)                               ; $00F1AE
        move.w       #$66, d0                                      ; $00F1B4
        jmp          SoundRoutine_00DF84.l                         ; $00F1B8

loc_00F1BE:
        rts                                                        ; $00F1BE

loc_00F1C0:
        move.w       #$ffff, -$6e4a(a6)                            ; $00F1C0
        move.w       #$66, d0                                      ; $00F1C6
        jmp          SoundRoutine_00DF84.l                         ; $00F1CA
        ifne *-$F1D0
        fail "ROM end moved"
        endif
