; $01C3D4..$01C3DD | m68k
; Maintained assembly input; no extraction occurs during build.
; On disconnect load the first regular/death actor definition.
        ifne *-$1C3D4
        fail "ROM start moved"
        endif

; Remote kinds $0E and $1C..$30 use the first death definition.
LoadFirstActorDeathDefinitionOnDisconnect:
        movea.l      #ActorDeathDefinitions, a1                    ; $01C3D4
        bra.w        LoadActorDeathDefinition                      ; $01C3DA
        ifne *-$1C3DE
        fail "ROM end moved"
        endif
