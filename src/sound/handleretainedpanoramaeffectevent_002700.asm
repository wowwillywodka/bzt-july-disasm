; $002700..$002733 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0=$10 checks the current cell and may apply a player hit; D0=$16 clears
; the retained effect flag. D0=$0A..$0F emits events $5F and $83. Other
; values return. This is an effect-event handler, not a GEMS dispatcher.
        ifne *-$2700
        fail "ROM start moved"
        endif

HandleRetainedPanoramaEffectEvent:
        cmpi.b       #$10, d0                                      ; $002700
        beq.b        CheckRetainedPanoramaCellHit                              ; $002704
        cmpi.b       #$16, d0                                      ; $002706
        beq.b        loc_00272E                                    ; $00270A
        cmpi.b       #$a, d0                                       ; $00270C
        bcs.b        loc_00272C                                    ; $002710
        cmpi.b       #$10, d0                                      ; $002712
        bcc.b        loc_00272C                                    ; $002716
        move.w       #$5f, d0                                      ; $002718
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $00271C
        move.w       #$83, d0                                      ; $002722
        jmp          PlaySoundEventAndMaybeSendLink.l                         ; $002726

loc_00272C:
        rts                                                        ; $00272C

loc_00272E:
        clr.b        rRetainedPanoramaEffectPending(a6)                                    ; $00272E
        rts                                                        ; $002732
        ifne *-$2734
        fail "ROM end moved"
        endif
