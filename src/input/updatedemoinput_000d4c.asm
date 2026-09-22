; $000D4C..$000DAD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Стейт-машина потока пада (запись/воспроизведение демо): по (-0x7924,A6) state 0→jmp $804 (опрос пада); декремент таймера (-0x7926,A6), флаг (-0x5594,A6); пишет/читает байт пад-состояния (-0x7fd2,A6) через указатель потока (-0x7922,A6)
        ifne *-$D4C
        fail "ROM start moved"
        endif

UpdateDemoInput:
        move.w       rDemoMode(a6), d0                             ; $000D4C
        beq.b        loc_000DA8                                    ; $000D50
        cmpi.w       #$1, d0                                       ; $000D52
        beq.b        loc_000D76                                    ; $000D56
        subq.w       #$1, rDemoFramesRemaining(a6)                 ; $000D58
        bne.b        loc_000D64                                    ; $000D5C
        move.w       #$1, rSceneExitRequested(a6)                  ; $000D5E

loc_000D64:
        bsr.w        ReadController                                ; $000D64
        movea.l      rDemoInputPointer(a6), a0                     ; $000D68
        move.b       rControllerState(a6), (a0)+                   ; $000D6C
        move.l       a0, rDemoInputPointer(a6)                     ; $000D70
        bra.b        loc_000DAC                                    ; $000D74

loc_000D76:
        subq.w       #$1, rDemoFramesRemaining(a6)                 ; $000D76
        bne.b        loc_000D82                                    ; $000D7A
        move.w       #$1, rSceneExitRequested(a6)                  ; $000D7C

loc_000D82:
        bsr.w        ReadController                                ; $000D82
        btst.b       #$7, rControllerState(a6)                     ; $000D86
        beq.b        loc_000D9A                                    ; $000D8C
        move.w       #$1, rSceneExitRequested(a6)                  ; $000D8E
        move.w       #$3, rDemoMode(a6)                            ; $000D94

loc_000D9A:
        movea.l      rDemoInputPointer(a6), a0                     ; $000D9A
        move.b       (a0)+, rControllerState(a6)                   ; $000D9E
        move.l       a0, rDemoInputPointer(a6)                     ; $000DA2
        bra.b        loc_000DAC                                    ; $000DA6

loc_000DA8:
        bra.w        ReadController                                ; $000DA8

loc_000DAC:
        rts                                                        ; $000DAC
        ifne *-$DAE
        fail "ROM end moved"
        endif
