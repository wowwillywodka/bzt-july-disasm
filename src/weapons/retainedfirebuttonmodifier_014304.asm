; $014304..$014327 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$14304
        fail "ROM start moved"
        endif

RetainedFireButtonModifier:
        btst.b       #$0, rControllerState(a6)                     ; $014304
        beq.b        loc_01430E                                    ; $01430A
        addq.w       #$2, d2                                       ; $01430C

loc_01430E:
        btst.b       #$1, rControllerState(a6)                     ; $01430E
        beq.b        loc_014318                                    ; $014314
        subq.w       #$2, d2                                       ; $014316

loc_014318:
        btst.b       #$3, rControllerState(a6)                     ; $014318
        beq.b        loc_014322                                    ; $01431E
        subq.w       #$1, d2                                       ; $014320

loc_014322:
        move.w       d2, rUnarmedAttackVariant(a6)                 ; $014322

loc_014326:
        rts                                                        ; $014326
        ifne *-$14328
        fail "ROM end moved"
        endif
