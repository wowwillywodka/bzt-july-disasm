; $01D5CA..$01D5CF | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D3.w=type index with high byte0; replace low byte by binary EnemyWalkabilityClasses[type], return Z. Types2..5 block whole cells, unlike projectile/player half-cell tests.
        ifne *-$1D5CA
        fail "ROM start moved"
        endif

GetEnemyWalkability:
; D3.w=type index with high byte0; replace low byte by binary EnemyWalkabilityClasses[type], return Z. Types2..5 block whole cells, unlike projectile/player half-cell tests.
        move.b       EnemyWalkabilityClasses(pc, d3.w), d3         ; $01D5CA
        rts                                                        ; $01D5CE
        ifne *-$1D5D0
        fail "ROM end moved"
        endif
