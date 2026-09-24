; $01C3C0..$01C3C9 | m68k
; Maintained assembly input; no extraction occurs during build.
; On disconnect load the first regular/death actor definition.
        ifne *-$1C3C0
        fail "ROM start moved"
        endif

; Remote kinds $0D and $0F..$1B use the first regular actor definition.
LoadFirstActorDefinitionOnDisconnect:
        movea.l      #ActorDefinitions, a1                         ; $01C3C0
        bra.w        LoadActorDefinition                           ; $01C3C6
        ifne *-$1C3CA
        fail "ROM end moved"
        endif
