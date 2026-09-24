; $0141EC..$01422D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; On miss, sample 32 forward steps in visible map using 8x fixed coordinates. First blocked point spawns impact at PREVIOUS clear position; this trace does not search actors.
        ifne *-$141EC
        fail "ROM start moved"
        endif

TraceMissedShotAndSpawnImpact:
; On miss, sample 32 forward steps in visible map using 8x fixed coordinates. First blocked point spawns impact at PREVIOUS clear position; this trace does not search actors.
        move.w       rPlayerX(a6), d3                              ; $0141EC
        move.w       rPlayerY(a6), d4                              ; $0141F0
        ext.l        d3                                            ; $0141F4
        ext.l        d4                                            ; $0141F6
        lsl.l        #$3, d3                                       ; $0141F8
        lsl.l        #$3, d4                                       ; $0141FA
        move.w       rPlayerFacingVectorX(a6), d5                                ; $0141FC
        move.w       rPlayerFacingVectorY(a6), d6                                ; $014200
        ext.l        d5                                            ; $014204
        ext.l        d6                                            ; $014206
        move.w       #$1f, d7                                      ; $014208

loc_01420C:
        move.l       d3, d0                                        ; $01420C
        move.l       d4, d1                                        ; $01420E
        add.l        d5, d0                                        ; $014210
        add.l        d6, d1                                        ; $014212
        asr.l        #$3, d0                                       ; $014214
        asr.l        #$3, d1                                       ; $014216
        move.l       d3, -(a7)                                     ; $014218
        jsr          TestProjectilePointInVisibleMap.l             ; $01421A
        bne.b        SpawnMissedShotImpact                         ; $014220
        move.l       (a7)+, d3                                     ; $014222
        add.l        d5, d3                                        ; $014224
        add.l        d6, d4                                        ; $014226
        dbra         d7, loc_01420C                                ; $014228

loc_01422C:
        rts                                                        ; $01422C
        ifne *-$1422E
        fail "ROM end moved"
        endif
