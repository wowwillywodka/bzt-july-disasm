; $01C3D4..$01C3DD | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; сеттеры дескрипторов спавн-клеточных врагов (@0xA7CA Red HP4.0/@0xA7E4 Purple HP4.0); НИШИ ставят 11 дескрипторов @0xA628-0xA7A4 (сеттеры 9418-94E0)
        ifne *-$1C3D4
        fail "ROM start moved"
        endif

EnemiesRoutine_01C3D4:
        movea.l      #ActorDeathDefinitions, a1                    ; $01C3D4
        bra.w        LoadActorDeathDefinition                      ; $01C3DA
        ifne *-$1C3DE
        fail "ROM end moved"
        endif
