; $0127D4..$0128AD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x12398] Подготовка блита спрайта объекта: берёт буфер кадра (-0x42bc,A6)+0x2400, из D5 считает масштаб (asr #2) и центрирует экранные X/Y (D2/D1), сбрасывает (-0x6f32,A6) и прыгает в блиттер 0xf8bc
        ifne *-$127D4
        fail "ROM start moved"
        endif

loc_0127D4:
        rts                                                        ; $0127D4

loc_0127D6:
        move.w       #$38, d0                                      ; $0127D6
        bra.b        loc_0127F2                                    ; $0127DA

loc_0127DC:
        move.b       #$0, (a0)                                     ; $0127DC
        jsr          CommitMapCellAndSendLink.l                    ; $0127E0
        move.w       #$1, rWallOpeningPermit(a6)                   ; $0127E6
        rts                                                        ; $0127EC

loc_0127EE:
        move.w       #$34, d0                                      ; $0127EE

loc_0127F2:
        lsr.w        #$2, d0                                       ; $0127F2
        movem.l      d0/a0, -(a7)                                  ; $0127F4
        bsr.w        UiRoutine_011C78                              ; $0127F8
        movem.l      (a7)+, d0/a0                                  ; $0127FC
        tst.w        d7                                            ; $012800
        bne.b        loc_012846                                    ; $012802
        addq.w       #$1, -$71cc(a6)                               ; $012804
        cmpa.l       #$ffa5fa, a0                                  ; $012808
        bcs.b        loc_012818                                    ; $01280E
        cmpa.l       #$ffe5fa, a0                                  ; $012810
        bcs.b        loc_01281E                                    ; $012816

loc_012818:
        movea.l      #$ffa9fa, a0                                  ; $012818

loc_01281E:
        clr.b        (a0)                                          ; $01281E
        jsr          CommitMapCellAndSendLink.l                    ; $012820
        move.w       d0, -(a7)                                     ; $012826
        move.w       #$60, d0                                      ; $012828
        jsr          SoundRoutine_00DF84.l                         ; $01282C
        move.w       (a7)+, d0                                     ; $012832
; Pickup message table indexed by actual item slot. Slot 4 says GUNROCK, slot 5 SNOWMAN; do not relabel their pixels from ZT editor names.
        movea.l      #ItemPickupMessagePointers, a0                ; $012834
        lsl.w        #$2, d0                                       ; $01283A
        adda.w       d0, a0                                        ; $01283C
        movea.l      (a0), a0                                      ; $01283E
        jmp          QueueStatusMessage.l                          ; $012840

loc_012846:
        rts                                                        ; $012846

loc_012848:
        cmpi.w       #$64, rPlayerHealth(a6)                       ; $012848
        beq.b        loc_0128A0                                    ; $01284E
        cmpa.l       #$ffa5fa, a0                                  ; $012850
        bcs.b        loc_012860                                    ; $012856
        cmpa.l       #$ffe5fa, a0                                  ; $012858
        bcs.b        loc_012866                                    ; $01285E

loc_012860:
        movea.l      #$ffa9fa, a0                                  ; $012860

loc_012866:
        clr.b        (a0)                                          ; $012866
        jsr          CommitMapCellAndSendLink.l                    ; $012868
        move.w       #$61, d0                                      ; $01286E
        jsr          SoundRoutine_00DF84.l                         ; $012872
        addq.w       #$1, -$71cc(a6)                               ; $012878
        addq.w       #$1, -$71bc(a6)                               ; $01287C
        movea.l      #StatusMessageMedipackCollected, a0           ; $012880
        jsr          QueueStatusMessage.l                          ; $012886
        cmpi.w       #$2, rSelectedCharacter(a6)                   ; $01288C
        beq.b        loc_0128A2                                    ; $012892
        addi.w       #$14, rPlayerHealth(a6)                       ; $012894
        jmp          UiRoutine_00E1E2.l                            ; $01289A

loc_0128A0:
        rts                                                        ; $0128A0

loc_0128A2:
        addi.w       #$28, rPlayerHealth(a6)                       ; $0128A2
        jmp          UiRoutine_00E1E2.l                            ; $0128A8
        ifne *-$128AE
        fail "ROM end moved"
        endif
