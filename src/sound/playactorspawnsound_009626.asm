; $009626..$009635 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: D0.w is ActorDefSpawnSound. Preserve A0/A1 across
; PlaySoundEventAndMaybeSendLink so spawn code retains actor and definition pointers.
        ifne *-$9626
        fail "ROM start moved"
        endif

PlayActorSpawnSound:
        movem.l      a0-a1, -(a7)                                  ; $009626
        jsr          PlaySoundEventAndMaybeSendLink.l                         ; $00962A
        movem.l      (a7)+, a0-a1                                  ; $009630
        rts                                                        ; $009634
        ifne *-$9636
        fail "ROM end moved"
        endif
