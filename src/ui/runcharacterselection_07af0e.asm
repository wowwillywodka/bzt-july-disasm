; $07AF0E..$07B0D9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Five CHARACTER selection: index $FF105A, availability $FF2C36..$FF2C3A, names/biographies at $07B5E4. Former EpisodeSelection name was wrong.
        ifne *-$7AF0E
        fail "ROM start moved"
        endif

RunCharacterSelection:
; Five CHARACTER selection: index $FF105A, availability $FF2C36..$FF2C3A, names/biographies at $07B5E4. Former EpisodeSelection name was wrong.
        move.l       a1, -(a7)                                     ; $07AF0E
        jsr          ClearCram.l                                   ; $07AF10
        jsr          ClearAllVram.l                                ; $07AF16
        jsr          InitializeMenuVdp.l                           ; $07AF1C
        move.w       #$9011, VDP_CONTROL.l                         ; $07AF22
        move.w       #$0, $ff2a4e.l                                ; $07AF2A
        jsr          DrawCharacterSelectionScreen.l                ; $07AF32
        move.w       #$e102, $ff2a4c.l                             ; $07AF38
        move.w       ramSelectedCharacter.l, d0                    ; $07AF40
        lsl.w        #$2, d0                                       ; $07AF46
        lea.l        CharacterMenuPortraitPalettePointers(pc), a0  ; $07AF48
        movea.l      (a0, d0.w), a0                                ; $07AF4C
        adda.l       #$20, a0                                      ; $07AF50
        move.w       #$b, d1                                       ; $07AF56
        move.w       #$40, d2                                      ; $07AF5A
        lea.l        CharacterMenuPortraitTileBases(pc), a1        ; $07AF5E
        lsr.w        #$1, d0                                       ; $07AF62
        move.w       (a1, d0.w), d3                                ; $07AF64
        move.w       #$10, d0                                      ; $07AF68
        movea.w      #$e102, a1                                    ; $07AF6C
        jsr          UploadAttributedTilemap.l                     ; $07AF70
        jsr          DrawCharacterDescription.l                    ; $07AF76
        move.w       ramSelectedCharacter.l, d0                    ; $07AF7C
        lea.l        ramCharacterAvailable0.l, a0                  ; $07AF82
        cmpi.b       #$1, (a0, d0.w)                               ; $07AF88
        beq.w        loc_07AF98                                    ; $07AF8E
        jsr          UploadCharacterMenuPanel.l                    ; $07AF92

loc_07AF98:
        jsr          DrawCharacterBiographyTail.l                  ; $07AF98
        move.w       #$4, d1                                       ; $07AF9E
        lea.l        $ff0778.l, a0                                 ; $07AFA2
        jsr          loc_022010.l                                  ; $07AFA8

loc_07AFAE:
        jsr          WaitForVBlank.l                               ; $07AFAE
        movea.l      (a7), a1                                      ; $07AFB4
; Callback A1 saved at entry $7AF0E. Both decoded callers pass ActorNoOp ($1BEBC).
        jsr          (a1)                                          ; $07AFB6
        jsr          ReadController.l                              ; $07AFB8
        btst.b       #$0, ramControllerState.l                     ; $07AFBE
        beq.w        loc_07B000                                    ; $07AFC6
        btst.b       #$0, ramPreviousControllerState.l             ; $07AFCA
        bne.w        loc_07B000                                    ; $07AFD2
        move.w       #$62, d0                                      ; $07AFD6
        jsr          PlaySoundEvent(pc)                            ; $07AFDA
        addq.w       #$1, ramSelectedCharacter.l                   ; $07AFDE
        cmpi.w       #$5, ramSelectedCharacter.l                   ; $07AFE4
        bcs.w        loc_07AFF8                                    ; $07AFEC
        move.w       #$0, ramSelectedCharacter.l                   ; $07AFF0

loc_07AFF8:
        jsr          ScrollCharacterMenuDown.l                     ; $07AFF8
        bra.b        loc_07AFAE                                    ; $07AFFE

loc_07B000:
        btst.b       #$1, ramControllerState.l                     ; $07B000
        beq.w        loc_07B03C                                    ; $07B008
        btst.b       #$1, ramPreviousControllerState.l             ; $07B00C
        bne.w        loc_07B03C                                    ; $07B014
        move.w       #$62, d0                                      ; $07B018
        jsr          PlaySoundEvent(pc)                            ; $07B01C
        subq.w       #$1, ramSelectedCharacter.l                   ; $07B020
        bpl.w        loc_07B032                                    ; $07B026
        move.w       #$4, ramSelectedCharacter.l                   ; $07B02A

loc_07B032:
        jsr          ScrollCharacterMenuUp.l                       ; $07B032
        bra.w        loc_07AFAE                                    ; $07B038

loc_07B03C:
        btst.b       #$6, ramControllerState.l                     ; $07B03C
        beq.w        loc_07B054                                    ; $07B044
        btst.b       #$6, ramPreviousControllerState.l             ; $07B048
        beq.w        loc_07B09C                                    ; $07B050

loc_07B054:
        btst.b       #$4, ramControllerState.l                     ; $07B054
        beq.w        loc_07B06C                                    ; $07B05C
        btst.b       #$4, ramPreviousControllerState.l             ; $07B060
        beq.w        loc_07B09C                                    ; $07B068

loc_07B06C:
        btst.b       #$5, ramControllerState.l                     ; $07B06C
        beq.w        loc_07B084                                    ; $07B074
        btst.b       #$5, ramPreviousControllerState.l             ; $07B078
        beq.w        loc_07B09C                                    ; $07B080

loc_07B084:
        btst.b       #$7, ramControllerState.l                     ; $07B084
        beq.w        loc_07AFAE                                    ; $07B08C
        btst.b       #$7, ramPreviousControllerState.l             ; $07B090
        bne.w        loc_07AFAE                                    ; $07B098

loc_07B09C:
        lea.l        ramCharacterAvailable0.l, a0                  ; $07B09C
        move.w       ramSelectedCharacter.l, d0                    ; $07B0A2
        cmpi.b       #$1, (a0, d0.w)                               ; $07B0A8
        beq.w        loc_07B0BE                                    ; $07B0AE
        move.w       #$60, d0                                      ; $07B0B2
        jsr          PlaySoundEvent(pc)                            ; $07B0B6
        bra.w        loc_07AFAE                                    ; $07B0BA

loc_07B0BE:
        move.w       #$62, d0                                      ; $07B0BE
        jsr          PlaySoundEvent(pc)                            ; $07B0C2
        move.w       #$4, d1                                       ; $07B0C6
        lea.l        $ff0778.l, a0                                 ; $07B0CA
        jsr          VideoRoutine_022018.l                         ; $07B0D0
        addq.l       #$4, a7                                       ; $07B0D6
        rts                                                        ; $07B0D8
        ifne *-$7B0DA
        fail "ROM end moved"
        endif
