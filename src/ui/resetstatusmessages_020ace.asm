; $020ACE..$020AE9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Сбрасывает очередь статусных сообщений, её экранный таймер, сценарий звуковых событий и cooldown эффектов.
        ifne *-$20ACE
        fail "ROM start moved"
        endif

ResetStatusMessages:
        clr.w        rStatusMessageQueueCount(a6)                                    ; $020ACE
        clr.w        rStatusMessageDisplayTicks(a6)                                    ; $020AD2
        move.w       #$ffff, rStatusSoundScript(a6)                            ; $020AD6
        clr.w        rStatusSoundScriptStepTicks(a6)                                    ; $020ADC
        clr.w        rStatusSoundScriptActive(a6)                                    ; $020AE0
        clr.w        rSoundEffectCooldown(a6)                                    ; $020AE4
        rts                                                        ; $020AE8
        ifne *-$20AEA
        fail "ROM end moved"
        endif
