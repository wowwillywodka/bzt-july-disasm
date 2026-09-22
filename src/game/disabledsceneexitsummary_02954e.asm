; $02954E..$02954F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Disabled exit-summary entry: single RTS. The next routine is the password-entry UI, not a fallthrough.
        ifne *-$2954E
        fail "ROM start moved"
        endif

DisabledSceneExitSummary:
; Disabled exit-summary entry: single RTS. The next routine is the password-entry UI, not a fallthrough.
        rts                                                        ; $02954E
        ifne *-$29550
        fail "ROM end moved"
        endif
