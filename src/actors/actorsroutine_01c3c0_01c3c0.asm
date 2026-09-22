; $01C3C0..$01C3C9 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 16E8E] актёрные хелперы (инит/освобождение, регион 16Dxx-16Exx)
        ifne *-$1C3C0
        fail "ROM start moved"
        endif

ActorsRoutine_01C3C0:
        movea.l      #ActorDefinitions, a1                         ; $01C3C0
        bra.w        LoadActorDefinition                           ; $01C3C6
        ifne *-$1C3CA
        fail "ROM end moved"
        endif
