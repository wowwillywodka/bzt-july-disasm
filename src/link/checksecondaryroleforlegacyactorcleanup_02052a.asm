; $02052A..$020533 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: link command $19. Only secondary role 2 enters the
; legacy actor-callback scan. The scan cannot take its removal branch because
; it compares the same longword with two distinct addresses.
        ifne *-$2052A
        fail "ROM start moved"
        endif

CheckSecondaryRoleForLegacyActorCleanup:
        cmpi.w       #$2, rLinkRole(a6)                            ; $02052A
        beq.b        ScanActorsForLegacyExitCallbacks                         ; $020530
        rts                                                        ; $020532
        ifne *-$20534
        fail "ROM end moved"
        endif
