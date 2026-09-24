; $00B400..$00B459 | m68k
; Maintained assembly input; no extraction occurs during build.
; Continuation of visible cell type $93 at $00B32A; not an independent handler.
        ifne *-$B400
        fail "ROM start moved"
        endif

FinishType93OpeningWallAlongY:
        addi.w       #$80, d1                                      ; $00B400
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B404
        movem.w      d0-d1, -(a7)                                  ; $00B408
        move.l       #$ff8eba, rCurrentWallTilePair(a6)            ; $00B40C
        bsr.w        ProjectWallFaceOnly                           ; $00B414
        asr.w        rWallTextureUStart(a6)                                    ; $00B418
        asr.w        rWallTextureUEnd(a6)                                    ; $00B41C
        bsr.w        DrawWallTextureSpan                           ; $00B420
        movem.w      (a7)+, d0-d1                                  ; $00B424
        move.w       (a7)+, d3                                     ; $00B428
        add.w        d3, d1                                        ; $00B42A
        add.w        d3, d1                                        ; $00B42C
        bsr.w        TransformSegmentEndpointBToCamera                        ; $00B42E
        addi.w       #$80, d1                                      ; $00B432
        bsr.w        TransformSegmentEndpointAToCamera                        ; $00B436
        move.l       #$ff8ec2, rCurrentWallTilePair(a6)            ; $00B43A
        bsr.w        ProjectWallFaceOnly                           ; $00B442
        asr.w        rWallTextureUStart(a6)                                    ; $00B446
        asr.w        rWallTextureUEnd(a6)                                    ; $00B44A
        bsr.w        DrawWallTextureSpan                           ; $00B44E
        movem.l      (a7)+, d0-d2/d4-d7/a0-a1/a4-a5                ; $00B452
        clr.w        d3                                            ; $00B456
        rts                                                        ; $00B458
        ifne *-$B45A
        fail "ROM end moved"
        endif
