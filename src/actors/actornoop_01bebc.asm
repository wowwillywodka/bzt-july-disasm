; $01BEBC..$01BEBD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: default no-op callback installed by AllocateActor.
        ifne *-$1BEBC
        fail "ROM start moved"
        endif

ActorNoOp:
; Shared RTS for UpdateActors; actor callback tables also use it as an intentional no-op.
        rts                                                        ; $01BEBC
        ifne *-$1BEBE
        fail "ROM end moved"
        endif
