; $098324..$0983DB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A1=eight texture-index bytes. Write each as a word to all four TextureOrder faces of raw cells $DA..$E1. This is RAM texture selection, not pixel/VRAM transfer.
        ifne *-$98324
        fail "ROM start moved"
        endif

ApplyTrainTextureStrip:
; A1=eight texture-index bytes. Write each as a word to all four TextureOrder faces of raw cells $DA..$E1. This is RAM texture selection, not pixel/VRAM transfer.
        lea.l        rTextureOrder(a6), a2                         ; $098324
        move.b       (a1)+, d0                                     ; $098328
        ext.w        d0                                            ; $09832A
        move.w       #TrainTextureOrderStart, d1  ; $09832C
        move.w       d0, (a2, d1.w)                                ; $098330
        move.w       d0, $2(a2, d1.w)                              ; $098334
        move.w       d0, $4(a2, d1.w)                              ; $098338
        move.w       d0, $6(a2, d1.w)                              ; $09833C
        move.b       (a1)+, d0                                     ; $098340
        move.w       #TrainTextureOrderStart+1*TextureOrderEntryBytes, d1  ; $098342
        move.w       d0, (a2, d1.w)                                ; $098346
        move.w       d0, $2(a2, d1.w)                              ; $09834A
        move.w       d0, $4(a2, d1.w)                              ; $09834E
        move.w       d0, $6(a2, d1.w)                              ; $098352
        move.b       (a1)+, d0                                     ; $098356
        move.w       #TrainTextureOrderStart+2*TextureOrderEntryBytes, d1  ; $098358
        move.w       d0, (a2, d1.w)                                ; $09835C
        move.w       d0, $2(a2, d1.w)                              ; $098360
        move.w       d0, $4(a2, d1.w)                              ; $098364
        move.w       d0, $6(a2, d1.w)                              ; $098368
        move.b       (a1)+, d0                                     ; $09836C
        move.w       #TrainTextureOrderStart+3*TextureOrderEntryBytes, d1  ; $09836E
        move.w       d0, (a2, d1.w)                                ; $098372
        move.w       d0, $2(a2, d1.w)                              ; $098376
        move.w       d0, $4(a2, d1.w)                              ; $09837A
        move.w       d0, $6(a2, d1.w)                              ; $09837E
        move.b       (a1)+, d0                                     ; $098382
        move.w       #TrainTextureOrderStart+4*TextureOrderEntryBytes, d1  ; $098384
        move.w       d0, (a2, d1.w)                                ; $098388
        move.w       d0, $2(a2, d1.w)                              ; $09838C
        move.w       d0, $4(a2, d1.w)                              ; $098390
        move.w       d0, $6(a2, d1.w)                              ; $098394
        move.b       (a1)+, d0                                     ; $098398
        move.w       #TrainTextureOrderStart+5*TextureOrderEntryBytes, d1  ; $09839A
        move.w       d0, (a2, d1.w)                                ; $09839E
        move.w       d0, $2(a2, d1.w)                              ; $0983A2
        move.w       d0, $4(a2, d1.w)                              ; $0983A6
        move.w       d0, $6(a2, d1.w)                              ; $0983AA
        move.b       (a1)+, d0                                     ; $0983AE
        move.w       #TrainTextureOrderStart+6*TextureOrderEntryBytes, d1  ; $0983B0
        move.w       d0, (a2, d1.w)                                ; $0983B4
        move.w       d0, $2(a2, d1.w)                              ; $0983B8
        move.w       d0, $4(a2, d1.w)                              ; $0983BC
        move.w       d0, $6(a2, d1.w)                              ; $0983C0
        move.b       (a1)+, d0                                     ; $0983C4
        move.w       #TrainTextureOrderStart+7*TextureOrderEntryBytes, d1  ; $0983C6
        move.w       d0, (a2, d1.w)                                ; $0983CA
        move.w       d0, $2(a2, d1.w)                              ; $0983CE
        move.w       d0, $4(a2, d1.w)                              ; $0983D2
        move.w       d0, $6(a2, d1.w)                              ; $0983D6
        rts                                                        ; $0983DA
        ifne *-$983DC
        fail "ROM end moved"
        endif
