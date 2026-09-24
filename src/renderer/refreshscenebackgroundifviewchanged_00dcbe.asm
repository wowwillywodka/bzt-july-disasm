; $00DCBE..$00DCC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: compare the vertical view offset with the last offset
; used for background resampling. On change, branch into the resampler.
; Profile changes use the separate force-refresh entry at $00DCB8.
        ifne *-$DCBE
        fail "ROM start moved"
        endif

RefreshSceneBackgroundIfViewChanged:
        move.w       rPlayerViewOffsetZ(a6), d0                                ; $00DCBE
        cmp.w        rBackgroundProfileViewOffsetZ(a6), d0                                ; $00DCC2
        bne.b        ResampleSceneBackgroundProfile                ; $00DCC6
        rts                                                        ; $00DCC8
        ifne *-$DCCA
        fail "ROM end moved"
        endif
