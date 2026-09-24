; $0041D2..$0078BB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; This partition contains unrolled scaler entries for indices 1..40 of the
; normal table and the direct-byte alternatives for indices 1..23. A compact
; entry calls the background-copy suffix at 4(SP), writes 2*n wall bytes,
; advances A5 by 2*n, then jumps to the suffix at 8(SP). Indices 38..40
; instead write all 80 output positions directly. See docs/WALL_SCALERS.md.
        ifne *-$41D2
        fail "ROM start moved"
        endif

ScaleTextureColumns:
        movea.l      $4(a7), a3                                    ; $0041D2
        jsr          (a3)                                          ; $0041D6
; Wall remap page selected by scaler height: a packed source byte indexes a 256-byte color lookup; the mapped byte goes to the framebuffer.
        movea.l      rActiveWallColorRemap7(a6), a3                ; $0041D8
        clr.w        d0                                            ; $0041DC
        move.b       $10(a1), d0                                   ; $0041DE
        move.b       (a3, d0.w), (a0)                              ; $0041E2
        addq.w       #$4, a0                                       ; $0041E6
        move.b       $10(a2), d0                                   ; $0041E8
        move.b       (a3, d0.w), (a0)                              ; $0041EC
        addq.w       #$4, a0                                       ; $0041F0
        lea.l        $2(a5), a5                                    ; $0041F2
        movea.l      $8(a7), a3                                    ; $0041F6
        jmp          (a3)                                          ; $0041FA

loc_0041FC:
        movea.l      $4(a7), a3                                    ; $0041FC
        jsr          (a3)                                          ; $004200
        movea.l      rActiveWallColorRemap7(a6), a3                ; $004202
        clr.w        d0                                            ; $004206
        move.b       $8(a1), d0                                    ; $004208
        move.b       (a3, d0.w), (a0)                              ; $00420C
        addq.w       #$4, a0                                       ; $004210
        move.b       $18(a1), d0                                   ; $004212
        move.b       (a3, d0.w), (a0)                              ; $004216
        addq.w       #$4, a0                                       ; $00421A
        move.b       $8(a2), d0                                    ; $00421C
        move.b       (a3, d0.w), (a0)                              ; $004220
        addq.w       #$4, a0                                       ; $004224
        move.b       $18(a2), d0                                   ; $004226
        move.b       (a3, d0.w), (a0)                              ; $00422A
        addq.w       #$4, a0                                       ; $00422E
        lea.l        $4(a5), a5                                    ; $004230
        movea.l      $8(a7), a3                                    ; $004234
        jmp          (a3)                                          ; $004238

loc_00423A:
        movea.l      $4(a7), a3                                    ; $00423A
        jsr          (a3)                                          ; $00423E
        movea.l      rActiveWallColorRemap7(a6), a3                ; $004240
        clr.w        d0                                            ; $004244
        move.b       $5(a1), d0                                    ; $004246
        move.b       (a3, d0.w), (a0)                              ; $00424A
        addq.w       #$4, a0                                       ; $00424E
        move.b       $10(a1), d0                                   ; $004250
        move.b       (a3, d0.w), (a0)                              ; $004254
        addq.w       #$4, a0                                       ; $004258
        move.b       $1a(a1), d0                                   ; $00425A
        move.b       (a3, d0.w), (a0)                              ; $00425E
        addq.w       #$4, a0                                       ; $004262
        move.b       $5(a2), d0                                    ; $004264
        move.b       (a3, d0.w), (a0)                              ; $004268
        addq.w       #$4, a0                                       ; $00426C
        move.b       $10(a2), d0                                   ; $00426E
        move.b       (a3, d0.w), (a0)                              ; $004272
        addq.w       #$4, a0                                       ; $004276
        move.b       $1a(a2), d0                                   ; $004278
        move.b       (a3, d0.w), (a0)                              ; $00427C
        addq.w       #$4, a0                                       ; $004280
        lea.l        $6(a5), a5                                    ; $004282
        movea.l      $8(a7), a3                                    ; $004286
        jmp          (a3)                                          ; $00428A

loc_00428C:
        movea.l      $4(a7), a3                                    ; $00428C
        jsr          (a3)                                          ; $004290
        movea.l      rActiveWallColorRemap7(a6), a3                ; $004292
        clr.w        d0                                            ; $004296
        move.b       $4(a1), d0                                    ; $004298
        move.b       (a3, d0.w), (a0)                              ; $00429C
        addq.w       #$4, a0                                       ; $0042A0
        move.b       $c(a1), d0                                    ; $0042A2
        move.b       (a3, d0.w), (a0)                              ; $0042A6
        addq.w       #$4, a0                                       ; $0042AA
        move.b       $14(a1), d0                                   ; $0042AC
        move.b       (a3, d0.w), (a0)                              ; $0042B0
        addq.w       #$4, a0                                       ; $0042B4
        move.b       $1c(a1), d0                                   ; $0042B6
        move.b       (a3, d0.w), (a0)                              ; $0042BA
        addq.w       #$4, a0                                       ; $0042BE
        move.b       $4(a2), d0                                    ; $0042C0
        move.b       (a3, d0.w), (a0)                              ; $0042C4
        addq.w       #$4, a0                                       ; $0042C8
        move.b       $c(a2), d0                                    ; $0042CA
        move.b       (a3, d0.w), (a0)                              ; $0042CE
        addq.w       #$4, a0                                       ; $0042D2
        move.b       $14(a2), d0                                   ; $0042D4
        move.b       (a3, d0.w), (a0)                              ; $0042D8
        addq.w       #$4, a0                                       ; $0042DC
        move.b       $1c(a2), d0                                   ; $0042DE
        move.b       (a3, d0.w), (a0)                              ; $0042E2
        addq.w       #$4, a0                                       ; $0042E6
        lea.l        $8(a5), a5                                    ; $0042E8
        movea.l      $8(a7), a3                                    ; $0042EC
        jmp          (a3)                                          ; $0042F0

loc_0042F2:
        movea.l      $4(a7), a3                                    ; $0042F2
        jsr          (a3)                                          ; $0042F6
        movea.l      rActiveWallColorRemap6(a6), a3                ; $0042F8
        clr.w        d0                                            ; $0042FC
        move.b       $3(a1), d0                                    ; $0042FE
        move.b       (a3, d0.w), (a0)                              ; $004302
        addq.w       #$4, a0                                       ; $004306
        move.b       $9(a1), d0                                    ; $004308
        move.b       (a3, d0.w), (a0)                              ; $00430C
        addq.w       #$4, a0                                       ; $004310
        move.b       $10(a1), d0                                   ; $004312
        move.b       (a3, d0.w), (a0)                              ; $004316
        addq.w       #$4, a0                                       ; $00431A
        move.b       $16(a1), d0                                   ; $00431C
        move.b       (a3, d0.w), (a0)                              ; $004320
        addq.w       #$4, a0                                       ; $004324
        move.b       $1c(a1), d0                                   ; $004326
        move.b       (a3, d0.w), (a0)                              ; $00432A
        addq.w       #$4, a0                                       ; $00432E
        move.b       $3(a2), d0                                    ; $004330
        move.b       (a3, d0.w), (a0)                              ; $004334
        addq.w       #$4, a0                                       ; $004338
        move.b       $9(a2), d0                                    ; $00433A
        move.b       (a3, d0.w), (a0)                              ; $00433E
        addq.w       #$4, a0                                       ; $004342
        move.b       $10(a2), d0                                   ; $004344
        move.b       (a3, d0.w), (a0)                              ; $004348
        addq.w       #$4, a0                                       ; $00434C
        move.b       $16(a2), d0                                   ; $00434E
        move.b       (a3, d0.w), (a0)                              ; $004352
        addq.w       #$4, a0                                       ; $004356
        move.b       $1c(a2), d0                                   ; $004358
        move.b       (a3, d0.w), (a0)                              ; $00435C
        addq.w       #$4, a0                                       ; $004360
        lea.l        $a(a5), a5                                    ; $004362
        movea.l      $8(a7), a3                                    ; $004366
        jmp          (a3)                                          ; $00436A

loc_00436C:
        movea.l      $4(a7), a3                                    ; $00436C
        jsr          (a3)                                          ; $004370
        movea.l      rActiveWallColorRemap6(a6), a3                ; $004372
        clr.w        d0                                            ; $004376
        move.b       $2(a1), d0                                    ; $004378
        move.b       (a3, d0.w), (a0)                              ; $00437C
        addq.w       #$4, a0                                       ; $004380
        move.b       $8(a1), d0                                    ; $004382
        move.b       (a3, d0.w), (a0)                              ; $004386
        addq.w       #$4, a0                                       ; $00438A
        move.b       $d(a1), d0                                    ; $00438C
        move.b       (a3, d0.w), (a0)                              ; $004390
        addq.w       #$4, a0                                       ; $004394
        move.b       $12(a1), d0                                   ; $004396
        move.b       (a3, d0.w), (a0)                              ; $00439A
        addq.w       #$4, a0                                       ; $00439E
        move.b       $18(a1), d0                                   ; $0043A0
        move.b       (a3, d0.w), (a0)                              ; $0043A4
        addq.w       #$4, a0                                       ; $0043A8
        move.b       $1d(a1), d0                                   ; $0043AA
        move.b       (a3, d0.w), (a0)                              ; $0043AE
        addq.w       #$4, a0                                       ; $0043B2
        move.b       $2(a2), d0                                    ; $0043B4
        move.b       (a3, d0.w), (a0)                              ; $0043B8
        addq.w       #$4, a0                                       ; $0043BC
        move.b       $8(a2), d0                                    ; $0043BE
        move.b       (a3, d0.w), (a0)                              ; $0043C2
        addq.w       #$4, a0                                       ; $0043C6
        move.b       $d(a2), d0                                    ; $0043C8
        move.b       (a3, d0.w), (a0)                              ; $0043CC
        addq.w       #$4, a0                                       ; $0043D0
        move.b       $12(a2), d0                                   ; $0043D2
        move.b       (a3, d0.w), (a0)                              ; $0043D6
        addq.w       #$4, a0                                       ; $0043DA
        move.b       $18(a2), d0                                   ; $0043DC
        move.b       (a3, d0.w), (a0)                              ; $0043E0
        addq.w       #$4, a0                                       ; $0043E4
        move.b       $1d(a2), d0                                   ; $0043E6
        move.b       (a3, d0.w), (a0)                              ; $0043EA
        addq.w       #$4, a0                                       ; $0043EE
        lea.l        $c(a5), a5                                    ; $0043F0
        movea.l      $8(a7), a3                                    ; $0043F4
        jmp          (a3)                                          ; $0043F8

loc_0043FA:
        movea.l      $4(a7), a3                                    ; $0043FA
        jsr          (a3)                                          ; $0043FE
        movea.l      rActiveWallColorRemap6(a6), a3                ; $004400
        clr.w        d0                                            ; $004404
        move.b       $2(a1), d0                                    ; $004406
        move.b       (a3, d0.w), (a0)                              ; $00440A
        addq.w       #$4, a0                                       ; $00440E
        move.b       $6(a1), d0                                    ; $004410
        move.b       (a3, d0.w), (a0)                              ; $004414
        addq.w       #$4, a0                                       ; $004418
        move.b       $b(a1), d0                                    ; $00441A
        move.b       (a3, d0.w), (a0)                              ; $00441E
        addq.w       #$4, a0                                       ; $004422
        move.b       $10(a1), d0                                   ; $004424
        move.b       (a3, d0.w), (a0)                              ; $004428
        addq.w       #$4, a0                                       ; $00442C
        move.b       $14(a1), d0                                   ; $00442E
        move.b       (a3, d0.w), (a0)                              ; $004432
        addq.w       #$4, a0                                       ; $004436
        move.b       $19(a1), d0                                   ; $004438
        move.b       (a3, d0.w), (a0)                              ; $00443C
        addq.w       #$4, a0                                       ; $004440
        move.b       $1d(a1), d0                                   ; $004442
        move.b       (a3, d0.w), (a0)                              ; $004446
        addq.w       #$4, a0                                       ; $00444A
        move.b       $2(a2), d0                                    ; $00444C
        move.b       (a3, d0.w), (a0)                              ; $004450
        addq.w       #$4, a0                                       ; $004454
        move.b       $6(a2), d0                                    ; $004456
        move.b       (a3, d0.w), (a0)                              ; $00445A
        addq.w       #$4, a0                                       ; $00445E
        move.b       $b(a2), d0                                    ; $004460
        move.b       (a3, d0.w), (a0)                              ; $004464
        addq.w       #$4, a0                                       ; $004468
        move.b       $10(a2), d0                                   ; $00446A
        move.b       (a3, d0.w), (a0)                              ; $00446E
        addq.w       #$4, a0                                       ; $004472
        move.b       $14(a2), d0                                   ; $004474
        move.b       (a3, d0.w), (a0)                              ; $004478
        addq.w       #$4, a0                                       ; $00447C
        move.b       $19(a2), d0                                   ; $00447E
        move.b       (a3, d0.w), (a0)                              ; $004482
        addq.w       #$4, a0                                       ; $004486
        move.b       $1d(a2), d0                                   ; $004488
        move.b       (a3, d0.w), (a0)                              ; $00448C
        addq.w       #$4, a0                                       ; $004490
        lea.l        $e(a5), a5                                    ; $004492
        movea.l      $8(a7), a3                                    ; $004496
        jmp          (a3)                                          ; $00449A

loc_00449C:
        movea.l      $4(a7), a3                                    ; $00449C
        jsr          (a3)                                          ; $0044A0
        movea.l      rActiveWallColorRemap5(a6), a3                ; $0044A2
        clr.w        d0                                            ; $0044A6
        move.b       $2(a1), d0                                    ; $0044A8
        move.b       (a3, d0.w), (a0)                              ; $0044AC
        addq.w       #$4, a0                                       ; $0044B0
        move.b       $6(a1), d0                                    ; $0044B2
        move.b       (a3, d0.w), (a0)                              ; $0044B6
        addq.w       #$4, a0                                       ; $0044BA
        move.b       $a(a1), d0                                    ; $0044BC
        move.b       (a3, d0.w), (a0)                              ; $0044C0
        addq.w       #$4, a0                                       ; $0044C4
        move.b       $e(a1), d0                                    ; $0044C6
        move.b       (a3, d0.w), (a0)                              ; $0044CA
        addq.w       #$4, a0                                       ; $0044CE
        move.b       $12(a1), d0                                   ; $0044D0
        move.b       (a3, d0.w), (a0)                              ; $0044D4
        addq.w       #$4, a0                                       ; $0044D8
        move.b       $16(a1), d0                                   ; $0044DA
        move.b       (a3, d0.w), (a0)                              ; $0044DE
        addq.w       #$4, a0                                       ; $0044E2
        move.b       $1a(a1), d0                                   ; $0044E4
        move.b       (a3, d0.w), (a0)                              ; $0044E8
        addq.w       #$4, a0                                       ; $0044EC
        move.b       $1e(a1), d0                                   ; $0044EE
        move.b       (a3, d0.w), (a0)                              ; $0044F2
        addq.w       #$4, a0                                       ; $0044F6
        move.b       $2(a2), d0                                    ; $0044F8
        move.b       (a3, d0.w), (a0)                              ; $0044FC
        addq.w       #$4, a0                                       ; $004500
        move.b       $6(a2), d0                                    ; $004502
        move.b       (a3, d0.w), (a0)                              ; $004506
        addq.w       #$4, a0                                       ; $00450A
        move.b       $a(a2), d0                                    ; $00450C
        move.b       (a3, d0.w), (a0)                              ; $004510
        addq.w       #$4, a0                                       ; $004514
        move.b       $e(a2), d0                                    ; $004516
        move.b       (a3, d0.w), (a0)                              ; $00451A
        addq.w       #$4, a0                                       ; $00451E
        move.b       $12(a2), d0                                   ; $004520
        move.b       (a3, d0.w), (a0)                              ; $004524
        addq.w       #$4, a0                                       ; $004528
        move.b       $16(a2), d0                                   ; $00452A
        move.b       (a3, d0.w), (a0)                              ; $00452E
        addq.w       #$4, a0                                       ; $004532
        move.b       $1a(a2), d0                                   ; $004534
        move.b       (a3, d0.w), (a0)                              ; $004538
        addq.w       #$4, a0                                       ; $00453C
        move.b       $1e(a2), d0                                   ; $00453E
        move.b       (a3, d0.w), (a0)                              ; $004542
        addq.w       #$4, a0                                       ; $004546
        lea.l        $10(a5), a5                                   ; $004548
        movea.l      $8(a7), a3                                    ; $00454C
        jmp          (a3)                                          ; $004550

loc_004552:
        movea.l      $4(a7), a3                                    ; $004552
        jsr          (a3)                                          ; $004556
        movea.l      rActiveWallColorRemap5(a6), a3                ; $004558
        clr.w        d0                                            ; $00455C
        move.b       $1(a1), d0                                    ; $00455E
        move.b       (a3, d0.w), (a0)                              ; $004562
        addq.w       #$4, a0                                       ; $004566
        move.b       $5(a1), d0                                    ; $004568
        move.b       (a3, d0.w), (a0)                              ; $00456C
        addq.w       #$4, a0                                       ; $004570
        move.b       $8(a1), d0                                    ; $004572
        move.b       (a3, d0.w), (a0)                              ; $004576
        addq.w       #$4, a0                                       ; $00457A
        move.b       $c(a1), d0                                    ; $00457C
        move.b       (a3, d0.w), (a0)                              ; $004580
        addq.w       #$4, a0                                       ; $004584
        move.b       $10(a1), d0                                   ; $004586
        move.b       (a3, d0.w), (a0)                              ; $00458A
        addq.w       #$4, a0                                       ; $00458E
        move.b       $13(a1), d0                                   ; $004590
        move.b       (a3, d0.w), (a0)                              ; $004594
        addq.w       #$4, a0                                       ; $004598
        move.b       $17(a1), d0                                   ; $00459A
        move.b       (a3, d0.w), (a0)                              ; $00459E
        addq.w       #$4, a0                                       ; $0045A2
        move.b       $1a(a1), d0                                   ; $0045A4
        move.b       (a3, d0.w), (a0)                              ; $0045A8
        addq.w       #$4, a0                                       ; $0045AC
        move.b       $1e(a1), d0                                   ; $0045AE
        move.b       (a3, d0.w), (a0)                              ; $0045B2
        addq.w       #$4, a0                                       ; $0045B6
        move.b       $1(a2), d0                                    ; $0045B8
        move.b       (a3, d0.w), (a0)                              ; $0045BC
        addq.w       #$4, a0                                       ; $0045C0
        move.b       $5(a2), d0                                    ; $0045C2
        move.b       (a3, d0.w), (a0)                              ; $0045C6
        addq.w       #$4, a0                                       ; $0045CA
        move.b       $8(a2), d0                                    ; $0045CC
        move.b       (a3, d0.w), (a0)                              ; $0045D0
        addq.w       #$4, a0                                       ; $0045D4
        move.b       $c(a2), d0                                    ; $0045D6
        move.b       (a3, d0.w), (a0)                              ; $0045DA
        addq.w       #$4, a0                                       ; $0045DE
        move.b       $10(a2), d0                                   ; $0045E0
        move.b       (a3, d0.w), (a0)                              ; $0045E4
        addq.w       #$4, a0                                       ; $0045E8
        move.b       $13(a2), d0                                   ; $0045EA
        move.b       (a3, d0.w), (a0)                              ; $0045EE
        addq.w       #$4, a0                                       ; $0045F2
        move.b       $17(a2), d0                                   ; $0045F4
        move.b       (a3, d0.w), (a0)                              ; $0045F8
        addq.w       #$4, a0                                       ; $0045FC
        move.b       $1a(a2), d0                                   ; $0045FE
        move.b       (a3, d0.w), (a0)                              ; $004602
        addq.w       #$4, a0                                       ; $004606
        move.b       $1e(a2), d0                                   ; $004608
        move.b       (a3, d0.w), (a0)                              ; $00460C
        addq.w       #$4, a0                                       ; $004610
        lea.l        $12(a5), a5                                   ; $004612
        movea.l      $8(a7), a3                                    ; $004616
        jmp          (a3)                                          ; $00461A

loc_00461C:
        movea.l      $4(a7), a3                                    ; $00461C
        jsr          (a3)                                          ; $004620
        movea.l      rActiveWallColorRemap5(a6), a3                ; $004622
        clr.w        d0                                            ; $004626
        move.b       $1(a1), d0                                    ; $004628
        move.b       (a3, d0.w), (a0)                              ; $00462C
        addq.w       #$4, a0                                       ; $004630
        move.b       $4(a1), d0                                    ; $004632
        move.b       (a3, d0.w), (a0)                              ; $004636
        addq.w       #$4, a0                                       ; $00463A
        move.b       $8(a1), d0                                    ; $00463C
        move.b       (a3, d0.w), (a0)                              ; $004640
        addq.w       #$4, a0                                       ; $004644
        move.b       $b(a1), d0                                    ; $004646
        move.b       (a3, d0.w), (a0)                              ; $00464A
        addq.w       #$4, a0                                       ; $00464E
        move.b       $e(a1), d0                                    ; $004650
        move.b       (a3, d0.w), (a0)                              ; $004654
        addq.w       #$4, a0                                       ; $004658
        move.b       $11(a1), d0                                   ; $00465A
        move.b       (a3, d0.w), (a0)                              ; $00465E
        addq.w       #$4, a0                                       ; $004662
        move.b       $14(a1), d0                                   ; $004664
        move.b       (a3, d0.w), (a0)                              ; $004668
        addq.w       #$4, a0                                       ; $00466C
        move.b       $18(a1), d0                                   ; $00466E
        move.b       (a3, d0.w), (a0)                              ; $004672
        addq.w       #$4, a0                                       ; $004676
        move.b       $1b(a1), d0                                   ; $004678
        move.b       (a3, d0.w), (a0)                              ; $00467C
        addq.w       #$4, a0                                       ; $004680
        move.b       $1e(a1), d0                                   ; $004682
        move.b       (a3, d0.w), (a0)                              ; $004686
        addq.w       #$4, a0                                       ; $00468A
        move.b       $1(a2), d0                                    ; $00468C
        move.b       (a3, d0.w), (a0)                              ; $004690
        addq.w       #$4, a0                                       ; $004694
        move.b       $4(a2), d0                                    ; $004696
        move.b       (a3, d0.w), (a0)                              ; $00469A
        addq.w       #$4, a0                                       ; $00469E
        move.b       $8(a2), d0                                    ; $0046A0
        move.b       (a3, d0.w), (a0)                              ; $0046A4
        addq.w       #$4, a0                                       ; $0046A8
        move.b       $b(a2), d0                                    ; $0046AA
        move.b       (a3, d0.w), (a0)                              ; $0046AE
        addq.w       #$4, a0                                       ; $0046B2
        move.b       $e(a2), d0                                    ; $0046B4
        move.b       (a3, d0.w), (a0)                              ; $0046B8
        addq.w       #$4, a0                                       ; $0046BC
        move.b       $11(a2), d0                                   ; $0046BE
        move.b       (a3, d0.w), (a0)                              ; $0046C2
        addq.w       #$4, a0                                       ; $0046C6
        move.b       $14(a2), d0                                   ; $0046C8
        move.b       (a3, d0.w), (a0)                              ; $0046CC
        addq.w       #$4, a0                                       ; $0046D0
        move.b       $18(a2), d0                                   ; $0046D2
        move.b       (a3, d0.w), (a0)                              ; $0046D6
        addq.w       #$4, a0                                       ; $0046DA
        move.b       $1b(a2), d0                                   ; $0046DC
        move.b       (a3, d0.w), (a0)                              ; $0046E0
        addq.w       #$4, a0                                       ; $0046E4
        move.b       $1e(a2), d0                                   ; $0046E6
        move.b       (a3, d0.w), (a0)                              ; $0046EA
        addq.w       #$4, a0                                       ; $0046EE
        lea.l        $14(a5), a5                                   ; $0046F0
        movea.l      $8(a7), a3                                    ; $0046F4
        jmp          (a3)                                          ; $0046F8

loc_0046FA:
        movea.l      $4(a7), a3                                    ; $0046FA
        jsr          (a3)                                          ; $0046FE
        movea.l      rActiveWallColorRemap4(a6), a3                ; $004700
        clr.w        d0                                            ; $004704
        move.b       $1(a1), d0                                    ; $004706
        move.b       (a3, d0.w), (a0)                              ; $00470A
        addq.w       #$4, a0                                       ; $00470E
        move.b       $4(a1), d0                                    ; $004710
        move.b       (a3, d0.w), (a0)                              ; $004714
        addq.w       #$4, a0                                       ; $004718
        move.b       $7(a1), d0                                    ; $00471A
        move.b       (a3, d0.w), (a0)                              ; $00471E
        addq.w       #$4, a0                                       ; $004722
        move.b       $a(a1), d0                                    ; $004724
        move.b       (a3, d0.w), (a0)                              ; $004728
        addq.w       #$4, a0                                       ; $00472C
        move.b       $d(a1), d0                                    ; $00472E
        move.b       (a3, d0.w), (a0)                              ; $004732
        addq.w       #$4, a0                                       ; $004736
        move.b       $10(a1), d0                                   ; $004738
        move.b       (a3, d0.w), (a0)                              ; $00473C
        addq.w       #$4, a0                                       ; $004740
        move.b       $12(a1), d0                                   ; $004742
        move.b       (a3, d0.w), (a0)                              ; $004746
        addq.w       #$4, a0                                       ; $00474A
        move.b       $15(a1), d0                                   ; $00474C
        move.b       (a3, d0.w), (a0)                              ; $004750
        addq.w       #$4, a0                                       ; $004754
        move.b       $18(a1), d0                                   ; $004756
        move.b       (a3, d0.w), (a0)                              ; $00475A
        addq.w       #$4, a0                                       ; $00475E
        move.b       $1b(a1), d0                                   ; $004760
        move.b       (a3, d0.w), (a0)                              ; $004764
        addq.w       #$4, a0                                       ; $004768
        move.b       $1e(a1), d0                                   ; $00476A
        move.b       (a3, d0.w), (a0)                              ; $00476E
        addq.w       #$4, a0                                       ; $004772
        move.b       $1(a2), d0                                    ; $004774
        move.b       (a3, d0.w), (a0)                              ; $004778
        addq.w       #$4, a0                                       ; $00477C
        move.b       $4(a2), d0                                    ; $00477E
        move.b       (a3, d0.w), (a0)                              ; $004782
        addq.w       #$4, a0                                       ; $004786
        move.b       $7(a2), d0                                    ; $004788
        move.b       (a3, d0.w), (a0)                              ; $00478C
        addq.w       #$4, a0                                       ; $004790
        move.b       $a(a2), d0                                    ; $004792
        move.b       (a3, d0.w), (a0)                              ; $004796
        addq.w       #$4, a0                                       ; $00479A
        move.b       $d(a2), d0                                    ; $00479C
        move.b       (a3, d0.w), (a0)                              ; $0047A0
        addq.w       #$4, a0                                       ; $0047A4
        move.b       $10(a2), d0                                   ; $0047A6
        move.b       (a3, d0.w), (a0)                              ; $0047AA
        addq.w       #$4, a0                                       ; $0047AE
        move.b       $12(a2), d0                                   ; $0047B0
        move.b       (a3, d0.w), (a0)                              ; $0047B4
        addq.w       #$4, a0                                       ; $0047B8
        move.b       $15(a2), d0                                   ; $0047BA
        move.b       (a3, d0.w), (a0)                              ; $0047BE
        addq.w       #$4, a0                                       ; $0047C2
        move.b       $18(a2), d0                                   ; $0047C4
        move.b       (a3, d0.w), (a0)                              ; $0047C8
        addq.w       #$4, a0                                       ; $0047CC
        move.b       $1b(a2), d0                                   ; $0047CE
        move.b       (a3, d0.w), (a0)                              ; $0047D2
        addq.w       #$4, a0                                       ; $0047D6
        move.b       $1e(a2), d0                                   ; $0047D8
        move.b       (a3, d0.w), (a0)                              ; $0047DC
        addq.w       #$4, a0                                       ; $0047E0
        lea.l        $16(a5), a5                                   ; $0047E2
        movea.l      $8(a7), a3                                    ; $0047E6
        jmp          (a3)                                          ; $0047EA

loc_0047EC:
        movea.l      $4(a7), a3                                    ; $0047EC
        jsr          (a3)                                          ; $0047F0
        movea.l      rActiveWallColorRemap4(a6), a3                ; $0047F2
        clr.w        d0                                            ; $0047F6
        move.b       $1(a1), d0                                    ; $0047F8
        move.b       (a3, d0.w), (a0)                              ; $0047FC
        addq.w       #$4, a0                                       ; $004800
        move.b       $4(a1), d0                                    ; $004802
        move.b       (a3, d0.w), (a0)                              ; $004806
        addq.w       #$4, a0                                       ; $00480A
        move.b       $6(a1), d0                                    ; $00480C
        move.b       (a3, d0.w), (a0)                              ; $004810
        addq.w       #$4, a0                                       ; $004814
        move.b       $9(a1), d0                                    ; $004816
        move.b       (a3, d0.w), (a0)                              ; $00481A
        addq.w       #$4, a0                                       ; $00481E
        move.b       $c(a1), d0                                    ; $004820
        move.b       (a3, d0.w), (a0)                              ; $004824
        addq.w       #$4, a0                                       ; $004828
        move.b       $e(a1), d0                                    ; $00482A
        move.b       (a3, d0.w), (a0)                              ; $00482E
        addq.w       #$4, a0                                       ; $004832
        move.b       $11(a1), d0                                   ; $004834
        move.b       (a3, d0.w), (a0)                              ; $004838
        addq.w       #$4, a0                                       ; $00483C
        move.b       $14(a1), d0                                   ; $00483E
        move.b       (a3, d0.w), (a0)                              ; $004842
        addq.w       #$4, a0                                       ; $004846
        move.b       $16(a1), d0                                   ; $004848
        move.b       (a3, d0.w), (a0)                              ; $00484C
        addq.w       #$4, a0                                       ; $004850
        move.b       $19(a1), d0                                   ; $004852
        move.b       (a3, d0.w), (a0)                              ; $004856
        addq.w       #$4, a0                                       ; $00485A
        move.b       $1c(a1), d0                                   ; $00485C
        move.b       (a3, d0.w), (a0)                              ; $004860
        addq.w       #$4, a0                                       ; $004864
        move.b       $1e(a1), d0                                   ; $004866
        move.b       (a3, d0.w), (a0)                              ; $00486A
        addq.w       #$4, a0                                       ; $00486E
        move.b       $1(a2), d0                                    ; $004870
        move.b       (a3, d0.w), (a0)                              ; $004874
        addq.w       #$4, a0                                       ; $004878
        move.b       $4(a2), d0                                    ; $00487A
        move.b       (a3, d0.w), (a0)                              ; $00487E
        addq.w       #$4, a0                                       ; $004882
        move.b       $6(a2), d0                                    ; $004884
        move.b       (a3, d0.w), (a0)                              ; $004888
        addq.w       #$4, a0                                       ; $00488C
        move.b       $9(a2), d0                                    ; $00488E
        move.b       (a3, d0.w), (a0)                              ; $004892
        addq.w       #$4, a0                                       ; $004896
        move.b       $c(a2), d0                                    ; $004898
        move.b       (a3, d0.w), (a0)                              ; $00489C
        addq.w       #$4, a0                                       ; $0048A0
        move.b       $e(a2), d0                                    ; $0048A2
        move.b       (a3, d0.w), (a0)                              ; $0048A6
        addq.w       #$4, a0                                       ; $0048AA
        move.b       $11(a2), d0                                   ; $0048AC
        move.b       (a3, d0.w), (a0)                              ; $0048B0
        addq.w       #$4, a0                                       ; $0048B4
        move.b       $14(a2), d0                                   ; $0048B6
        move.b       (a3, d0.w), (a0)                              ; $0048BA
        addq.w       #$4, a0                                       ; $0048BE
        move.b       $16(a2), d0                                   ; $0048C0
        move.b       (a3, d0.w), (a0)                              ; $0048C4
        addq.w       #$4, a0                                       ; $0048C8
        move.b       $19(a2), d0                                   ; $0048CA
        move.b       (a3, d0.w), (a0)                              ; $0048CE
        addq.w       #$4, a0                                       ; $0048D2
        move.b       $1c(a2), d0                                   ; $0048D4
        move.b       (a3, d0.w), (a0)                              ; $0048D8
        addq.w       #$4, a0                                       ; $0048DC
        move.b       $1e(a2), d0                                   ; $0048DE
        move.b       (a3, d0.w), (a0)                              ; $0048E2
        addq.w       #$4, a0                                       ; $0048E6
        lea.l        $18(a5), a5                                   ; $0048E8
        movea.l      $8(a7), a3                                    ; $0048EC
        jmp          (a3)                                          ; $0048F0

loc_0048F2:
        movea.l      $4(a7), a3                                    ; $0048F2
        jsr          (a3)                                          ; $0048F6
        movea.l      rActiveWallColorRemap3(a6), a3                ; $0048F8
        clr.w        d0                                            ; $0048FC
        move.b       $1(a1), d0                                    ; $0048FE
        move.b       (a3, d0.w), (a0)                              ; $004902
        addq.w       #$4, a0                                       ; $004906
        move.b       $3(a1), d0                                    ; $004908
        move.b       (a3, d0.w), (a0)                              ; $00490C
        addq.w       #$4, a0                                       ; $004910
        move.b       $6(a1), d0                                    ; $004912
        move.b       (a3, d0.w), (a0)                              ; $004916
        addq.w       #$4, a0                                       ; $00491A
        move.b       $8(a1), d0                                    ; $00491C
        move.b       (a3, d0.w), (a0)                              ; $004920
        addq.w       #$4, a0                                       ; $004924
        move.b       $b(a1), d0                                    ; $004926
        move.b       (a3, d0.w), (a0)                              ; $00492A
        addq.w       #$4, a0                                       ; $00492E
        move.b       $d(a1), d0                                    ; $004930
        move.b       (a3, d0.w), (a0)                              ; $004934
        addq.w       #$4, a0                                       ; $004938
        move.b       $10(a1), d0                                   ; $00493A
        move.b       (a3, d0.w), (a0)                              ; $00493E
        addq.w       #$4, a0                                       ; $004942
        move.b       $12(a1), d0                                   ; $004944
        move.b       (a3, d0.w), (a0)                              ; $004948
        addq.w       #$4, a0                                       ; $00494C
        move.b       $14(a1), d0                                   ; $00494E
        move.b       (a3, d0.w), (a0)                              ; $004952
        addq.w       #$4, a0                                       ; $004956
        move.b       $17(a1), d0                                   ; $004958
        move.b       (a3, d0.w), (a0)                              ; $00495C
        addq.w       #$4, a0                                       ; $004960
        move.b       $19(a1), d0                                   ; $004962
        move.b       (a3, d0.w), (a0)                              ; $004966
        addq.w       #$4, a0                                       ; $00496A
        move.b       $1c(a1), d0                                   ; $00496C
        move.b       (a3, d0.w), (a0)                              ; $004970
        addq.w       #$4, a0                                       ; $004974
        move.b       $1e(a1), d0                                   ; $004976
        move.b       (a3, d0.w), (a0)                              ; $00497A
        addq.w       #$4, a0                                       ; $00497E
        move.b       $1(a2), d0                                    ; $004980
        move.b       (a3, d0.w), (a0)                              ; $004984
        addq.w       #$4, a0                                       ; $004988
        move.b       $3(a2), d0                                    ; $00498A
        move.b       (a3, d0.w), (a0)                              ; $00498E
        addq.w       #$4, a0                                       ; $004992
        move.b       $6(a2), d0                                    ; $004994
        move.b       (a3, d0.w), (a0)                              ; $004998
        addq.w       #$4, a0                                       ; $00499C
        move.b       $8(a2), d0                                    ; $00499E
        move.b       (a3, d0.w), (a0)                              ; $0049A2
        addq.w       #$4, a0                                       ; $0049A6
        move.b       $b(a2), d0                                    ; $0049A8
        move.b       (a3, d0.w), (a0)                              ; $0049AC
        addq.w       #$4, a0                                       ; $0049B0
        move.b       $d(a2), d0                                    ; $0049B2
        move.b       (a3, d0.w), (a0)                              ; $0049B6
        addq.w       #$4, a0                                       ; $0049BA
        move.b       $10(a2), d0                                   ; $0049BC
        move.b       (a3, d0.w), (a0)                              ; $0049C0
        addq.w       #$4, a0                                       ; $0049C4
        move.b       $12(a2), d0                                   ; $0049C6
        move.b       (a3, d0.w), (a0)                              ; $0049CA
        addq.w       #$4, a0                                       ; $0049CE
        move.b       $14(a2), d0                                   ; $0049D0
        move.b       (a3, d0.w), (a0)                              ; $0049D4
        addq.w       #$4, a0                                       ; $0049D8
        move.b       $17(a2), d0                                   ; $0049DA
        move.b       (a3, d0.w), (a0)                              ; $0049DE
        addq.w       #$4, a0                                       ; $0049E2
        move.b       $19(a2), d0                                   ; $0049E4
        move.b       (a3, d0.w), (a0)                              ; $0049E8
        addq.w       #$4, a0                                       ; $0049EC
        move.b       $1c(a2), d0                                   ; $0049EE
        move.b       (a3, d0.w), (a0)                              ; $0049F2
        addq.w       #$4, a0                                       ; $0049F6
        move.b       $1e(a2), d0                                   ; $0049F8
        move.b       (a3, d0.w), (a0)                              ; $0049FC
        addq.w       #$4, a0                                       ; $004A00
        lea.l        $1a(a5), a5                                   ; $004A02
        movea.l      $8(a7), a3                                    ; $004A06
        jmp          (a3)                                          ; $004A0A

loc_004A0C:
        movea.l      $4(a7), a3                                    ; $004A0C
        jsr          (a3)                                          ; $004A10
        movea.l      rActiveWallColorRemap3(a6), a3                ; $004A12
        clr.w        d0                                            ; $004A16
        move.b       $1(a1), d0                                    ; $004A18
        move.b       (a3, d0.w), (a0)                              ; $004A1C
        addq.w       #$4, a0                                       ; $004A20
        move.b       $3(a1), d0                                    ; $004A22
        move.b       (a3, d0.w), (a0)                              ; $004A26
        addq.w       #$4, a0                                       ; $004A2A
        move.b       $5(a1), d0                                    ; $004A2C
        move.b       (a3, d0.w), (a0)                              ; $004A30
        addq.w       #$4, a0                                       ; $004A34
        move.b       $8(a1), d0                                    ; $004A36
        move.b       (a3, d0.w), (a0)                              ; $004A3A
        addq.w       #$4, a0                                       ; $004A3E
        move.b       $a(a1), d0                                    ; $004A40
        move.b       (a3, d0.w), (a0)                              ; $004A44
        addq.w       #$4, a0                                       ; $004A48
        move.b       $c(a1), d0                                    ; $004A4A
        move.b       (a3, d0.w), (a0)                              ; $004A4E
        addq.w       #$4, a0                                       ; $004A52
        move.b       $e(a1), d0                                    ; $004A54
        move.b       (a3, d0.w), (a0)                              ; $004A58
        addq.w       #$4, a0                                       ; $004A5C
        move.b       $11(a1), d0                                   ; $004A5E
        move.b       (a3, d0.w), (a0)                              ; $004A62
        addq.w       #$4, a0                                       ; $004A66
        move.b       $13(a1), d0                                   ; $004A68
        move.b       (a3, d0.w), (a0)                              ; $004A6C
        addq.w       #$4, a0                                       ; $004A70
        move.b       $15(a1), d0                                   ; $004A72
        move.b       (a3, d0.w), (a0)                              ; $004A76
        addq.w       #$4, a0                                       ; $004A7A
        move.b       $18(a1), d0                                   ; $004A7C
        move.b       (a3, d0.w), (a0)                              ; $004A80
        addq.w       #$4, a0                                       ; $004A84
        move.b       $1a(a1), d0                                   ; $004A86
        move.b       (a3, d0.w), (a0)                              ; $004A8A
        addq.w       #$4, a0                                       ; $004A8E
        move.b       $1c(a1), d0                                   ; $004A90
        move.b       (a3, d0.w), (a0)                              ; $004A94
        addq.w       #$4, a0                                       ; $004A98
        move.b       $1e(a1), d0                                   ; $004A9A
        move.b       (a3, d0.w), (a0)                              ; $004A9E
        addq.w       #$4, a0                                       ; $004AA2
        move.b       $1(a2), d0                                    ; $004AA4
        move.b       (a3, d0.w), (a0)                              ; $004AA8
        addq.w       #$4, a0                                       ; $004AAC
        move.b       $3(a2), d0                                    ; $004AAE
        move.b       (a3, d0.w), (a0)                              ; $004AB2
        addq.w       #$4, a0                                       ; $004AB6
        move.b       $5(a2), d0                                    ; $004AB8
        move.b       (a3, d0.w), (a0)                              ; $004ABC
        addq.w       #$4, a0                                       ; $004AC0
        move.b       $8(a2), d0                                    ; $004AC2
        move.b       (a3, d0.w), (a0)                              ; $004AC6
        addq.w       #$4, a0                                       ; $004ACA
        move.b       $a(a2), d0                                    ; $004ACC
        move.b       (a3, d0.w), (a0)                              ; $004AD0
        addq.w       #$4, a0                                       ; $004AD4
        move.b       $c(a2), d0                                    ; $004AD6
        move.b       (a3, d0.w), (a0)                              ; $004ADA
        addq.w       #$4, a0                                       ; $004ADE
        move.b       $e(a2), d0                                    ; $004AE0
        move.b       (a3, d0.w), (a0)                              ; $004AE4
        addq.w       #$4, a0                                       ; $004AE8
        move.b       $11(a2), d0                                   ; $004AEA
        move.b       (a3, d0.w), (a0)                              ; $004AEE
        addq.w       #$4, a0                                       ; $004AF2
        move.b       $13(a2), d0                                   ; $004AF4
        move.b       (a3, d0.w), (a0)                              ; $004AF8
        addq.w       #$4, a0                                       ; $004AFC
        move.b       $15(a2), d0                                   ; $004AFE
        move.b       (a3, d0.w), (a0)                              ; $004B02
        addq.w       #$4, a0                                       ; $004B06
        move.b       $18(a2), d0                                   ; $004B08
        move.b       (a3, d0.w), (a0)                              ; $004B0C
        addq.w       #$4, a0                                       ; $004B10
        move.b       $1a(a2), d0                                   ; $004B12
        move.b       (a3, d0.w), (a0)                              ; $004B16
        addq.w       #$4, a0                                       ; $004B1A
        move.b       $1c(a2), d0                                   ; $004B1C
        move.b       (a3, d0.w), (a0)                              ; $004B20
        addq.w       #$4, a0                                       ; $004B24
        move.b       $1e(a2), d0                                   ; $004B26
        move.b       (a3, d0.w), (a0)                              ; $004B2A
        addq.w       #$4, a0                                       ; $004B2E
        lea.l        $1c(a5), a5                                   ; $004B30
        movea.l      $8(a7), a3                                    ; $004B34
        jmp          (a3)                                          ; $004B38

loc_004B3A:
        movea.l      $4(a7), a3                                    ; $004B3A
        jsr          (a3)                                          ; $004B3E
        movea.l      rActiveWallColorRemap2(a6), a3                ; $004B40
        clr.w        d0                                            ; $004B44
        move.b       $1(a1), d0                                    ; $004B46
        move.b       (a3, d0.w), (a0)                              ; $004B4A
        addq.w       #$4, a0                                       ; $004B4E
        move.b       $3(a1), d0                                    ; $004B50
        move.b       (a3, d0.w), (a0)                              ; $004B54
        addq.w       #$4, a0                                       ; $004B58
        move.b       $5(a1), d0                                    ; $004B5A
        move.b       (a3, d0.w), (a0)                              ; $004B5E
        addq.w       #$4, a0                                       ; $004B62
        move.b       $7(a1), d0                                    ; $004B64
        move.b       (a3, d0.w), (a0)                              ; $004B68
        addq.w       #$4, a0                                       ; $004B6C
        move.b       $9(a1), d0                                    ; $004B6E
        move.b       (a3, d0.w), (a0)                              ; $004B72
        addq.w       #$4, a0                                       ; $004B76
        move.b       $b(a1), d0                                    ; $004B78
        move.b       (a3, d0.w), (a0)                              ; $004B7C
        addq.w       #$4, a0                                       ; $004B80
        move.b       $d(a1), d0                                    ; $004B82
        move.b       (a3, d0.w), (a0)                              ; $004B86
        addq.w       #$4, a0                                       ; $004B8A
        move.b       $10(a1), d0                                   ; $004B8C
        move.b       (a3, d0.w), (a0)                              ; $004B90
        addq.w       #$4, a0                                       ; $004B94
        move.b       $12(a1), d0                                   ; $004B96
        move.b       (a3, d0.w), (a0)                              ; $004B9A
        addq.w       #$4, a0                                       ; $004B9E
        move.b       $14(a1), d0                                   ; $004BA0
        move.b       (a3, d0.w), (a0)                              ; $004BA4
        addq.w       #$4, a0                                       ; $004BA8
        move.b       $16(a1), d0                                   ; $004BAA
        move.b       (a3, d0.w), (a0)                              ; $004BAE
        addq.w       #$4, a0                                       ; $004BB2
        move.b       $18(a1), d0                                   ; $004BB4
        move.b       (a3, d0.w), (a0)                              ; $004BB8
        addq.w       #$4, a0                                       ; $004BBC
        move.b       $1a(a1), d0                                   ; $004BBE
        move.b       (a3, d0.w), (a0)                              ; $004BC2
        addq.w       #$4, a0                                       ; $004BC6
        move.b       $1c(a1), d0                                   ; $004BC8
        move.b       (a3, d0.w), (a0)                              ; $004BCC
        addq.w       #$4, a0                                       ; $004BD0
        move.b       $1e(a1), d0                                   ; $004BD2
        move.b       (a3, d0.w), (a0)                              ; $004BD6
        addq.w       #$4, a0                                       ; $004BDA
        move.b       $1(a2), d0                                    ; $004BDC
        move.b       (a3, d0.w), (a0)                              ; $004BE0
        addq.w       #$4, a0                                       ; $004BE4
        move.b       $3(a2), d0                                    ; $004BE6
        move.b       (a3, d0.w), (a0)                              ; $004BEA
        addq.w       #$4, a0                                       ; $004BEE
        move.b       $5(a2), d0                                    ; $004BF0
        move.b       (a3, d0.w), (a0)                              ; $004BF4
        addq.w       #$4, a0                                       ; $004BF8
        move.b       $7(a2), d0                                    ; $004BFA
        move.b       (a3, d0.w), (a0)                              ; $004BFE
        addq.w       #$4, a0                                       ; $004C02
        move.b       $9(a2), d0                                    ; $004C04
        move.b       (a3, d0.w), (a0)                              ; $004C08
        addq.w       #$4, a0                                       ; $004C0C
        move.b       $b(a2), d0                                    ; $004C0E
        move.b       (a3, d0.w), (a0)                              ; $004C12
        addq.w       #$4, a0                                       ; $004C16
        move.b       $d(a2), d0                                    ; $004C18
        move.b       (a3, d0.w), (a0)                              ; $004C1C
        addq.w       #$4, a0                                       ; $004C20
        move.b       $10(a2), d0                                   ; $004C22
        move.b       (a3, d0.w), (a0)                              ; $004C26
        addq.w       #$4, a0                                       ; $004C2A
        move.b       $12(a2), d0                                   ; $004C2C
        move.b       (a3, d0.w), (a0)                              ; $004C30
        addq.w       #$4, a0                                       ; $004C34
        move.b       $14(a2), d0                                   ; $004C36
        move.b       (a3, d0.w), (a0)                              ; $004C3A
        addq.w       #$4, a0                                       ; $004C3E
        move.b       $16(a2), d0                                   ; $004C40
        move.b       (a3, d0.w), (a0)                              ; $004C44
        addq.w       #$4, a0                                       ; $004C48
        move.b       $18(a2), d0                                   ; $004C4A
        move.b       (a3, d0.w), (a0)                              ; $004C4E
        addq.w       #$4, a0                                       ; $004C52
        move.b       $1a(a2), d0                                   ; $004C54
        move.b       (a3, d0.w), (a0)                              ; $004C58
        addq.w       #$4, a0                                       ; $004C5C
        move.b       $1c(a2), d0                                   ; $004C5E
        move.b       (a3, d0.w), (a0)                              ; $004C62
        addq.w       #$4, a0                                       ; $004C66
        move.b       $1e(a2), d0                                   ; $004C68
        move.b       (a3, d0.w), (a0)                              ; $004C6C
        addq.w       #$4, a0                                       ; $004C70
        lea.l        $1e(a5), a5                                   ; $004C72
        movea.l      $8(a7), a3                                    ; $004C76
        jmp          (a3)                                          ; $004C7A

loc_004C7C:
        movea.l      $4(a7), a3                                    ; $004C7C
        jsr          (a3)                                          ; $004C80
        movea.l      rActiveWallColorRemap2(a6), a3                ; $004C82
        clr.w        d0                                            ; $004C86
        move.b       $1(a1), d0                                    ; $004C88
        move.b       (a3, d0.w), (a0)                              ; $004C8C
        addq.w       #$4, a0                                       ; $004C90
        move.b       $3(a1), d0                                    ; $004C92
        move.b       (a3, d0.w), (a0)                              ; $004C96
        addq.w       #$4, a0                                       ; $004C9A
        move.b       $5(a1), d0                                    ; $004C9C
        move.b       (a3, d0.w), (a0)                              ; $004CA0
        addq.w       #$4, a0                                       ; $004CA4
        move.b       $7(a1), d0                                    ; $004CA6
        move.b       (a3, d0.w), (a0)                              ; $004CAA
        addq.w       #$4, a0                                       ; $004CAE
        move.b       $9(a1), d0                                    ; $004CB0
        move.b       (a3, d0.w), (a0)                              ; $004CB4
        addq.w       #$4, a0                                       ; $004CB8
        move.b       $b(a1), d0                                    ; $004CBA
        move.b       (a3, d0.w), (a0)                              ; $004CBE
        addq.w       #$4, a0                                       ; $004CC2
        move.b       $d(a1), d0                                    ; $004CC4
        move.b       (a3, d0.w), (a0)                              ; $004CC8
        addq.w       #$4, a0                                       ; $004CCC
        move.b       $f(a1), d0                                    ; $004CCE
        move.b       (a3, d0.w), (a0)                              ; $004CD2
        addq.w       #$4, a0                                       ; $004CD6
        move.b       $11(a1), d0                                   ; $004CD8
        move.b       (a3, d0.w), (a0)                              ; $004CDC
        addq.w       #$4, a0                                       ; $004CE0
        move.b       $13(a1), d0                                   ; $004CE2
        move.b       (a3, d0.w), (a0)                              ; $004CE6
        addq.w       #$4, a0                                       ; $004CEA
        move.b       $15(a1), d0                                   ; $004CEC
        move.b       (a3, d0.w), (a0)                              ; $004CF0
        addq.w       #$4, a0                                       ; $004CF4
        move.b       $17(a1), d0                                   ; $004CF6
        move.b       (a3, d0.w), (a0)                              ; $004CFA
        addq.w       #$4, a0                                       ; $004CFE
        move.b       $19(a1), d0                                   ; $004D00
        move.b       (a3, d0.w), (a0)                              ; $004D04
        addq.w       #$4, a0                                       ; $004D08
        move.b       $1b(a1), d0                                   ; $004D0A
        move.b       (a3, d0.w), (a0)                              ; $004D0E
        addq.w       #$4, a0                                       ; $004D12
        move.b       $1d(a1), d0                                   ; $004D14
        move.b       (a3, d0.w), (a0)                              ; $004D18
        addq.w       #$4, a0                                       ; $004D1C
        move.b       $1f(a1), d0                                   ; $004D1E
        move.b       (a3, d0.w), (a0)                              ; $004D22
        addq.w       #$4, a0                                       ; $004D26
        move.b       $1(a2), d0                                    ; $004D28
        move.b       (a3, d0.w), (a0)                              ; $004D2C
        addq.w       #$4, a0                                       ; $004D30
        move.b       $3(a2), d0                                    ; $004D32
        move.b       (a3, d0.w), (a0)                              ; $004D36
        addq.w       #$4, a0                                       ; $004D3A
        move.b       $5(a2), d0                                    ; $004D3C
        move.b       (a3, d0.w), (a0)                              ; $004D40
        addq.w       #$4, a0                                       ; $004D44
        move.b       $7(a2), d0                                    ; $004D46
        move.b       (a3, d0.w), (a0)                              ; $004D4A
        addq.w       #$4, a0                                       ; $004D4E
        move.b       $9(a2), d0                                    ; $004D50
        move.b       (a3, d0.w), (a0)                              ; $004D54
        addq.w       #$4, a0                                       ; $004D58
        move.b       $b(a2), d0                                    ; $004D5A
        move.b       (a3, d0.w), (a0)                              ; $004D5E
        addq.w       #$4, a0                                       ; $004D62
        move.b       $d(a2), d0                                    ; $004D64
        move.b       (a3, d0.w), (a0)                              ; $004D68
        addq.w       #$4, a0                                       ; $004D6C
        move.b       $f(a2), d0                                    ; $004D6E
        move.b       (a3, d0.w), (a0)                              ; $004D72
        addq.w       #$4, a0                                       ; $004D76
        move.b       $11(a2), d0                                   ; $004D78
        move.b       (a3, d0.w), (a0)                              ; $004D7C
        addq.w       #$4, a0                                       ; $004D80
        move.b       $13(a2), d0                                   ; $004D82
        move.b       (a3, d0.w), (a0)                              ; $004D86
        addq.w       #$4, a0                                       ; $004D8A
        move.b       $15(a2), d0                                   ; $004D8C
        move.b       (a3, d0.w), (a0)                              ; $004D90
        addq.w       #$4, a0                                       ; $004D94
        move.b       $17(a2), d0                                   ; $004D96
        move.b       (a3, d0.w), (a0)                              ; $004D9A
        addq.w       #$4, a0                                       ; $004D9E
        move.b       $19(a2), d0                                   ; $004DA0
        move.b       (a3, d0.w), (a0)                              ; $004DA4
        addq.w       #$4, a0                                       ; $004DA8
        move.b       $1b(a2), d0                                   ; $004DAA
        move.b       (a3, d0.w), (a0)                              ; $004DAE
        addq.w       #$4, a0                                       ; $004DB2
        move.b       $1d(a2), d0                                   ; $004DB4
        move.b       (a3, d0.w), (a0)                              ; $004DB8
        addq.w       #$4, a0                                       ; $004DBC
        move.b       $1f(a2), d0                                   ; $004DBE
        move.b       (a3, d0.w), (a0)                              ; $004DC2
        addq.w       #$4, a0                                       ; $004DC6
        lea.l        $20(a5), a5                                   ; $004DC8
        movea.l      $8(a7), a3                                    ; $004DCC
        jmp          (a3)                                          ; $004DD0

loc_004DD2:
        movea.l      $4(a7), a3                                    ; $004DD2
        jsr          (a3)                                          ; $004DD6
        movea.l      rActiveWallColorRemap1(a6), a3                ; $004DD8
        clr.w        d0                                            ; $004DDC
        move.b       (a1), d0                                      ; $004DDE
        move.b       (a3, d0.w), (a0)                              ; $004DE0
        addq.w       #$4, a0                                       ; $004DE4
        move.b       $2(a1), d0                                    ; $004DE6
        move.b       (a3, d0.w), (a0)                              ; $004DEA
        addq.w       #$4, a0                                       ; $004DEE
        move.b       $4(a1), d0                                    ; $004DF0
        move.b       (a3, d0.w), (a0)                              ; $004DF4
        addq.w       #$4, a0                                       ; $004DF8
        move.b       $6(a1), d0                                    ; $004DFA
        move.b       (a3, d0.w), (a0)                              ; $004DFE
        addq.w       #$4, a0                                       ; $004E02
        move.b       $8(a1), d0                                    ; $004E04
        move.b       (a3, d0.w), (a0)                              ; $004E08
        addq.w       #$4, a0                                       ; $004E0C
        move.b       $a(a1), d0                                    ; $004E0E
        move.b       (a3, d0.w), (a0)                              ; $004E12
        addq.w       #$4, a0                                       ; $004E16
        move.b       $c(a1), d0                                    ; $004E18
        move.b       (a3, d0.w), (a0)                              ; $004E1C
        addq.w       #$4, a0                                       ; $004E20
        move.b       $e(a1), d0                                    ; $004E22
        move.b       (a3, d0.w), (a0)                              ; $004E26
        addq.w       #$4, a0                                       ; $004E2A
        move.b       $10(a1), d0                                   ; $004E2C
        move.b       (a3, d0.w), (a0)                              ; $004E30
        addq.w       #$4, a0                                       ; $004E34
        move.b       $11(a1), d0                                   ; $004E36
        move.b       (a3, d0.w), (a0)                              ; $004E3A
        addq.w       #$4, a0                                       ; $004E3E
        move.b       $13(a1), d0                                   ; $004E40
        move.b       (a3, d0.w), (a0)                              ; $004E44
        addq.w       #$4, a0                                       ; $004E48
        move.b       $15(a1), d0                                   ; $004E4A
        move.b       (a3, d0.w), (a0)                              ; $004E4E
        addq.w       #$4, a0                                       ; $004E52
        move.b       $17(a1), d0                                   ; $004E54
        move.b       (a3, d0.w), (a0)                              ; $004E58
        addq.w       #$4, a0                                       ; $004E5C
        move.b       $19(a1), d0                                   ; $004E5E
        move.b       (a3, d0.w), (a0)                              ; $004E62
        addq.w       #$4, a0                                       ; $004E66
        move.b       $1b(a1), d0                                   ; $004E68
        move.b       (a3, d0.w), (a0)                              ; $004E6C
        addq.w       #$4, a0                                       ; $004E70
        move.b       $1d(a1), d0                                   ; $004E72
        move.b       (a3, d0.w), (a0)                              ; $004E76
        addq.w       #$4, a0                                       ; $004E7A
        move.b       $1f(a1), d0                                   ; $004E7C
        move.b       (a3, d0.w), (a0)                              ; $004E80
        addq.w       #$4, a0                                       ; $004E84
        move.b       (a2), d0                                      ; $004E86
        move.b       (a3, d0.w), (a0)                              ; $004E88
        addq.w       #$4, a0                                       ; $004E8C
        move.b       $2(a2), d0                                    ; $004E8E
        move.b       (a3, d0.w), (a0)                              ; $004E92
        addq.w       #$4, a0                                       ; $004E96
        move.b       $4(a2), d0                                    ; $004E98
        move.b       (a3, d0.w), (a0)                              ; $004E9C
        addq.w       #$4, a0                                       ; $004EA0
        move.b       $6(a2), d0                                    ; $004EA2
        move.b       (a3, d0.w), (a0)                              ; $004EA6
        addq.w       #$4, a0                                       ; $004EAA
        move.b       $8(a2), d0                                    ; $004EAC
        move.b       (a3, d0.w), (a0)                              ; $004EB0
        addq.w       #$4, a0                                       ; $004EB4
        move.b       $a(a2), d0                                    ; $004EB6
        move.b       (a3, d0.w), (a0)                              ; $004EBA
        addq.w       #$4, a0                                       ; $004EBE
        move.b       $c(a2), d0                                    ; $004EC0
        move.b       (a3, d0.w), (a0)                              ; $004EC4
        addq.w       #$4, a0                                       ; $004EC8
        move.b       $e(a2), d0                                    ; $004ECA
        move.b       (a3, d0.w), (a0)                              ; $004ECE
        addq.w       #$4, a0                                       ; $004ED2
        move.b       $10(a2), d0                                   ; $004ED4
        move.b       (a3, d0.w), (a0)                              ; $004ED8
        addq.w       #$4, a0                                       ; $004EDC
        move.b       $11(a2), d0                                   ; $004EDE
        move.b       (a3, d0.w), (a0)                              ; $004EE2
        addq.w       #$4, a0                                       ; $004EE6
        move.b       $13(a2), d0                                   ; $004EE8
        move.b       (a3, d0.w), (a0)                              ; $004EEC
        addq.w       #$4, a0                                       ; $004EF0
        move.b       $15(a2), d0                                   ; $004EF2
        move.b       (a3, d0.w), (a0)                              ; $004EF6
        addq.w       #$4, a0                                       ; $004EFA
        move.b       $17(a2), d0                                   ; $004EFC
        move.b       (a3, d0.w), (a0)                              ; $004F00
        addq.w       #$4, a0                                       ; $004F04
        move.b       $19(a2), d0                                   ; $004F06
        move.b       (a3, d0.w), (a0)                              ; $004F0A
        addq.w       #$4, a0                                       ; $004F0E
        move.b       $1b(a2), d0                                   ; $004F10
        move.b       (a3, d0.w), (a0)                              ; $004F14
        addq.w       #$4, a0                                       ; $004F18
        move.b       $1d(a2), d0                                   ; $004F1A
        move.b       (a3, d0.w), (a0)                              ; $004F1E
        addq.w       #$4, a0                                       ; $004F22
        move.b       $1f(a2), d0                                   ; $004F24
        move.b       (a3, d0.w), (a0)                              ; $004F28
        addq.w       #$4, a0                                       ; $004F2C
        lea.l        $22(a5), a5                                   ; $004F2E
        movea.l      $8(a7), a3                                    ; $004F32
        jmp          (a3)                                          ; $004F36

loc_004F38:
        movea.l      $4(a7), a3                                    ; $004F38
        jsr          (a3)                                          ; $004F3C
        movea.l      rActiveWallColorRemap1(a6), a3                ; $004F3E
        clr.w        d0                                            ; $004F42
        move.b       (a1), d0                                      ; $004F44
        move.b       (a3, d0.w), (a0)                              ; $004F46
        addq.w       #$4, a0                                       ; $004F4A
        move.b       $2(a1), d0                                    ; $004F4C
        move.b       (a3, d0.w), (a0)                              ; $004F50
        addq.w       #$4, a0                                       ; $004F54
        move.b       $4(a1), d0                                    ; $004F56
        move.b       (a3, d0.w), (a0)                              ; $004F5A
        addq.w       #$4, a0                                       ; $004F5E
        move.b       $6(a1), d0                                    ; $004F60
        move.b       (a3, d0.w), (a0)                              ; $004F64
        addq.w       #$4, a0                                       ; $004F68
        move.b       $8(a1), d0                                    ; $004F6A
        move.b       (a3, d0.w), (a0)                              ; $004F6E
        addq.w       #$4, a0                                       ; $004F72
        move.b       $9(a1), d0                                    ; $004F74
        move.b       (a3, d0.w), (a0)                              ; $004F78
        addq.w       #$4, a0                                       ; $004F7C
        move.b       $b(a1), d0                                    ; $004F7E
        move.b       (a3, d0.w), (a0)                              ; $004F82
        addq.w       #$4, a0                                       ; $004F86
        move.b       $d(a1), d0                                    ; $004F88
        move.b       (a3, d0.w), (a0)                              ; $004F8C
        addq.w       #$4, a0                                       ; $004F90
        move.b       $f(a1), d0                                    ; $004F92
        move.b       (a3, d0.w), (a0)                              ; $004F96
        addq.w       #$4, a0                                       ; $004F9A
        move.b       $10(a1), d0                                   ; $004F9C
        move.b       (a3, d0.w), (a0)                              ; $004FA0
        addq.w       #$4, a0                                       ; $004FA4
        move.b       $12(a1), d0                                   ; $004FA6
        move.b       (a3, d0.w), (a0)                              ; $004FAA
        addq.w       #$4, a0                                       ; $004FAE
        move.b       $14(a1), d0                                   ; $004FB0
        move.b       (a3, d0.w), (a0)                              ; $004FB4
        addq.w       #$4, a0                                       ; $004FB8
        move.b       $16(a1), d0                                   ; $004FBA
        move.b       (a3, d0.w), (a0)                              ; $004FBE
        addq.w       #$4, a0                                       ; $004FC2
        move.b       $18(a1), d0                                   ; $004FC4
        move.b       (a3, d0.w), (a0)                              ; $004FC8
        addq.w       #$4, a0                                       ; $004FCC
        move.b       $19(a1), d0                                   ; $004FCE
        move.b       (a3, d0.w), (a0)                              ; $004FD2
        addq.w       #$4, a0                                       ; $004FD6
        move.b       $1b(a1), d0                                   ; $004FD8
        move.b       (a3, d0.w), (a0)                              ; $004FDC
        addq.w       #$4, a0                                       ; $004FE0
        move.b       $1d(a1), d0                                   ; $004FE2
        move.b       (a3, d0.w), (a0)                              ; $004FE6
        addq.w       #$4, a0                                       ; $004FEA
        move.b       $1f(a1), d0                                   ; $004FEC
        move.b       (a3, d0.w), (a0)                              ; $004FF0
        addq.w       #$4, a0                                       ; $004FF4
        move.b       (a2), d0                                      ; $004FF6
        move.b       (a3, d0.w), (a0)                              ; $004FF8
        addq.w       #$4, a0                                       ; $004FFC
        move.b       $2(a2), d0                                    ; $004FFE
        move.b       (a3, d0.w), (a0)                              ; $005002
        addq.w       #$4, a0                                       ; $005006
        move.b       $4(a2), d0                                    ; $005008
        move.b       (a3, d0.w), (a0)                              ; $00500C
        addq.w       #$4, a0                                       ; $005010
        move.b       $6(a2), d0                                    ; $005012
        move.b       (a3, d0.w), (a0)                              ; $005016
        addq.w       #$4, a0                                       ; $00501A
        move.b       $8(a2), d0                                    ; $00501C
        move.b       (a3, d0.w), (a0)                              ; $005020
        addq.w       #$4, a0                                       ; $005024
        move.b       $9(a2), d0                                    ; $005026
        move.b       (a3, d0.w), (a0)                              ; $00502A
        addq.w       #$4, a0                                       ; $00502E
        move.b       $b(a2), d0                                    ; $005030
        move.b       (a3, d0.w), (a0)                              ; $005034
        addq.w       #$4, a0                                       ; $005038
        move.b       $d(a2), d0                                    ; $00503A
        move.b       (a3, d0.w), (a0)                              ; $00503E
        addq.w       #$4, a0                                       ; $005042
        move.b       $f(a2), d0                                    ; $005044
        move.b       (a3, d0.w), (a0)                              ; $005048
        addq.w       #$4, a0                                       ; $00504C
        move.b       $10(a2), d0                                   ; $00504E
        move.b       (a3, d0.w), (a0)                              ; $005052
        addq.w       #$4, a0                                       ; $005056
        move.b       $12(a2), d0                                   ; $005058
        move.b       (a3, d0.w), (a0)                              ; $00505C
        addq.w       #$4, a0                                       ; $005060
        move.b       $14(a2), d0                                   ; $005062
        move.b       (a3, d0.w), (a0)                              ; $005066
        addq.w       #$4, a0                                       ; $00506A
        move.b       $16(a2), d0                                   ; $00506C
        move.b       (a3, d0.w), (a0)                              ; $005070
        addq.w       #$4, a0                                       ; $005074
        move.b       $18(a2), d0                                   ; $005076
        move.b       (a3, d0.w), (a0)                              ; $00507A
        addq.w       #$4, a0                                       ; $00507E
        move.b       $19(a2), d0                                   ; $005080
        move.b       (a3, d0.w), (a0)                              ; $005084
        addq.w       #$4, a0                                       ; $005088
        move.b       $1b(a2), d0                                   ; $00508A
        move.b       (a3, d0.w), (a0)                              ; $00508E
        addq.w       #$4, a0                                       ; $005092
        move.b       $1d(a2), d0                                   ; $005094
        move.b       (a3, d0.w), (a0)                              ; $005098
        addq.w       #$4, a0                                       ; $00509C
        move.b       $1f(a2), d0                                   ; $00509E
        move.b       (a3, d0.w), (a0)                              ; $0050A2
        addq.w       #$4, a0                                       ; $0050A6
        lea.l        $24(a5), a5                                   ; $0050A8
        movea.l      $8(a7), a3                                    ; $0050AC
        jmp          (a3)                                          ; $0050B0

loc_0050B2:
        movea.l      $4(a7), a3                                    ; $0050B2
        jsr          (a3)                                          ; $0050B6
        movea.l      rActiveWallColorRemap0(a6), a3                ; $0050B8
        clr.w        d0                                            ; $0050BC
        move.b       (a1), d0                                      ; $0050BE
        move.b       (a3, d0.w), (a0)                              ; $0050C0
        addq.w       #$4, a0                                       ; $0050C4
        move.b       $2(a1), d0                                    ; $0050C6
        move.b       (a3, d0.w), (a0)                              ; $0050CA
        addq.w       #$4, a0                                       ; $0050CE
        move.b       $4(a1), d0                                    ; $0050D0
        move.b       (a3, d0.w), (a0)                              ; $0050D4
        addq.w       #$4, a0                                       ; $0050D8
        move.b       $5(a1), d0                                    ; $0050DA
        move.b       (a3, d0.w), (a0)                              ; $0050DE
        addq.w       #$4, a0                                       ; $0050E2
        move.b       $7(a1), d0                                    ; $0050E4
        move.b       (a3, d0.w), (a0)                              ; $0050E8
        addq.w       #$4, a0                                       ; $0050EC
        move.b       $9(a1), d0                                    ; $0050EE
        move.b       (a3, d0.w), (a0)                              ; $0050F2
        addq.w       #$4, a0                                       ; $0050F6
        move.b       $a(a1), d0                                    ; $0050F8
        move.b       (a3, d0.w), (a0)                              ; $0050FC
        addq.w       #$4, a0                                       ; $005100
        move.b       $c(a1), d0                                    ; $005102
        move.b       (a3, d0.w), (a0)                              ; $005106
        addq.w       #$4, a0                                       ; $00510A
        move.b       $e(a1), d0                                    ; $00510C
        move.b       (a3, d0.w), (a0)                              ; $005110
        addq.w       #$4, a0                                       ; $005114
        move.b       $10(a1), d0                                   ; $005116
        move.b       (a3, d0.w), (a0)                              ; $00511A
        addq.w       #$4, a0                                       ; $00511E
        move.b       $11(a1), d0                                   ; $005120
        move.b       (a3, d0.w), (a0)                              ; $005124
        addq.w       #$4, a0                                       ; $005128
        move.b       $13(a1), d0                                   ; $00512A
        move.b       (a3, d0.w), (a0)                              ; $00512E
        addq.w       #$4, a0                                       ; $005132
        move.b       $15(a1), d0                                   ; $005134
        move.b       (a3, d0.w), (a0)                              ; $005138
        addq.w       #$4, a0                                       ; $00513C
        move.b       $16(a1), d0                                   ; $00513E
        move.b       (a3, d0.w), (a0)                              ; $005142
        addq.w       #$4, a0                                       ; $005146
        move.b       $18(a1), d0                                   ; $005148
        move.b       (a3, d0.w), (a0)                              ; $00514C
        addq.w       #$4, a0                                       ; $005150
        move.b       $1a(a1), d0                                   ; $005152
        move.b       (a3, d0.w), (a0)                              ; $005156
        addq.w       #$4, a0                                       ; $00515A
        move.b       $1b(a1), d0                                   ; $00515C
        move.b       (a3, d0.w), (a0)                              ; $005160
        addq.w       #$4, a0                                       ; $005164
        move.b       $1d(a1), d0                                   ; $005166
        move.b       (a3, d0.w), (a0)                              ; $00516A
        addq.w       #$4, a0                                       ; $00516E
        move.b       $1f(a1), d0                                   ; $005170
        move.b       (a3, d0.w), (a0)                              ; $005174
        addq.w       #$4, a0                                       ; $005178
        move.b       (a2), d0                                      ; $00517A
        move.b       (a3, d0.w), (a0)                              ; $00517C
        addq.w       #$4, a0                                       ; $005180
        move.b       $2(a2), d0                                    ; $005182
        move.b       (a3, d0.w), (a0)                              ; $005186
        addq.w       #$4, a0                                       ; $00518A
        move.b       $4(a2), d0                                    ; $00518C
        move.b       (a3, d0.w), (a0)                              ; $005190
        addq.w       #$4, a0                                       ; $005194
        move.b       $5(a2), d0                                    ; $005196
        move.b       (a3, d0.w), (a0)                              ; $00519A
        addq.w       #$4, a0                                       ; $00519E
        move.b       $7(a2), d0                                    ; $0051A0
        move.b       (a3, d0.w), (a0)                              ; $0051A4
        addq.w       #$4, a0                                       ; $0051A8
        move.b       $9(a2), d0                                    ; $0051AA
        move.b       (a3, d0.w), (a0)                              ; $0051AE
        addq.w       #$4, a0                                       ; $0051B2
        move.b       $a(a2), d0                                    ; $0051B4
        move.b       (a3, d0.w), (a0)                              ; $0051B8
        addq.w       #$4, a0                                       ; $0051BC
        move.b       $c(a2), d0                                    ; $0051BE
        move.b       (a3, d0.w), (a0)                              ; $0051C2
        addq.w       #$4, a0                                       ; $0051C6
        move.b       $e(a2), d0                                    ; $0051C8
        move.b       (a3, d0.w), (a0)                              ; $0051CC
        addq.w       #$4, a0                                       ; $0051D0
        move.b       $10(a2), d0                                   ; $0051D2
        move.b       (a3, d0.w), (a0)                              ; $0051D6
        addq.w       #$4, a0                                       ; $0051DA
        move.b       $11(a2), d0                                   ; $0051DC
        move.b       (a3, d0.w), (a0)                              ; $0051E0
        addq.w       #$4, a0                                       ; $0051E4
        move.b       $13(a2), d0                                   ; $0051E6
        move.b       (a3, d0.w), (a0)                              ; $0051EA
        addq.w       #$4, a0                                       ; $0051EE
        move.b       $15(a2), d0                                   ; $0051F0
        move.b       (a3, d0.w), (a0)                              ; $0051F4
        addq.w       #$4, a0                                       ; $0051F8
        move.b       $16(a2), d0                                   ; $0051FA
        move.b       (a3, d0.w), (a0)                              ; $0051FE
        addq.w       #$4, a0                                       ; $005202
        move.b       $18(a2), d0                                   ; $005204
        move.b       (a3, d0.w), (a0)                              ; $005208
        addq.w       #$4, a0                                       ; $00520C
        move.b       $1a(a2), d0                                   ; $00520E
        move.b       (a3, d0.w), (a0)                              ; $005212
        addq.w       #$4, a0                                       ; $005216
        move.b       $1b(a2), d0                                   ; $005218
        move.b       (a3, d0.w), (a0)                              ; $00521C
        addq.w       #$4, a0                                       ; $005220
        move.b       $1d(a2), d0                                   ; $005222
        move.b       (a3, d0.w), (a0)                              ; $005226
        addq.w       #$4, a0                                       ; $00522A
        move.b       $1f(a2), d0                                   ; $00522C
        move.b       (a3, d0.w), (a0)                              ; $005230
        addq.w       #$4, a0                                       ; $005234
        lea.l        $26(a5), a5                                   ; $005236
        movea.l      $8(a7), a3                                    ; $00523A
        jmp          (a3)                                          ; $00523E

loc_005240:
        movea.l      $4(a7), a3                                    ; $005240
        jsr          (a3)                                          ; $005244
        movea.l      rActiveWallColorRemap0(a6), a3                ; $005246
        clr.w        d0                                            ; $00524A
        move.b       (a1), d0                                      ; $00524C
        move.b       (a3, d0.w), (a0)                              ; $00524E
        addq.w       #$4, a0                                       ; $005252
        move.b       $2(a1), d0                                    ; $005254
        move.b       (a3, d0.w), (a0)                              ; $005258
        addq.w       #$4, a0                                       ; $00525C
        move.b       $4(a1), d0                                    ; $00525E
        move.b       (a3, d0.w), (a0)                              ; $005262
        addq.w       #$4, a0                                       ; $005266
        move.b       $5(a1), d0                                    ; $005268
        move.b       (a3, d0.w), (a0)                              ; $00526C
        addq.w       #$4, a0                                       ; $005270
        move.b       $7(a1), d0                                    ; $005272
        move.b       (a3, d0.w), (a0)                              ; $005276
        addq.w       #$4, a0                                       ; $00527A
        move.b       $8(a1), d0                                    ; $00527C
        move.b       (a3, d0.w), (a0)                              ; $005280
        addq.w       #$4, a0                                       ; $005284
        move.b       $a(a1), d0                                    ; $005286
        move.b       (a3, d0.w), (a0)                              ; $00528A
        addq.w       #$4, a0                                       ; $00528E
        move.b       $c(a1), d0                                    ; $005290
        move.b       (a3, d0.w), (a0)                              ; $005294
        addq.w       #$4, a0                                       ; $005298
        move.b       $d(a1), d0                                    ; $00529A
        move.b       (a3, d0.w), (a0)                              ; $00529E
        addq.w       #$4, a0                                       ; $0052A2
        move.b       $f(a1), d0                                    ; $0052A4
        move.b       (a3, d0.w), (a0)                              ; $0052A8
        addq.w       #$4, a0                                       ; $0052AC
        move.b       $10(a1), d0                                   ; $0052AE
        move.b       (a3, d0.w), (a0)                              ; $0052B2
        addq.w       #$4, a0                                       ; $0052B6
        move.b       $12(a1), d0                                   ; $0052B8
        move.b       (a3, d0.w), (a0)                              ; $0052BC
        addq.w       #$4, a0                                       ; $0052C0
        move.b       $14(a1), d0                                   ; $0052C2
        move.b       (a3, d0.w), (a0)                              ; $0052C6
        addq.w       #$4, a0                                       ; $0052CA
        move.b       $15(a1), d0                                   ; $0052CC
        move.b       (a3, d0.w), (a0)                              ; $0052D0
        addq.w       #$4, a0                                       ; $0052D4
        move.b       $17(a1), d0                                   ; $0052D6
        move.b       (a3, d0.w), (a0)                              ; $0052DA
        addq.w       #$4, a0                                       ; $0052DE
        move.b       $18(a1), d0                                   ; $0052E0
        move.b       (a3, d0.w), (a0)                              ; $0052E4
        addq.w       #$4, a0                                       ; $0052E8
        move.b       $1a(a1), d0                                   ; $0052EA
        move.b       (a3, d0.w), (a0)                              ; $0052EE
        addq.w       #$4, a0                                       ; $0052F2
        move.b       $1c(a1), d0                                   ; $0052F4
        move.b       (a3, d0.w), (a0)                              ; $0052F8
        addq.w       #$4, a0                                       ; $0052FC
        move.b       $1d(a1), d0                                   ; $0052FE
        move.b       (a3, d0.w), (a0)                              ; $005302
        addq.w       #$4, a0                                       ; $005306
        move.b       $1f(a1), d0                                   ; $005308
        move.b       (a3, d0.w), (a0)                              ; $00530C
        addq.w       #$4, a0                                       ; $005310
        move.b       (a2), d0                                      ; $005312
        move.b       (a3, d0.w), (a0)                              ; $005314
        addq.w       #$4, a0                                       ; $005318
        move.b       $2(a2), d0                                    ; $00531A
        move.b       (a3, d0.w), (a0)                              ; $00531E
        addq.w       #$4, a0                                       ; $005322
        move.b       $4(a2), d0                                    ; $005324
        move.b       (a3, d0.w), (a0)                              ; $005328
        addq.w       #$4, a0                                       ; $00532C
        move.b       $5(a2), d0                                    ; $00532E
        move.b       (a3, d0.w), (a0)                              ; $005332
        addq.w       #$4, a0                                       ; $005336
        move.b       $7(a2), d0                                    ; $005338
        move.b       (a3, d0.w), (a0)                              ; $00533C
        addq.w       #$4, a0                                       ; $005340
        move.b       $8(a2), d0                                    ; $005342
        move.b       (a3, d0.w), (a0)                              ; $005346
        addq.w       #$4, a0                                       ; $00534A
        move.b       $a(a2), d0                                    ; $00534C
        move.b       (a3, d0.w), (a0)                              ; $005350
        addq.w       #$4, a0                                       ; $005354
        move.b       $c(a2), d0                                    ; $005356
        move.b       (a3, d0.w), (a0)                              ; $00535A
        addq.w       #$4, a0                                       ; $00535E
        move.b       $d(a2), d0                                    ; $005360
        move.b       (a3, d0.w), (a0)                              ; $005364
        addq.w       #$4, a0                                       ; $005368
        move.b       $f(a2), d0                                    ; $00536A
        move.b       (a3, d0.w), (a0)                              ; $00536E
        addq.w       #$4, a0                                       ; $005372
        move.b       $10(a2), d0                                   ; $005374
        move.b       (a3, d0.w), (a0)                              ; $005378
        addq.w       #$4, a0                                       ; $00537C
        move.b       $12(a2), d0                                   ; $00537E
        move.b       (a3, d0.w), (a0)                              ; $005382
        addq.w       #$4, a0                                       ; $005386
        move.b       $14(a2), d0                                   ; $005388
        move.b       (a3, d0.w), (a0)                              ; $00538C
        addq.w       #$4, a0                                       ; $005390
        move.b       $15(a2), d0                                   ; $005392
        move.b       (a3, d0.w), (a0)                              ; $005396
        addq.w       #$4, a0                                       ; $00539A
        move.b       $17(a2), d0                                   ; $00539C
        move.b       (a3, d0.w), (a0)                              ; $0053A0
        addq.w       #$4, a0                                       ; $0053A4
        move.b       $18(a2), d0                                   ; $0053A6
        move.b       (a3, d0.w), (a0)                              ; $0053AA
        addq.w       #$4, a0                                       ; $0053AE
        move.b       $1a(a2), d0                                   ; $0053B0
        move.b       (a3, d0.w), (a0)                              ; $0053B4
        addq.w       #$4, a0                                       ; $0053B8
        move.b       $1c(a2), d0                                   ; $0053BA
        move.b       (a3, d0.w), (a0)                              ; $0053BE
        addq.w       #$4, a0                                       ; $0053C2
        move.b       $1d(a2), d0                                   ; $0053C4
        move.b       (a3, d0.w), (a0)                              ; $0053C8
        addq.w       #$4, a0                                       ; $0053CC
        move.b       $1f(a2), d0                                   ; $0053CE
        move.b       (a3, d0.w), (a0)                              ; $0053D2
        addq.w       #$4, a0                                       ; $0053D6
        lea.l        $28(a5), a5                                   ; $0053D8
        movea.l      $8(a7), a3                                    ; $0053DC
        jmp          (a3)                                          ; $0053E0

loc_0053E2:
        movea.l      $4(a7), a3                                    ; $0053E2
        jsr          (a3)                                          ; $0053E6
        move.b       (a1), (a0)                                    ; $0053E8
        addq.w       #$4, a0                                       ; $0053EA
        move.b       $2(a1), (a0)                                  ; $0053EC
        addq.w       #$4, a0                                       ; $0053F0
        move.b       $3(a1), (a0)                                  ; $0053F2
        addq.w       #$4, a0                                       ; $0053F6
        move.b       $5(a1), (a0)                                  ; $0053F8
        addq.w       #$4, a0                                       ; $0053FC
        move.b       $6(a1), (a0)                                  ; $0053FE
        addq.w       #$4, a0                                       ; $005402
        move.b       $8(a1), (a0)                                  ; $005404
        addq.w       #$4, a0                                       ; $005408
        move.b       $9(a1), (a0)                                  ; $00540A
        addq.w       #$4, a0                                       ; $00540E
        move.b       $b(a1), (a0)                                  ; $005410
        addq.w       #$4, a0                                       ; $005414
        move.b       $c(a1), (a0)                                  ; $005416
        addq.w       #$4, a0                                       ; $00541A
        move.b       $e(a1), (a0)                                  ; $00541C
        addq.w       #$4, a0                                       ; $005420
        move.b       $10(a1), (a0)                                 ; $005422
        addq.w       #$4, a0                                       ; $005426
        move.b       $11(a1), (a0)                                 ; $005428
        addq.w       #$4, a0                                       ; $00542C
        move.b       $13(a1), (a0)                                 ; $00542E
        addq.w       #$4, a0                                       ; $005432
        move.b       $14(a1), (a0)                                 ; $005434
        addq.w       #$4, a0                                       ; $005438
        move.b       $16(a1), (a0)                                 ; $00543A
        addq.w       #$4, a0                                       ; $00543E
        move.b       $17(a1), (a0)                                 ; $005440
        addq.w       #$4, a0                                       ; $005444
        move.b       $19(a1), (a0)                                 ; $005446
        addq.w       #$4, a0                                       ; $00544A
        move.b       $1a(a1), (a0)                                 ; $00544C
        addq.w       #$4, a0                                       ; $005450
        move.b       $1c(a1), (a0)                                 ; $005452
        addq.w       #$4, a0                                       ; $005456
        move.b       $1d(a1), (a0)                                 ; $005458
        addq.w       #$4, a0                                       ; $00545C
        move.b       $1f(a1), (a0)                                 ; $00545E
        addq.w       #$4, a0                                       ; $005462
        move.b       (a2), (a0)                                    ; $005464
        addq.w       #$4, a0                                       ; $005466
        move.b       $2(a2), (a0)                                  ; $005468
        addq.w       #$4, a0                                       ; $00546C
        move.b       $3(a2), (a0)                                  ; $00546E
        addq.w       #$4, a0                                       ; $005472
        move.b       $5(a2), (a0)                                  ; $005474
        addq.w       #$4, a0                                       ; $005478
        move.b       $6(a2), (a0)                                  ; $00547A
        addq.w       #$4, a0                                       ; $00547E
        move.b       $8(a2), (a0)                                  ; $005480
        addq.w       #$4, a0                                       ; $005484
        move.b       $9(a2), (a0)                                  ; $005486
        addq.w       #$4, a0                                       ; $00548A
        move.b       $b(a2), (a0)                                  ; $00548C
        addq.w       #$4, a0                                       ; $005490
        move.b       $c(a2), (a0)                                  ; $005492
        addq.w       #$4, a0                                       ; $005496
        move.b       $e(a2), (a0)                                  ; $005498
        addq.w       #$4, a0                                       ; $00549C
        move.b       $10(a2), (a0)                                 ; $00549E
        addq.w       #$4, a0                                       ; $0054A2
        move.b       $11(a2), (a0)                                 ; $0054A4
        addq.w       #$4, a0                                       ; $0054A8
        move.b       $13(a2), (a0)                                 ; $0054AA
        addq.w       #$4, a0                                       ; $0054AE
        move.b       $14(a2), (a0)                                 ; $0054B0
        addq.w       #$4, a0                                       ; $0054B4
        move.b       $16(a2), (a0)                                 ; $0054B6
        addq.w       #$4, a0                                       ; $0054BA
        move.b       $17(a2), (a0)                                 ; $0054BC
        addq.w       #$4, a0                                       ; $0054C0
        move.b       $19(a2), (a0)                                 ; $0054C2
        addq.w       #$4, a0                                       ; $0054C6
        move.b       $1a(a2), (a0)                                 ; $0054C8
        addq.w       #$4, a0                                       ; $0054CC
        move.b       $1c(a2), (a0)                                 ; $0054CE
        addq.w       #$4, a0                                       ; $0054D2
        move.b       $1d(a2), (a0)                                 ; $0054D4
        addq.w       #$4, a0                                       ; $0054D8
        move.b       $1f(a2), (a0)                                 ; $0054DA
        addq.w       #$4, a0                                       ; $0054DE
        lea.l        $2a(a5), a5                                   ; $0054E0
        movea.l      $8(a7), a3                                    ; $0054E4
        jmp          (a3)                                          ; $0054E8

loc_0054EA:
        movea.l      $4(a7), a3                                    ; $0054EA
        jsr          (a3)                                          ; $0054EE
        move.b       (a1), (a0)                                    ; $0054F0
        addq.w       #$4, a0                                       ; $0054F2
        move.b       $2(a1), (a0)                                  ; $0054F4
        addq.w       #$4, a0                                       ; $0054F8
        move.b       $3(a1), (a0)                                  ; $0054FA
        addq.w       #$4, a0                                       ; $0054FE
        move.b       $5(a1), (a0)                                  ; $005500
        addq.w       #$4, a0                                       ; $005504
        move.b       $6(a1), (a0)                                  ; $005506
        addq.w       #$4, a0                                       ; $00550A
        move.b       $8(a1), (a0)                                  ; $00550C
        addq.w       #$4, a0                                       ; $005510
        move.b       $9(a1), (a0)                                  ; $005512
        addq.w       #$4, a0                                       ; $005516
        move.b       $a(a1), (a0)                                  ; $005518
        addq.w       #$4, a0                                       ; $00551C
        move.b       $c(a1), (a0)                                  ; $00551E
        addq.w       #$4, a0                                       ; $005522
        move.b       $d(a1), (a0)                                  ; $005524
        addq.w       #$4, a0                                       ; $005528
        move.b       $f(a1), (a0)                                  ; $00552A
        addq.w       #$4, a0                                       ; $00552E
        move.b       $10(a1), (a0)                                 ; $005530
        addq.w       #$4, a0                                       ; $005534
        move.b       $12(a1), (a0)                                 ; $005536
        addq.w       #$4, a0                                       ; $00553A
        move.b       $13(a1), (a0)                                 ; $00553C
        addq.w       #$4, a0                                       ; $005540
        move.b       $15(a1), (a0)                                 ; $005542
        addq.w       #$4, a0                                       ; $005546
        move.b       $16(a1), (a0)                                 ; $005548
        addq.w       #$4, a0                                       ; $00554C
        move.b       $18(a1), (a0)                                 ; $00554E
        addq.w       #$4, a0                                       ; $005552
        move.b       $19(a1), (a0)                                 ; $005554
        addq.w       #$4, a0                                       ; $005558
        move.b       $1a(a1), (a0)                                 ; $00555A
        addq.w       #$4, a0                                       ; $00555E
        move.b       $1c(a1), (a0)                                 ; $005560
        addq.w       #$4, a0                                       ; $005564
        move.b       $1d(a1), (a0)                                 ; $005566
        addq.w       #$4, a0                                       ; $00556A
        move.b       $1f(a1), (a0)                                 ; $00556C
        addq.w       #$4, a0                                       ; $005570
        move.b       (a2), (a0)                                    ; $005572
        addq.w       #$4, a0                                       ; $005574
        move.b       $2(a2), (a0)                                  ; $005576
        addq.w       #$4, a0                                       ; $00557A
        move.b       $3(a2), (a0)                                  ; $00557C
        addq.w       #$4, a0                                       ; $005580
        move.b       $5(a2), (a0)                                  ; $005582
        addq.w       #$4, a0                                       ; $005586
        move.b       $6(a2), (a0)                                  ; $005588
        addq.w       #$4, a0                                       ; $00558C
        move.b       $8(a2), (a0)                                  ; $00558E
        addq.w       #$4, a0                                       ; $005592
        move.b       $9(a2), (a0)                                  ; $005594
        addq.w       #$4, a0                                       ; $005598
        move.b       $a(a2), (a0)                                  ; $00559A
        addq.w       #$4, a0                                       ; $00559E
        move.b       $c(a2), (a0)                                  ; $0055A0
        addq.w       #$4, a0                                       ; $0055A4
        move.b       $d(a2), (a0)                                  ; $0055A6
        addq.w       #$4, a0                                       ; $0055AA
        move.b       $f(a2), (a0)                                  ; $0055AC
        addq.w       #$4, a0                                       ; $0055B0
        move.b       $10(a2), (a0)                                 ; $0055B2
        addq.w       #$4, a0                                       ; $0055B6
        move.b       $12(a2), (a0)                                 ; $0055B8
        addq.w       #$4, a0                                       ; $0055BC
        move.b       $13(a2), (a0)                                 ; $0055BE
        addq.w       #$4, a0                                       ; $0055C2
        move.b       $15(a2), (a0)                                 ; $0055C4
        addq.w       #$4, a0                                       ; $0055C8
        move.b       $16(a2), (a0)                                 ; $0055CA
        addq.w       #$4, a0                                       ; $0055CE
        move.b       $18(a2), (a0)                                 ; $0055D0
        addq.w       #$4, a0                                       ; $0055D4
        move.b       $19(a2), (a0)                                 ; $0055D6
        addq.w       #$4, a0                                       ; $0055DA
        move.b       $1a(a2), (a0)                                 ; $0055DC
        addq.w       #$4, a0                                       ; $0055E0
        move.b       $1c(a2), (a0)                                 ; $0055E2
        addq.w       #$4, a0                                       ; $0055E6
        move.b       $1d(a2), (a0)                                 ; $0055E8
        addq.w       #$4, a0                                       ; $0055EC
        move.b       $1f(a2), (a0)                                 ; $0055EE
        addq.w       #$4, a0                                       ; $0055F2
        lea.l        $2c(a5), a5                                   ; $0055F4
        movea.l      $8(a7), a3                                    ; $0055F8
        jmp          (a3)                                          ; $0055FC

loc_0055FE:
        movea.l      $4(a7), a3                                    ; $0055FE
        jsr          (a3)                                          ; $005602
        move.b       (a1), (a0)                                    ; $005604
        addq.w       #$4, a0                                       ; $005606
        addq.w       #$2, a1                                       ; $005608
        move.b       (a1)+, (a0)                                   ; $00560A
        addq.w       #$4, a0                                       ; $00560C
        move.b       (a1)+, (a0)                                   ; $00560E
        addq.w       #$4, a0                                       ; $005610
        move.b       (a1), (a0)                                    ; $005612
        addq.w       #$2, a1                                       ; $005614
        addq.w       #$4, a0                                       ; $005616
        move.b       (a1)+, (a0)                                   ; $005618
        addq.w       #$4, a0                                       ; $00561A
        move.b       (a1), (a0)                                    ; $00561C
        addq.w       #$2, a1                                       ; $00561E
        addq.w       #$4, a0                                       ; $005620
        move.b       (a1)+, (a0)                                   ; $005622
        addq.w       #$4, a0                                       ; $005624
        move.b       (a1)+, (a0)                                   ; $005626
        addq.w       #$4, a0                                       ; $005628
        move.b       (a1), (a0)                                    ; $00562A
        addq.w       #$2, a1                                       ; $00562C
        addq.w       #$4, a0                                       ; $00562E
        move.b       (a1)+, (a0)                                   ; $005630
        addq.w       #$4, a0                                       ; $005632
        move.b       (a1), (a0)                                    ; $005634
        addq.w       #$2, a1                                       ; $005636
        addq.w       #$4, a0                                       ; $005638
        move.b       (a1)+, (a0)                                   ; $00563A
        addq.w       #$4, a0                                       ; $00563C
        move.b       (a1)+, (a0)                                   ; $00563E
        addq.w       #$4, a0                                       ; $005640
        move.b       (a1), (a0)                                    ; $005642
        addq.w       #$2, a1                                       ; $005644
        addq.w       #$4, a0                                       ; $005646
        move.b       (a1)+, (a0)                                   ; $005648
        addq.w       #$4, a0                                       ; $00564A
        move.b       (a1)+, (a0)                                   ; $00564C
        addq.w       #$4, a0                                       ; $00564E
        move.b       (a1), (a0)                                    ; $005650
        addq.w       #$2, a1                                       ; $005652
        addq.w       #$4, a0                                       ; $005654
        move.b       (a1)+, (a0)                                   ; $005656
        addq.w       #$4, a0                                       ; $005658
        move.b       (a1), (a0)                                    ; $00565A
        addq.w       #$2, a1                                       ; $00565C
        addq.w       #$4, a0                                       ; $00565E
        move.b       (a1)+, (a0)                                   ; $005660
        addq.w       #$4, a0                                       ; $005662
        move.b       (a1)+, (a0)                                   ; $005664
        addq.w       #$4, a0                                       ; $005666
        move.b       (a1), (a0)                                    ; $005668
        addq.w       #$2, a1                                       ; $00566A
        addq.w       #$4, a0                                       ; $00566C
        move.b       (a1)+, (a0)                                   ; $00566E
        addq.w       #$4, a0                                       ; $005670
        lea.l        -$20(a1), a1                                  ; $005672
        move.b       (a2), (a0)                                    ; $005676
        addq.w       #$4, a0                                       ; $005678
        addq.w       #$2, a2                                       ; $00567A
        move.b       (a2)+, (a0)                                   ; $00567C
        addq.w       #$4, a0                                       ; $00567E
        move.b       (a2)+, (a0)                                   ; $005680
        addq.w       #$4, a0                                       ; $005682
        move.b       (a2), (a0)                                    ; $005684
        addq.w       #$2, a2                                       ; $005686
        addq.w       #$4, a0                                       ; $005688
        move.b       (a2)+, (a0)                                   ; $00568A
        addq.w       #$4, a0                                       ; $00568C
        move.b       (a2), (a0)                                    ; $00568E
        addq.w       #$2, a2                                       ; $005690
        addq.w       #$4, a0                                       ; $005692
        move.b       (a2)+, (a0)                                   ; $005694
        addq.w       #$4, a0                                       ; $005696
        move.b       (a2)+, (a0)                                   ; $005698
        addq.w       #$4, a0                                       ; $00569A
        move.b       (a2), (a0)                                    ; $00569C
        addq.w       #$2, a2                                       ; $00569E
        addq.w       #$4, a0                                       ; $0056A0
        move.b       (a2)+, (a0)                                   ; $0056A2
        addq.w       #$4, a0                                       ; $0056A4
        move.b       (a2), (a0)                                    ; $0056A6
        addq.w       #$2, a2                                       ; $0056A8
        addq.w       #$4, a0                                       ; $0056AA
        move.b       (a2)+, (a0)                                   ; $0056AC
        addq.w       #$4, a0                                       ; $0056AE
        move.b       (a2)+, (a0)                                   ; $0056B0
        addq.w       #$4, a0                                       ; $0056B2
        move.b       (a2), (a0)                                    ; $0056B4
        addq.w       #$2, a2                                       ; $0056B6
        addq.w       #$4, a0                                       ; $0056B8
        move.b       (a2)+, (a0)                                   ; $0056BA
        addq.w       #$4, a0                                       ; $0056BC
        move.b       (a2)+, (a0)                                   ; $0056BE
        addq.w       #$4, a0                                       ; $0056C0
        move.b       (a2), (a0)                                    ; $0056C2
        addq.w       #$2, a2                                       ; $0056C4
        addq.w       #$4, a0                                       ; $0056C6
        move.b       (a2)+, (a0)                                   ; $0056C8
        addq.w       #$4, a0                                       ; $0056CA
        move.b       (a2), (a0)                                    ; $0056CC
        addq.w       #$2, a2                                       ; $0056CE
        addq.w       #$4, a0                                       ; $0056D0
        move.b       (a2)+, (a0)                                   ; $0056D2
        addq.w       #$4, a0                                       ; $0056D4
        move.b       (a2)+, (a0)                                   ; $0056D6
        addq.w       #$4, a0                                       ; $0056D8
        move.b       (a2), (a0)                                    ; $0056DA
        addq.w       #$2, a2                                       ; $0056DC
        addq.w       #$4, a0                                       ; $0056DE
        move.b       (a2)+, (a0)                                   ; $0056E0
        addq.w       #$4, a0                                       ; $0056E2
        lea.l        -$20(a2), a2                                  ; $0056E4
        lea.l        $2e(a5), a5                                   ; $0056E8
        movea.l      $8(a7), a3                                    ; $0056EC
        jmp          (a3)                                          ; $0056F0

loc_0056F2:
        movea.l      $4(a7), a3                                    ; $0056F2
        jsr          (a3)                                          ; $0056F6
        move.b       (a1), (a0)                                    ; $0056F8
        addq.w       #$2, a1                                       ; $0056FA
        addq.w       #$4, a0                                       ; $0056FC
        move.b       (a1)+, (a0)                                   ; $0056FE
        addq.w       #$4, a0                                       ; $005700
        move.b       (a1)+, (a0)                                   ; $005702
        addq.w       #$4, a0                                       ; $005704
        move.b       (a1), (a0)                                    ; $005706
        addq.w       #$2, a1                                       ; $005708
        addq.w       #$4, a0                                       ; $00570A
        move.b       (a1)+, (a0)                                   ; $00570C
        addq.w       #$4, a0                                       ; $00570E
        move.b       (a1)+, (a0)                                   ; $005710
        addq.w       #$4, a0                                       ; $005712
        move.b       (a1), (a0)                                    ; $005714
        addq.w       #$2, a1                                       ; $005716
        addq.w       #$4, a0                                       ; $005718
        move.b       (a1)+, (a0)                                   ; $00571A
        addq.w       #$4, a0                                       ; $00571C
        move.b       (a1)+, (a0)                                   ; $00571E
        addq.w       #$4, a0                                       ; $005720
        move.b       (a1), (a0)                                    ; $005722
        addq.w       #$2, a1                                       ; $005724
        addq.w       #$4, a0                                       ; $005726
        move.b       (a1)+, (a0)                                   ; $005728
        addq.w       #$4, a0                                       ; $00572A
        move.b       (a1)+, (a0)                                   ; $00572C
        addq.w       #$4, a0                                       ; $00572E
        move.b       (a1), (a0)                                    ; $005730
        addq.w       #$2, a1                                       ; $005732
        addq.w       #$4, a0                                       ; $005734
        move.b       (a1)+, (a0)                                   ; $005736
        addq.w       #$4, a0                                       ; $005738
        move.b       (a1)+, (a0)                                   ; $00573A
        addq.w       #$4, a0                                       ; $00573C
        move.b       (a1), (a0)                                    ; $00573E
        addq.w       #$2, a1                                       ; $005740
        addq.w       #$4, a0                                       ; $005742
        move.b       (a1)+, (a0)                                   ; $005744
        addq.w       #$4, a0                                       ; $005746
        move.b       (a1)+, (a0)                                   ; $005748
        addq.w       #$4, a0                                       ; $00574A
        move.b       (a1), (a0)                                    ; $00574C
        addq.w       #$2, a1                                       ; $00574E
        addq.w       #$4, a0                                       ; $005750
        move.b       (a1)+, (a0)                                   ; $005752
        addq.w       #$4, a0                                       ; $005754
        move.b       (a1)+, (a0)                                   ; $005756
        addq.w       #$4, a0                                       ; $005758
        move.b       (a1), (a0)                                    ; $00575A
        addq.w       #$4, a0                                       ; $00575C
        addq.w       #$2, a1                                       ; $00575E
        move.b       (a1)+, (a0)                                   ; $005760
        addq.w       #$4, a0                                       ; $005762
        move.b       (a1)+, (a0)                                   ; $005764
        addq.w       #$4, a0                                       ; $005766
        lea.l        -$20(a1), a1                                  ; $005768
        move.b       (a2), (a0)                                    ; $00576C
        addq.w       #$2, a2                                       ; $00576E
        addq.w       #$4, a0                                       ; $005770
        move.b       (a2)+, (a0)                                   ; $005772
        addq.w       #$4, a0                                       ; $005774
        move.b       (a2)+, (a0)                                   ; $005776
        addq.w       #$4, a0                                       ; $005778
        move.b       (a2), (a0)                                    ; $00577A
        addq.w       #$2, a2                                       ; $00577C
        addq.w       #$4, a0                                       ; $00577E
        move.b       (a2)+, (a0)                                   ; $005780
        addq.w       #$4, a0                                       ; $005782
        move.b       (a2)+, (a0)                                   ; $005784
        addq.w       #$4, a0                                       ; $005786
        move.b       (a2), (a0)                                    ; $005788
        addq.w       #$2, a2                                       ; $00578A
        addq.w       #$4, a0                                       ; $00578C
        move.b       (a2)+, (a0)                                   ; $00578E
        addq.w       #$4, a0                                       ; $005790
        move.b       (a2)+, (a0)                                   ; $005792
        addq.w       #$4, a0                                       ; $005794
        move.b       (a2), (a0)                                    ; $005796
        addq.w       #$2, a2                                       ; $005798
        addq.w       #$4, a0                                       ; $00579A
        move.b       (a2)+, (a0)                                   ; $00579C
        addq.w       #$4, a0                                       ; $00579E
        move.b       (a2)+, (a0)                                   ; $0057A0
        addq.w       #$4, a0                                       ; $0057A2
        move.b       (a2), (a0)                                    ; $0057A4
        addq.w       #$2, a2                                       ; $0057A6
        addq.w       #$4, a0                                       ; $0057A8
        move.b       (a2)+, (a0)                                   ; $0057AA
        addq.w       #$4, a0                                       ; $0057AC
        move.b       (a2)+, (a0)                                   ; $0057AE
        addq.w       #$4, a0                                       ; $0057B0
        move.b       (a2), (a0)                                    ; $0057B2
        addq.w       #$2, a2                                       ; $0057B4
        addq.w       #$4, a0                                       ; $0057B6
        move.b       (a2)+, (a0)                                   ; $0057B8
        addq.w       #$4, a0                                       ; $0057BA
        move.b       (a2)+, (a0)                                   ; $0057BC
        addq.w       #$4, a0                                       ; $0057BE
        move.b       (a2), (a0)                                    ; $0057C0
        addq.w       #$2, a2                                       ; $0057C2
        addq.w       #$4, a0                                       ; $0057C4
        move.b       (a2)+, (a0)                                   ; $0057C6
        addq.w       #$4, a0                                       ; $0057C8
        move.b       (a2)+, (a0)                                   ; $0057CA
        addq.w       #$4, a0                                       ; $0057CC
        move.b       (a2), (a0)                                    ; $0057CE
        addq.w       #$4, a0                                       ; $0057D0
        addq.w       #$2, a2                                       ; $0057D2
        move.b       (a2)+, (a0)                                   ; $0057D4
        addq.w       #$4, a0                                       ; $0057D6
        move.b       (a2)+, (a0)                                   ; $0057D8
        addq.w       #$4, a0                                       ; $0057DA
        lea.l        -$20(a2), a2                                  ; $0057DC
        lea.l        $30(a5), a5                                   ; $0057E0
        movea.l      $8(a7), a3                                    ; $0057E4
        jmp          (a3)                                          ; $0057E8

loc_0057EA:
        movea.l      $4(a7), a3                                    ; $0057EA
        jsr          (a3)                                          ; $0057EE
        move.b       (a1)+, (a0)                                   ; $0057F0
        addq.w       #$4, a0                                       ; $0057F2
        move.b       (a1), (a0)                                    ; $0057F4
        addq.w       #$2, a1                                       ; $0057F6
        addq.w       #$4, a0                                       ; $0057F8
        move.b       (a1)+, (a0)                                   ; $0057FA
        addq.w       #$4, a0                                       ; $0057FC
        move.b       (a1)+, (a0)                                   ; $0057FE
        addq.w       #$4, a0                                       ; $005800
        move.b       (a1), (a0)                                    ; $005802
        addq.w       #$2, a1                                       ; $005804
        addq.w       #$4, a0                                       ; $005806
        move.b       (a1)+, (a0)                                   ; $005808
        addq.w       #$4, a0                                       ; $00580A
        move.b       (a1)+, (a0)                                   ; $00580C
        addq.w       #$4, a0                                       ; $00580E
        move.b       (a1)+, (a0)                                   ; $005810
        addq.w       #$4, a0                                       ; $005812
        move.b       (a1), (a0)                                    ; $005814
        addq.w       #$2, a1                                       ; $005816
        addq.w       #$4, a0                                       ; $005818
        move.b       (a1)+, (a0)                                   ; $00581A
        addq.w       #$4, a0                                       ; $00581C
        move.b       (a1)+, (a0)                                   ; $00581E
        addq.w       #$4, a0                                       ; $005820
        move.b       (a1), (a0)                                    ; $005822
        addq.w       #$2, a1                                       ; $005824
        addq.w       #$4, a0                                       ; $005826
        move.b       (a1)+, (a0)                                   ; $005828
        addq.w       #$4, a0                                       ; $00582A
        move.b       (a1)+, (a0)                                   ; $00582C
        addq.w       #$4, a0                                       ; $00582E
        move.b       (a1)+, (a0)                                   ; $005830
        addq.w       #$4, a0                                       ; $005832
        move.b       (a1), (a0)                                    ; $005834
        addq.w       #$2, a1                                       ; $005836
        addq.w       #$4, a0                                       ; $005838
        move.b       (a1)+, (a0)                                   ; $00583A
        addq.w       #$4, a0                                       ; $00583C
        move.b       (a1)+, (a0)                                   ; $00583E
        addq.w       #$4, a0                                       ; $005840
        move.b       (a1)+, (a0)                                   ; $005842
        addq.w       #$4, a0                                       ; $005844
        move.b       (a1), (a0)                                    ; $005846
        addq.w       #$2, a1                                       ; $005848
        addq.w       #$4, a0                                       ; $00584A
        move.b       (a1)+, (a0)                                   ; $00584C
        addq.w       #$4, a0                                       ; $00584E
        move.b       (a1)+, (a0)                                   ; $005850
        addq.w       #$4, a0                                       ; $005852
        move.b       (a1), (a0)                                    ; $005854
        addq.w       #$2, a1                                       ; $005856
        addq.w       #$4, a0                                       ; $005858
        move.b       (a1)+, (a0)                                   ; $00585A
        addq.w       #$4, a0                                       ; $00585C
        move.b       (a1)+, (a0)                                   ; $00585E
        addq.w       #$4, a0                                       ; $005860
        lea.l        -$20(a1), a1                                  ; $005862
        move.b       (a2)+, (a0)                                   ; $005866
        addq.w       #$4, a0                                       ; $005868
        move.b       (a2), (a0)                                    ; $00586A
        addq.w       #$2, a2                                       ; $00586C
        addq.w       #$4, a0                                       ; $00586E
        move.b       (a2)+, (a0)                                   ; $005870
        addq.w       #$4, a0                                       ; $005872
        move.b       (a2)+, (a0)                                   ; $005874
        addq.w       #$4, a0                                       ; $005876
        move.b       (a2), (a0)                                    ; $005878
        addq.w       #$2, a2                                       ; $00587A
        addq.w       #$4, a0                                       ; $00587C
        move.b       (a2)+, (a0)                                   ; $00587E
        addq.w       #$4, a0                                       ; $005880
        move.b       (a2)+, (a0)                                   ; $005882
        addq.w       #$4, a0                                       ; $005884
        move.b       (a2)+, (a0)                                   ; $005886
        addq.w       #$4, a0                                       ; $005888
        move.b       (a2), (a0)                                    ; $00588A
        addq.w       #$2, a2                                       ; $00588C
        addq.w       #$4, a0                                       ; $00588E
        move.b       (a2)+, (a0)                                   ; $005890
        addq.w       #$4, a0                                       ; $005892
        move.b       (a2)+, (a0)                                   ; $005894
        addq.w       #$4, a0                                       ; $005896
        move.b       (a2), (a0)                                    ; $005898
        addq.w       #$2, a2                                       ; $00589A
        addq.w       #$4, a0                                       ; $00589C
        move.b       (a2)+, (a0)                                   ; $00589E
        addq.w       #$4, a0                                       ; $0058A0
        move.b       (a2)+, (a0)                                   ; $0058A2
        addq.w       #$4, a0                                       ; $0058A4
        move.b       (a2)+, (a0)                                   ; $0058A6
        addq.w       #$4, a0                                       ; $0058A8
        move.b       (a2), (a0)                                    ; $0058AA
        addq.w       #$2, a2                                       ; $0058AC
        addq.w       #$4, a0                                       ; $0058AE
        move.b       (a2)+, (a0)                                   ; $0058B0
        addq.w       #$4, a0                                       ; $0058B2
        move.b       (a2)+, (a0)                                   ; $0058B4
        addq.w       #$4, a0                                       ; $0058B6
        move.b       (a2)+, (a0)                                   ; $0058B8
        addq.w       #$4, a0                                       ; $0058BA
        move.b       (a2), (a0)                                    ; $0058BC
        addq.w       #$2, a2                                       ; $0058BE
        addq.w       #$4, a0                                       ; $0058C0
        move.b       (a2)+, (a0)                                   ; $0058C2
        addq.w       #$4, a0                                       ; $0058C4
        move.b       (a2)+, (a0)                                   ; $0058C6
        addq.w       #$4, a0                                       ; $0058C8
        move.b       (a2), (a0)                                    ; $0058CA
        addq.w       #$2, a2                                       ; $0058CC
        addq.w       #$4, a0                                       ; $0058CE
        move.b       (a2)+, (a0)                                   ; $0058D0
        addq.w       #$4, a0                                       ; $0058D2
        move.b       (a2)+, (a0)                                   ; $0058D4
        addq.w       #$4, a0                                       ; $0058D6
        lea.l        -$20(a2), a2                                  ; $0058D8
        lea.l        $32(a5), a5                                   ; $0058DC
        movea.l      $8(a7), a3                                    ; $0058E0
        jmp          (a3)                                          ; $0058E4

loc_0058E6:
        movea.l      $4(a7), a3                                    ; $0058E6
        jsr          (a3)                                          ; $0058EA
        move.b       (a1)+, (a0)                                   ; $0058EC
        addq.w       #$4, a0                                       ; $0058EE
        move.b       (a1), (a0)                                    ; $0058F0
        addq.w       #$2, a1                                       ; $0058F2
        addq.w       #$4, a0                                       ; $0058F4
        move.b       (a1)+, (a0)                                   ; $0058F6
        addq.w       #$4, a0                                       ; $0058F8
        move.b       (a1)+, (a0)                                   ; $0058FA
        addq.w       #$4, a0                                       ; $0058FC
        move.b       (a1)+, (a0)                                   ; $0058FE
        addq.w       #$4, a0                                       ; $005900
        move.b       (a1), (a0)                                    ; $005902
        addq.w       #$2, a1                                       ; $005904
        addq.w       #$4, a0                                       ; $005906
        move.b       (a1)+, (a0)                                   ; $005908
        addq.w       #$4, a0                                       ; $00590A
        move.b       (a1)+, (a0)                                   ; $00590C
        addq.w       #$4, a0                                       ; $00590E
        move.b       (a1)+, (a0)                                   ; $005910
        addq.w       #$4, a0                                       ; $005912
        move.b       (a1)+, (a0)                                   ; $005914
        addq.w       #$4, a0                                       ; $005916
        move.b       (a1), (a0)                                    ; $005918
        addq.w       #$2, a1                                       ; $00591A
        addq.w       #$4, a0                                       ; $00591C
        move.b       (a1)+, (a0)                                   ; $00591E
        addq.w       #$4, a0                                       ; $005920
        move.b       (a1)+, (a0)                                   ; $005922
        addq.w       #$4, a0                                       ; $005924
        move.b       (a1)+, (a0)                                   ; $005926
        addq.w       #$4, a0                                       ; $005928
        move.b       (a1), (a0)                                    ; $00592A
        addq.w       #$2, a1                                       ; $00592C
        addq.w       #$4, a0                                       ; $00592E
        move.b       (a1)+, (a0)                                   ; $005930
        addq.w       #$4, a0                                       ; $005932
        move.b       (a1)+, (a0)                                   ; $005934
        addq.w       #$4, a0                                       ; $005936
        move.b       (a1)+, (a0)                                   ; $005938
        addq.w       #$4, a0                                       ; $00593A
        move.b       (a1), (a0)                                    ; $00593C
        addq.w       #$2, a1                                       ; $00593E
        addq.w       #$4, a0                                       ; $005940
        move.b       (a1)+, (a0)                                   ; $005942
        addq.w       #$4, a0                                       ; $005944
        move.b       (a1)+, (a0)                                   ; $005946
        addq.w       #$4, a0                                       ; $005948
        move.b       (a1)+, (a0)                                   ; $00594A
        addq.w       #$4, a0                                       ; $00594C
        move.b       (a1)+, (a0)                                   ; $00594E
        addq.w       #$4, a0                                       ; $005950
        move.b       (a1), (a0)                                    ; $005952
        addq.w       #$2, a1                                       ; $005954
        addq.w       #$4, a0                                       ; $005956
        move.b       (a1)+, (a0)                                   ; $005958
        addq.w       #$4, a0                                       ; $00595A
        move.b       (a1)+, (a0)                                   ; $00595C
        addq.w       #$4, a0                                       ; $00595E
        lea.l        -$20(a1), a1                                  ; $005960
        move.b       (a2)+, (a0)                                   ; $005964
        addq.w       #$4, a0                                       ; $005966
        move.b       (a2), (a0)                                    ; $005968
        addq.w       #$2, a2                                       ; $00596A
        addq.w       #$4, a0                                       ; $00596C
        move.b       (a2)+, (a0)                                   ; $00596E
        addq.w       #$4, a0                                       ; $005970
        move.b       (a2)+, (a0)                                   ; $005972
        addq.w       #$4, a0                                       ; $005974
        move.b       (a2)+, (a0)                                   ; $005976
        addq.w       #$4, a0                                       ; $005978
        move.b       (a2), (a0)                                    ; $00597A
        addq.w       #$2, a2                                       ; $00597C
        addq.w       #$4, a0                                       ; $00597E
        move.b       (a2)+, (a0)                                   ; $005980
        addq.w       #$4, a0                                       ; $005982
        move.b       (a2)+, (a0)                                   ; $005984
        addq.w       #$4, a0                                       ; $005986
        move.b       (a2)+, (a0)                                   ; $005988
        addq.w       #$4, a0                                       ; $00598A
        move.b       (a2)+, (a0)                                   ; $00598C
        addq.w       #$4, a0                                       ; $00598E
        move.b       (a2), (a0)                                    ; $005990
        addq.w       #$2, a2                                       ; $005992
        addq.w       #$4, a0                                       ; $005994
        move.b       (a2)+, (a0)                                   ; $005996
        addq.w       #$4, a0                                       ; $005998
        move.b       (a2)+, (a0)                                   ; $00599A
        addq.w       #$4, a0                                       ; $00599C
        move.b       (a2)+, (a0)                                   ; $00599E
        addq.w       #$4, a0                                       ; $0059A0
        move.b       (a2), (a0)                                    ; $0059A2
        addq.w       #$2, a2                                       ; $0059A4
        addq.w       #$4, a0                                       ; $0059A6
        move.b       (a2)+, (a0)                                   ; $0059A8
        addq.w       #$4, a0                                       ; $0059AA
        move.b       (a2)+, (a0)                                   ; $0059AC
        addq.w       #$4, a0                                       ; $0059AE
        move.b       (a2)+, (a0)                                   ; $0059B0
        addq.w       #$4, a0                                       ; $0059B2
        move.b       (a2), (a0)                                    ; $0059B4
        addq.w       #$2, a2                                       ; $0059B6
        addq.w       #$4, a0                                       ; $0059B8
        move.b       (a2)+, (a0)                                   ; $0059BA
        addq.w       #$4, a0                                       ; $0059BC
        move.b       (a2)+, (a0)                                   ; $0059BE
        addq.w       #$4, a0                                       ; $0059C0
        move.b       (a2)+, (a0)                                   ; $0059C2
        addq.w       #$4, a0                                       ; $0059C4
        move.b       (a2)+, (a0)                                   ; $0059C6
        addq.w       #$4, a0                                       ; $0059C8
        move.b       (a2), (a0)                                    ; $0059CA
        addq.w       #$2, a2                                       ; $0059CC
        addq.w       #$4, a0                                       ; $0059CE
        move.b       (a2)+, (a0)                                   ; $0059D0
        addq.w       #$4, a0                                       ; $0059D2
        move.b       (a2)+, (a0)                                   ; $0059D4
        addq.w       #$4, a0                                       ; $0059D6
        lea.l        -$20(a2), a2                                  ; $0059D8
        lea.l        $34(a5), a5                                   ; $0059DC
        movea.l      $8(a7), a3                                    ; $0059E0
        jmp          (a3)                                          ; $0059E4

loc_0059E6:
        movea.l      $4(a7), a3                                    ; $0059E6
        jsr          (a3)                                          ; $0059EA
        move.b       (a1)+, (a0)                                   ; $0059EC
        addq.w       #$4, a0                                       ; $0059EE
        move.b       (a1)+, (a0)                                   ; $0059F0
        addq.w       #$4, a0                                       ; $0059F2
        move.b       (a1), (a0)                                    ; $0059F4
        addq.w       #$2, a1                                       ; $0059F6
        addq.w       #$4, a0                                       ; $0059F8
        move.b       (a1)+, (a0)                                   ; $0059FA
        addq.w       #$4, a0                                       ; $0059FC
        move.b       (a1)+, (a0)                                   ; $0059FE
        addq.w       #$4, a0                                       ; $005A00
        move.b       (a1)+, (a0)                                   ; $005A02
        addq.w       #$4, a0                                       ; $005A04
        move.b       (a1)+, (a0)                                   ; $005A06
        addq.w       #$4, a0                                       ; $005A08
        move.b       (a1), (a0)                                    ; $005A0A
        addq.w       #$2, a1                                       ; $005A0C
        addq.w       #$4, a0                                       ; $005A0E
        move.b       (a1)+, (a0)                                   ; $005A10
        addq.w       #$4, a0                                       ; $005A12
        move.b       (a1)+, (a0)                                   ; $005A14
        addq.w       #$4, a0                                       ; $005A16
        move.b       (a1)+, (a0)                                   ; $005A18
        addq.w       #$4, a0                                       ; $005A1A
        move.b       (a1)+, (a0)                                   ; $005A1C
        addq.w       #$4, a0                                       ; $005A1E
        move.b       (a1), (a0)                                    ; $005A20
        addq.w       #$2, a1                                       ; $005A22
        addq.w       #$4, a0                                       ; $005A24
        move.b       (a1)+, (a0)                                   ; $005A26
        addq.w       #$4, a0                                       ; $005A28
        move.b       (a1)+, (a0)                                   ; $005A2A
        addq.w       #$4, a0                                       ; $005A2C
        move.b       (a1)+, (a0)                                   ; $005A2E
        addq.w       #$4, a0                                       ; $005A30
        move.b       (a1)+, (a0)                                   ; $005A32
        addq.w       #$4, a0                                       ; $005A34
        move.b       (a1)+, (a0)                                   ; $005A36
        addq.w       #$4, a0                                       ; $005A38
        move.b       (a1), (a0)                                    ; $005A3A
        addq.w       #$2, a1                                       ; $005A3C
        addq.w       #$4, a0                                       ; $005A3E
        move.b       (a1)+, (a0)                                   ; $005A40
        addq.w       #$4, a0                                       ; $005A42
        move.b       (a1)+, (a0)                                   ; $005A44
        addq.w       #$4, a0                                       ; $005A46
        move.b       (a1)+, (a0)                                   ; $005A48
        addq.w       #$4, a0                                       ; $005A4A
        move.b       (a1)+, (a0)                                   ; $005A4C
        addq.w       #$4, a0                                       ; $005A4E
        move.b       (a1), (a0)                                    ; $005A50
        addq.w       #$2, a1                                       ; $005A52
        addq.w       #$4, a0                                       ; $005A54
        move.b       (a1)+, (a0)                                   ; $005A56
        addq.w       #$4, a0                                       ; $005A58
        move.b       (a1)+, (a0)                                   ; $005A5A
        addq.w       #$4, a0                                       ; $005A5C
        move.b       (a1)+, (a0)                                   ; $005A5E
        addq.w       #$4, a0                                       ; $005A60
        lea.l        -$20(a1), a1                                  ; $005A62
        move.b       (a2)+, (a0)                                   ; $005A66
        addq.w       #$4, a0                                       ; $005A68
        move.b       (a2)+, (a0)                                   ; $005A6A
        addq.w       #$4, a0                                       ; $005A6C
        move.b       (a2), (a0)                                    ; $005A6E
        addq.w       #$2, a2                                       ; $005A70
        addq.w       #$4, a0                                       ; $005A72
        move.b       (a2)+, (a0)                                   ; $005A74
        addq.w       #$4, a0                                       ; $005A76
        move.b       (a2)+, (a0)                                   ; $005A78
        addq.w       #$4, a0                                       ; $005A7A
        move.b       (a2)+, (a0)                                   ; $005A7C
        addq.w       #$4, a0                                       ; $005A7E
        move.b       (a2)+, (a0)                                   ; $005A80
        addq.w       #$4, a0                                       ; $005A82
        move.b       (a2), (a0)                                    ; $005A84
        addq.w       #$2, a2                                       ; $005A86
        addq.w       #$4, a0                                       ; $005A88
        move.b       (a2)+, (a0)                                   ; $005A8A
        addq.w       #$4, a0                                       ; $005A8C
        move.b       (a2)+, (a0)                                   ; $005A8E
        addq.w       #$4, a0                                       ; $005A90
        move.b       (a2)+, (a0)                                   ; $005A92
        addq.w       #$4, a0                                       ; $005A94
        move.b       (a2)+, (a0)                                   ; $005A96
        addq.w       #$4, a0                                       ; $005A98
        move.b       (a2), (a0)                                    ; $005A9A
        addq.w       #$2, a2                                       ; $005A9C
        addq.w       #$4, a0                                       ; $005A9E
        move.b       (a2)+, (a0)                                   ; $005AA0
        addq.w       #$4, a0                                       ; $005AA2
        move.b       (a2)+, (a0)                                   ; $005AA4
        addq.w       #$4, a0                                       ; $005AA6
        move.b       (a2)+, (a0)                                   ; $005AA8
        addq.w       #$4, a0                                       ; $005AAA
        move.b       (a2)+, (a0)                                   ; $005AAC
        addq.w       #$4, a0                                       ; $005AAE
        move.b       (a2)+, (a0)                                   ; $005AB0
        addq.w       #$4, a0                                       ; $005AB2
        move.b       (a2), (a0)                                    ; $005AB4
        addq.w       #$2, a2                                       ; $005AB6
        addq.w       #$4, a0                                       ; $005AB8
        move.b       (a2)+, (a0)                                   ; $005ABA
        addq.w       #$4, a0                                       ; $005ABC
        move.b       (a2)+, (a0)                                   ; $005ABE
        addq.w       #$4, a0                                       ; $005AC0
        move.b       (a2)+, (a0)                                   ; $005AC2
        addq.w       #$4, a0                                       ; $005AC4
        move.b       (a2)+, (a0)                                   ; $005AC6
        addq.w       #$4, a0                                       ; $005AC8
        move.b       (a2), (a0)                                    ; $005ACA
        addq.w       #$2, a2                                       ; $005ACC
        addq.w       #$4, a0                                       ; $005ACE
        move.b       (a2)+, (a0)                                   ; $005AD0
        addq.w       #$4, a0                                       ; $005AD2
        move.b       (a2)+, (a0)                                   ; $005AD4
        addq.w       #$4, a0                                       ; $005AD6
        move.b       (a2)+, (a0)                                   ; $005AD8
        addq.w       #$4, a0                                       ; $005ADA
        lea.l        -$20(a2), a2                                  ; $005ADC
        lea.l        $36(a5), a5                                   ; $005AE0
        movea.l      $8(a7), a3                                    ; $005AE4
        jmp          (a3)                                          ; $005AE8

loc_005AEA:
        movea.l      $4(a7), a3                                    ; $005AEA
        jsr          (a3)                                          ; $005AEE
        move.b       (a1)+, (a0)                                   ; $005AF0
        addq.w       #$4, a0                                       ; $005AF2
        move.b       (a1)+, (a0)                                   ; $005AF4
        addq.w       #$4, a0                                       ; $005AF6
        move.b       (a1), (a0)                                    ; $005AF8
        addq.w       #$2, a1                                       ; $005AFA
        addq.w       #$4, a0                                       ; $005AFC
        move.b       (a1)+, (a0)                                   ; $005AFE
        addq.w       #$4, a0                                       ; $005B00
        move.b       (a1)+, (a0)                                   ; $005B02
        addq.w       #$4, a0                                       ; $005B04
        move.b       (a1)+, (a0)                                   ; $005B06
        addq.w       #$4, a0                                       ; $005B08
        move.b       (a1)+, (a0)                                   ; $005B0A
        addq.w       #$4, a0                                       ; $005B0C
        move.b       (a1)+, (a0)                                   ; $005B0E
        addq.w       #$4, a0                                       ; $005B10
        move.b       (a1)+, (a0)                                   ; $005B12
        addq.w       #$4, a0                                       ; $005B14
        move.b       (a1), (a0)                                    ; $005B16
        addq.w       #$2, a1                                       ; $005B18
        addq.w       #$4, a0                                       ; $005B1A
        move.b       (a1)+, (a0)                                   ; $005B1C
        addq.w       #$4, a0                                       ; $005B1E
        move.b       (a1)+, (a0)                                   ; $005B20
        addq.w       #$4, a0                                       ; $005B22
        move.b       (a1)+, (a0)                                   ; $005B24
        addq.w       #$4, a0                                       ; $005B26
        move.b       (a1)+, (a0)                                   ; $005B28
        addq.w       #$4, a0                                       ; $005B2A
        move.b       (a1)+, (a0)                                   ; $005B2C
        addq.w       #$4, a0                                       ; $005B2E
        move.b       (a1)+, (a0)                                   ; $005B30
        addq.w       #$4, a0                                       ; $005B32
        move.b       (a1), (a0)                                    ; $005B34
        addq.w       #$2, a1                                       ; $005B36
        addq.w       #$4, a0                                       ; $005B38
        move.b       (a1)+, (a0)                                   ; $005B3A
        addq.w       #$4, a0                                       ; $005B3C
        move.b       (a1)+, (a0)                                   ; $005B3E
        addq.w       #$4, a0                                       ; $005B40
        move.b       (a1)+, (a0)                                   ; $005B42
        addq.w       #$4, a0                                       ; $005B44
        move.b       (a1)+, (a0)                                   ; $005B46
        addq.w       #$4, a0                                       ; $005B48
        move.b       (a1)+, (a0)                                   ; $005B4A
        addq.w       #$4, a0                                       ; $005B4C
        move.b       (a1)+, (a0)                                   ; $005B4E
        addq.w       #$4, a0                                       ; $005B50
        move.b       (a1), (a0)                                    ; $005B52
        addq.w       #$2, a1                                       ; $005B54
        addq.w       #$4, a0                                       ; $005B56
        move.b       (a1)+, (a0)                                   ; $005B58
        addq.w       #$4, a0                                       ; $005B5A
        move.b       (a1)+, (a0)                                   ; $005B5C
        addq.w       #$4, a0                                       ; $005B5E
        move.b       (a1)+, (a0)                                   ; $005B60
        addq.w       #$4, a0                                       ; $005B62
        move.b       (a1)+, (a0)                                   ; $005B64
        addq.w       #$4, a0                                       ; $005B66
        lea.l        -$20(a1), a1                                  ; $005B68
        move.b       (a2)+, (a0)                                   ; $005B6C
        addq.w       #$4, a0                                       ; $005B6E
        move.b       (a2)+, (a0)                                   ; $005B70
        addq.w       #$4, a0                                       ; $005B72
        move.b       (a2), (a0)                                    ; $005B74
        addq.w       #$2, a2                                       ; $005B76
        addq.w       #$4, a0                                       ; $005B78
        move.b       (a2)+, (a0)                                   ; $005B7A
        addq.w       #$4, a0                                       ; $005B7C
        move.b       (a2)+, (a0)                                   ; $005B7E
        addq.w       #$4, a0                                       ; $005B80
        move.b       (a2)+, (a0)                                   ; $005B82
        addq.w       #$4, a0                                       ; $005B84
        move.b       (a2)+, (a0)                                   ; $005B86
        addq.w       #$4, a0                                       ; $005B88
        move.b       (a2)+, (a0)                                   ; $005B8A
        addq.w       #$4, a0                                       ; $005B8C
        move.b       (a2)+, (a0)                                   ; $005B8E
        addq.w       #$4, a0                                       ; $005B90
        move.b       (a2), (a0)                                    ; $005B92
        addq.w       #$2, a2                                       ; $005B94
        addq.w       #$4, a0                                       ; $005B96
        move.b       (a2)+, (a0)                                   ; $005B98
        addq.w       #$4, a0                                       ; $005B9A
        move.b       (a2)+, (a0)                                   ; $005B9C
        addq.w       #$4, a0                                       ; $005B9E
        move.b       (a2)+, (a0)                                   ; $005BA0
        addq.w       #$4, a0                                       ; $005BA2
        move.b       (a2)+, (a0)                                   ; $005BA4
        addq.w       #$4, a0                                       ; $005BA6
        move.b       (a2)+, (a0)                                   ; $005BA8
        addq.w       #$4, a0                                       ; $005BAA
        move.b       (a2)+, (a0)                                   ; $005BAC
        addq.w       #$4, a0                                       ; $005BAE
        move.b       (a2), (a0)                                    ; $005BB0
        addq.w       #$2, a2                                       ; $005BB2
        addq.w       #$4, a0                                       ; $005BB4
        move.b       (a2)+, (a0)                                   ; $005BB6
        addq.w       #$4, a0                                       ; $005BB8
        move.b       (a2)+, (a0)                                   ; $005BBA
        addq.w       #$4, a0                                       ; $005BBC
        move.b       (a2)+, (a0)                                   ; $005BBE
        addq.w       #$4, a0                                       ; $005BC0
        move.b       (a2)+, (a0)                                   ; $005BC2
        addq.w       #$4, a0                                       ; $005BC4
        move.b       (a2)+, (a0)                                   ; $005BC6
        addq.w       #$4, a0                                       ; $005BC8
        move.b       (a2)+, (a0)                                   ; $005BCA
        addq.w       #$4, a0                                       ; $005BCC
        move.b       (a2), (a0)                                    ; $005BCE
        addq.w       #$2, a2                                       ; $005BD0
        addq.w       #$4, a0                                       ; $005BD2
        move.b       (a2)+, (a0)                                   ; $005BD4
        addq.w       #$4, a0                                       ; $005BD6
        move.b       (a2)+, (a0)                                   ; $005BD8
        addq.w       #$4, a0                                       ; $005BDA
        move.b       (a2)+, (a0)                                   ; $005BDC
        addq.w       #$4, a0                                       ; $005BDE
        move.b       (a2)+, (a0)                                   ; $005BE0
        addq.w       #$4, a0                                       ; $005BE2
        lea.l        -$20(a2), a2                                  ; $005BE4
        lea.l        $38(a5), a5                                   ; $005BE8
        movea.l      $8(a7), a3                                    ; $005BEC
        jmp          (a3)                                          ; $005BF0

loc_005BF2:
        movea.l      $4(a7), a3                                    ; $005BF2
        jsr          (a3)                                          ; $005BF6
        move.b       (a1)+, (a0)                                   ; $005BF8
        addq.w       #$4, a0                                       ; $005BFA
        move.b       (a1)+, (a0)                                   ; $005BFC
        addq.w       #$4, a0                                       ; $005BFE
        move.b       (a1)+, (a0)                                   ; $005C00
        addq.w       #$4, a0                                       ; $005C02
        move.b       (a1)+, (a0)                                   ; $005C04
        addq.w       #$4, a0                                       ; $005C06
        move.b       (a1), (a0)                                    ; $005C08
        addq.w       #$2, a1                                       ; $005C0A
        addq.w       #$4, a0                                       ; $005C0C
        move.b       (a1)+, (a0)                                   ; $005C0E
        addq.w       #$4, a0                                       ; $005C10
        move.b       (a1)+, (a0)                                   ; $005C12
        addq.w       #$4, a0                                       ; $005C14
        move.b       (a1)+, (a0)                                   ; $005C16
        addq.w       #$4, a0                                       ; $005C18
        move.b       (a1)+, (a0)                                   ; $005C1A
        addq.w       #$4, a0                                       ; $005C1C
        move.b       (a1)+, (a0)                                   ; $005C1E
        addq.w       #$4, a0                                       ; $005C20
        move.b       (a1)+, (a0)                                   ; $005C22
        addq.w       #$4, a0                                       ; $005C24
        move.b       (a1)+, (a0)                                   ; $005C26
        addq.w       #$4, a0                                       ; $005C28
        move.b       (a1)+, (a0)                                   ; $005C2A
        addq.w       #$4, a0                                       ; $005C2C
        move.b       (a1), (a0)                                    ; $005C2E
        addq.w       #$2, a1                                       ; $005C30
        addq.w       #$4, a0                                       ; $005C32
        move.b       (a1)+, (a0)                                   ; $005C34
        addq.w       #$4, a0                                       ; $005C36
        move.b       (a1)+, (a0)                                   ; $005C38
        addq.w       #$4, a0                                       ; $005C3A
        move.b       (a1)+, (a0)                                   ; $005C3C
        addq.w       #$4, a0                                       ; $005C3E
        move.b       (a1)+, (a0)                                   ; $005C40
        addq.w       #$4, a0                                       ; $005C42
        move.b       (a1)+, (a0)                                   ; $005C44
        addq.w       #$4, a0                                       ; $005C46
        move.b       (a1)+, (a0)                                   ; $005C48
        addq.w       #$4, a0                                       ; $005C4A
        move.b       (a1)+, (a0)                                   ; $005C4C
        addq.w       #$4, a0                                       ; $005C4E
        move.b       (a1)+, (a0)                                   ; $005C50
        addq.w       #$4, a0                                       ; $005C52
        move.b       (a1)+, (a0)                                   ; $005C54
        addq.w       #$4, a0                                       ; $005C56
        move.b       (a1), (a0)                                    ; $005C58
        addq.w       #$2, a1                                       ; $005C5A
        addq.w       #$4, a0                                       ; $005C5C
        move.b       (a1)+, (a0)                                   ; $005C5E
        addq.w       #$4, a0                                       ; $005C60
        move.b       (a1)+, (a0)                                   ; $005C62
        addq.w       #$4, a0                                       ; $005C64
        move.b       (a1)+, (a0)                                   ; $005C66
        addq.w       #$4, a0                                       ; $005C68
        move.b       (a1)+, (a0)                                   ; $005C6A
        addq.w       #$4, a0                                       ; $005C6C
        move.b       (a1)+, (a0)                                   ; $005C6E
        addq.w       #$4, a0                                       ; $005C70
        lea.l        -$20(a1), a1                                  ; $005C72
        move.b       (a2)+, (a0)                                   ; $005C76
        addq.w       #$4, a0                                       ; $005C78
        move.b       (a2)+, (a0)                                   ; $005C7A
        addq.w       #$4, a0                                       ; $005C7C
        move.b       (a2)+, (a0)                                   ; $005C7E
        addq.w       #$4, a0                                       ; $005C80
        move.b       (a2)+, (a0)                                   ; $005C82
        addq.w       #$4, a0                                       ; $005C84
        move.b       (a2), (a0)                                    ; $005C86
        addq.w       #$2, a2                                       ; $005C88
        addq.w       #$4, a0                                       ; $005C8A
        move.b       (a2)+, (a0)                                   ; $005C8C
        addq.w       #$4, a0                                       ; $005C8E
        move.b       (a2)+, (a0)                                   ; $005C90
        addq.w       #$4, a0                                       ; $005C92
        move.b       (a2)+, (a0)                                   ; $005C94
        addq.w       #$4, a0                                       ; $005C96
        move.b       (a2)+, (a0)                                   ; $005C98
        addq.w       #$4, a0                                       ; $005C9A
        move.b       (a2)+, (a0)                                   ; $005C9C
        addq.w       #$4, a0                                       ; $005C9E
        move.b       (a2)+, (a0)                                   ; $005CA0
        addq.w       #$4, a0                                       ; $005CA2
        move.b       (a2)+, (a0)                                   ; $005CA4
        addq.w       #$4, a0                                       ; $005CA6
        move.b       (a2)+, (a0)                                   ; $005CA8
        addq.w       #$4, a0                                       ; $005CAA
        move.b       (a2), (a0)                                    ; $005CAC
        addq.w       #$2, a2                                       ; $005CAE
        addq.w       #$4, a0                                       ; $005CB0
        move.b       (a2)+, (a0)                                   ; $005CB2
        addq.w       #$4, a0                                       ; $005CB4
        move.b       (a2)+, (a0)                                   ; $005CB6
        addq.w       #$4, a0                                       ; $005CB8
        move.b       (a2)+, (a0)                                   ; $005CBA
        addq.w       #$4, a0                                       ; $005CBC
        move.b       (a2)+, (a0)                                   ; $005CBE
        addq.w       #$4, a0                                       ; $005CC0
        move.b       (a2)+, (a0)                                   ; $005CC2
        addq.w       #$4, a0                                       ; $005CC4
        move.b       (a2)+, (a0)                                   ; $005CC6
        addq.w       #$4, a0                                       ; $005CC8
        move.b       (a2)+, (a0)                                   ; $005CCA
        addq.w       #$4, a0                                       ; $005CCC
        move.b       (a2)+, (a0)                                   ; $005CCE
        addq.w       #$4, a0                                       ; $005CD0
        move.b       (a2)+, (a0)                                   ; $005CD2
        addq.w       #$4, a0                                       ; $005CD4
        move.b       (a2), (a0)                                    ; $005CD6
        addq.w       #$2, a2                                       ; $005CD8
        addq.w       #$4, a0                                       ; $005CDA
        move.b       (a2)+, (a0)                                   ; $005CDC
        addq.w       #$4, a0                                       ; $005CDE
        move.b       (a2)+, (a0)                                   ; $005CE0
        addq.w       #$4, a0                                       ; $005CE2
        move.b       (a2)+, (a0)                                   ; $005CE4
        addq.w       #$4, a0                                       ; $005CE6
        move.b       (a2)+, (a0)                                   ; $005CE8
        addq.w       #$4, a0                                       ; $005CEA
        move.b       (a2)+, (a0)                                   ; $005CEC
        addq.w       #$4, a0                                       ; $005CEE
        lea.l        -$20(a2), a2                                  ; $005CF0
        lea.l        $3a(a5), a5                                   ; $005CF4
        movea.l      $8(a7), a3                                    ; $005CF8
        jmp          (a3)                                          ; $005CFC

loc_005CFE:
        movea.l      $4(a7), a3                                    ; $005CFE
        jsr          (a3)                                          ; $005D02
        move.b       (a1)+, (a0)                                   ; $005D04
        addq.w       #$4, a0                                       ; $005D06
        move.b       (a1)+, (a0)                                   ; $005D08
        addq.w       #$4, a0                                       ; $005D0A
        move.b       (a1)+, (a0)                                   ; $005D0C
        addq.w       #$4, a0                                       ; $005D0E
        move.b       (a1)+, (a0)                                   ; $005D10
        addq.w       #$4, a0                                       ; $005D12
        move.b       (a1)+, (a0)                                   ; $005D14
        addq.w       #$4, a0                                       ; $005D16
        move.b       (a1)+, (a0)                                   ; $005D18
        addq.w       #$4, a0                                       ; $005D1A
        move.b       (a1), (a0)                                    ; $005D1C
        addq.w       #$2, a1                                       ; $005D1E
        addq.w       #$4, a0                                       ; $005D20
        move.b       (a1)+, (a0)                                   ; $005D22
        addq.w       #$4, a0                                       ; $005D24
        move.b       (a1)+, (a0)                                   ; $005D26
        addq.w       #$4, a0                                       ; $005D28
        move.b       (a1)+, (a0)                                   ; $005D2A
        addq.w       #$4, a0                                       ; $005D2C
        move.b       (a1)+, (a0)                                   ; $005D2E
        addq.w       #$4, a0                                       ; $005D30
        move.b       (a1)+, (a0)                                   ; $005D32
        addq.w       #$4, a0                                       ; $005D34
        move.b       (a1)+, (a0)                                   ; $005D36
        addq.w       #$4, a0                                       ; $005D38
        move.b       (a1)+, (a0)                                   ; $005D3A
        addq.w       #$4, a0                                       ; $005D3C
        move.b       (a1)+, (a0)                                   ; $005D3E
        addq.w       #$4, a0                                       ; $005D40
        move.b       (a1)+, (a0)                                   ; $005D42
        addq.w       #$4, a0                                       ; $005D44
        move.b       (a1)+, (a0)                                   ; $005D46
        addq.w       #$4, a0                                       ; $005D48
        move.b       (a1)+, (a0)                                   ; $005D4A
        addq.w       #$4, a0                                       ; $005D4C
        move.b       (a1)+, (a0)                                   ; $005D4E
        addq.w       #$4, a0                                       ; $005D50
        move.b       (a1)+, (a0)                                   ; $005D52
        addq.w       #$4, a0                                       ; $005D54
        move.b       (a1)+, (a0)                                   ; $005D56
        addq.w       #$4, a0                                       ; $005D58
        move.b       (a1), (a0)                                    ; $005D5A
        addq.w       #$2, a1                                       ; $005D5C
        addq.w       #$4, a0                                       ; $005D5E
        move.b       (a1)+, (a0)                                   ; $005D60
        addq.w       #$4, a0                                       ; $005D62
        move.b       (a1)+, (a0)                                   ; $005D64
        addq.w       #$4, a0                                       ; $005D66
        move.b       (a1)+, (a0)                                   ; $005D68
        addq.w       #$4, a0                                       ; $005D6A
        move.b       (a1)+, (a0)                                   ; $005D6C
        addq.w       #$4, a0                                       ; $005D6E
        move.b       (a1)+, (a0)                                   ; $005D70
        addq.w       #$4, a0                                       ; $005D72
        move.b       (a1)+, (a0)                                   ; $005D74
        addq.w       #$4, a0                                       ; $005D76
        move.b       (a1)+, (a0)                                   ; $005D78
        addq.w       #$4, a0                                       ; $005D7A
        move.b       (a1)+, (a0)                                   ; $005D7C
        addq.w       #$4, a0                                       ; $005D7E
        lea.l        -$20(a1), a1                                  ; $005D80
        move.b       (a2)+, (a0)                                   ; $005D84
        addq.w       #$4, a0                                       ; $005D86
        move.b       (a2)+, (a0)                                   ; $005D88
        addq.w       #$4, a0                                       ; $005D8A
        move.b       (a2)+, (a0)                                   ; $005D8C
        addq.w       #$4, a0                                       ; $005D8E
        move.b       (a2)+, (a0)                                   ; $005D90
        addq.w       #$4, a0                                       ; $005D92
        move.b       (a2)+, (a0)                                   ; $005D94
        addq.w       #$4, a0                                       ; $005D96
        move.b       (a2)+, (a0)                                   ; $005D98
        addq.w       #$4, a0                                       ; $005D9A
        move.b       (a2), (a0)                                    ; $005D9C
        addq.w       #$2, a2                                       ; $005D9E
        addq.w       #$4, a0                                       ; $005DA0
        move.b       (a2)+, (a0)                                   ; $005DA2
        addq.w       #$4, a0                                       ; $005DA4
        move.b       (a2)+, (a0)                                   ; $005DA6
        addq.w       #$4, a0                                       ; $005DA8
        move.b       (a2)+, (a0)                                   ; $005DAA
        addq.w       #$4, a0                                       ; $005DAC
        move.b       (a2)+, (a0)                                   ; $005DAE
        addq.w       #$4, a0                                       ; $005DB0
        move.b       (a2)+, (a0)                                   ; $005DB2
        addq.w       #$4, a0                                       ; $005DB4
        move.b       (a2)+, (a0)                                   ; $005DB6
        addq.w       #$4, a0                                       ; $005DB8
        move.b       (a2)+, (a0)                                   ; $005DBA
        addq.w       #$4, a0                                       ; $005DBC
        move.b       (a2)+, (a0)                                   ; $005DBE
        addq.w       #$4, a0                                       ; $005DC0
        move.b       (a2)+, (a0)                                   ; $005DC2
        addq.w       #$4, a0                                       ; $005DC4
        move.b       (a2)+, (a0)                                   ; $005DC6
        addq.w       #$4, a0                                       ; $005DC8
        move.b       (a2)+, (a0)                                   ; $005DCA
        addq.w       #$4, a0                                       ; $005DCC
        move.b       (a2)+, (a0)                                   ; $005DCE
        addq.w       #$4, a0                                       ; $005DD0
        move.b       (a2)+, (a0)                                   ; $005DD2
        addq.w       #$4, a0                                       ; $005DD4
        move.b       (a2)+, (a0)                                   ; $005DD6
        addq.w       #$4, a0                                       ; $005DD8
        move.b       (a2), (a0)                                    ; $005DDA
        addq.w       #$2, a2                                       ; $005DDC
        addq.w       #$4, a0                                       ; $005DDE
        move.b       (a2)+, (a0)                                   ; $005DE0
        addq.w       #$4, a0                                       ; $005DE2
        move.b       (a2)+, (a0)                                   ; $005DE4
        addq.w       #$4, a0                                       ; $005DE6
        move.b       (a2)+, (a0)                                   ; $005DE8
        addq.w       #$4, a0                                       ; $005DEA
        move.b       (a2)+, (a0)                                   ; $005DEC
        addq.w       #$4, a0                                       ; $005DEE
        move.b       (a2)+, (a0)                                   ; $005DF0
        addq.w       #$4, a0                                       ; $005DF2
        move.b       (a2)+, (a0)                                   ; $005DF4
        addq.w       #$4, a0                                       ; $005DF6
        move.b       (a2)+, (a0)                                   ; $005DF8
        addq.w       #$4, a0                                       ; $005DFA
        move.b       (a2)+, (a0)                                   ; $005DFC
        addq.w       #$4, a0                                       ; $005DFE
        lea.l        -$20(a2), a2                                  ; $005E00
        lea.l        $3c(a5), a5                                   ; $005E04
        movea.l      $8(a7), a3                                    ; $005E08
        jmp          (a3)                                          ; $005E0C

loc_005E0E:
        movea.l      $4(a7), a3                                    ; $005E0E
        jsr          (a3)                                          ; $005E12
        move.b       (a1)+, (a0)                                   ; $005E14
        addq.w       #$4, a0                                       ; $005E16
        move.b       (a1)+, (a0)                                   ; $005E18
        addq.w       #$4, a0                                       ; $005E1A
        move.b       (a1)+, (a0)                                   ; $005E1C
        addq.w       #$4, a0                                       ; $005E1E
        move.b       (a1)+, (a0)                                   ; $005E20
        addq.w       #$4, a0                                       ; $005E22
        move.b       (a1)+, (a0)                                   ; $005E24
        addq.w       #$4, a0                                       ; $005E26
        move.b       (a1)+, (a0)                                   ; $005E28
        addq.w       #$4, a0                                       ; $005E2A
        move.b       (a1)+, (a0)                                   ; $005E2C
        addq.w       #$4, a0                                       ; $005E2E
        move.b       (a1)+, (a0)                                   ; $005E30
        addq.w       #$4, a0                                       ; $005E32
        move.b       (a1)+, (a0)                                   ; $005E34
        addq.w       #$4, a0                                       ; $005E36
        move.b       (a1)+, (a0)                                   ; $005E38
        addq.w       #$4, a0                                       ; $005E3A
        move.b       (a1)+, (a0)                                   ; $005E3C
        addq.w       #$4, a0                                       ; $005E3E
        move.b       (a1)+, (a0)                                   ; $005E40
        addq.w       #$4, a0                                       ; $005E42
        move.b       (a1)+, (a0)                                   ; $005E44
        addq.w       #$4, a0                                       ; $005E46
        move.b       (a1)+, (a0)                                   ; $005E48
        addq.w       #$4, a0                                       ; $005E4A
        move.b       (a1), (a0)                                    ; $005E4C
        addq.w       #$2, a1                                       ; $005E4E
        addq.w       #$4, a0                                       ; $005E50
        move.b       (a1)+, (a0)                                   ; $005E52
        addq.w       #$4, a0                                       ; $005E54
        move.b       (a1)+, (a0)                                   ; $005E56
        addq.w       #$4, a0                                       ; $005E58
        move.b       (a1)+, (a0)                                   ; $005E5A
        addq.w       #$4, a0                                       ; $005E5C
        move.b       (a1)+, (a0)                                   ; $005E5E
        addq.w       #$4, a0                                       ; $005E60
        move.b       (a1)+, (a0)                                   ; $005E62
        addq.w       #$4, a0                                       ; $005E64
        move.b       (a1)+, (a0)                                   ; $005E66
        addq.w       #$4, a0                                       ; $005E68
        move.b       (a1)+, (a0)                                   ; $005E6A
        addq.w       #$4, a0                                       ; $005E6C
        move.b       (a1)+, (a0)                                   ; $005E6E
        addq.w       #$4, a0                                       ; $005E70
        move.b       (a1)+, (a0)                                   ; $005E72
        addq.w       #$4, a0                                       ; $005E74
        move.b       (a1)+, (a0)                                   ; $005E76
        addq.w       #$4, a0                                       ; $005E78
        move.b       (a1)+, (a0)                                   ; $005E7A
        addq.w       #$4, a0                                       ; $005E7C
        move.b       (a1)+, (a0)                                   ; $005E7E
        addq.w       #$4, a0                                       ; $005E80
        move.b       (a1)+, (a0)                                   ; $005E82
        addq.w       #$4, a0                                       ; $005E84
        move.b       (a1)+, (a0)                                   ; $005E86
        addq.w       #$4, a0                                       ; $005E88
        move.b       (a1)+, (a0)                                   ; $005E8A
        addq.w       #$4, a0                                       ; $005E8C
        move.b       (a1)+, (a0)                                   ; $005E8E
        addq.w       #$4, a0                                       ; $005E90
        lea.l        -$20(a1), a1                                  ; $005E92
        move.b       (a2)+, (a0)                                   ; $005E96
        addq.w       #$4, a0                                       ; $005E98
        move.b       (a2)+, (a0)                                   ; $005E9A
        addq.w       #$4, a0                                       ; $005E9C
        move.b       (a2)+, (a0)                                   ; $005E9E
        addq.w       #$4, a0                                       ; $005EA0
        move.b       (a2)+, (a0)                                   ; $005EA2
        addq.w       #$4, a0                                       ; $005EA4
        move.b       (a2)+, (a0)                                   ; $005EA6
        addq.w       #$4, a0                                       ; $005EA8
        move.b       (a2)+, (a0)                                   ; $005EAA
        addq.w       #$4, a0                                       ; $005EAC
        move.b       (a2)+, (a0)                                   ; $005EAE
        addq.w       #$4, a0                                       ; $005EB0
        move.b       (a2)+, (a0)                                   ; $005EB2
        addq.w       #$4, a0                                       ; $005EB4
        move.b       (a2)+, (a0)                                   ; $005EB6
        addq.w       #$4, a0                                       ; $005EB8
        move.b       (a2)+, (a0)                                   ; $005EBA
        addq.w       #$4, a0                                       ; $005EBC
        move.b       (a2)+, (a0)                                   ; $005EBE
        addq.w       #$4, a0                                       ; $005EC0
        move.b       (a2)+, (a0)                                   ; $005EC2
        addq.w       #$4, a0                                       ; $005EC4
        move.b       (a2)+, (a0)                                   ; $005EC6
        addq.w       #$4, a0                                       ; $005EC8
        move.b       (a2)+, (a0)                                   ; $005ECA
        addq.w       #$4, a0                                       ; $005ECC
        move.b       (a2), (a0)                                    ; $005ECE
        addq.w       #$2, a2                                       ; $005ED0
        addq.w       #$4, a0                                       ; $005ED2
        move.b       (a2)+, (a0)                                   ; $005ED4
        addq.w       #$4, a0                                       ; $005ED6
        move.b       (a2)+, (a0)                                   ; $005ED8
        addq.w       #$4, a0                                       ; $005EDA
        move.b       (a2)+, (a0)                                   ; $005EDC
        addq.w       #$4, a0                                       ; $005EDE
        move.b       (a2)+, (a0)                                   ; $005EE0
        addq.w       #$4, a0                                       ; $005EE2
        move.b       (a2)+, (a0)                                   ; $005EE4
        addq.w       #$4, a0                                       ; $005EE6
        move.b       (a2)+, (a0)                                   ; $005EE8
        addq.w       #$4, a0                                       ; $005EEA
        move.b       (a2)+, (a0)                                   ; $005EEC
        addq.w       #$4, a0                                       ; $005EEE
        move.b       (a2)+, (a0)                                   ; $005EF0
        addq.w       #$4, a0                                       ; $005EF2
        move.b       (a2)+, (a0)                                   ; $005EF4
        addq.w       #$4, a0                                       ; $005EF6
        move.b       (a2)+, (a0)                                   ; $005EF8
        addq.w       #$4, a0                                       ; $005EFA
        move.b       (a2)+, (a0)                                   ; $005EFC
        addq.w       #$4, a0                                       ; $005EFE
        move.b       (a2)+, (a0)                                   ; $005F00
        addq.w       #$4, a0                                       ; $005F02
        move.b       (a2)+, (a0)                                   ; $005F04
        addq.w       #$4, a0                                       ; $005F06
        move.b       (a2)+, (a0)                                   ; $005F08
        addq.w       #$4, a0                                       ; $005F0A
        move.b       (a2)+, (a0)                                   ; $005F0C
        addq.w       #$4, a0                                       ; $005F0E
        move.b       (a2)+, (a0)                                   ; $005F10
        addq.w       #$4, a0                                       ; $005F12
        lea.l        -$20(a2), a2                                  ; $005F14
        lea.l        $3e(a5), a5                                   ; $005F18
        movea.l      $8(a7), a3                                    ; $005F1C
        jmp          (a3)                                          ; $005F20

loc_005F22:
        movea.l      $4(a7), a3                                    ; $005F22
        jsr          (a3)                                          ; $005F26
        move.b       (a1)+, (a0)                                   ; $005F28
        addq.w       #$4, a0                                       ; $005F2A
        move.b       (a1)+, (a0)                                   ; $005F2C
        addq.w       #$4, a0                                       ; $005F2E
        move.b       (a1)+, (a0)                                   ; $005F30
        addq.w       #$4, a0                                       ; $005F32
        move.b       (a1)+, (a0)                                   ; $005F34
        addq.w       #$4, a0                                       ; $005F36
        move.b       (a1)+, (a0)                                   ; $005F38
        addq.w       #$4, a0                                       ; $005F3A
        move.b       (a1)+, (a0)                                   ; $005F3C
        addq.w       #$4, a0                                       ; $005F3E
        move.b       (a1)+, (a0)                                   ; $005F40
        addq.w       #$4, a0                                       ; $005F42
        move.b       (a1)+, (a0)                                   ; $005F44
        addq.w       #$4, a0                                       ; $005F46
        move.b       (a1)+, (a0)                                   ; $005F48
        addq.w       #$4, a0                                       ; $005F4A
        move.b       (a1)+, (a0)                                   ; $005F4C
        addq.w       #$4, a0                                       ; $005F4E
        move.b       (a1)+, (a0)                                   ; $005F50
        addq.w       #$4, a0                                       ; $005F52
        move.b       (a1)+, (a0)                                   ; $005F54
        addq.w       #$4, a0                                       ; $005F56
        move.b       (a1)+, (a0)                                   ; $005F58
        addq.w       #$4, a0                                       ; $005F5A
        move.b       (a1)+, (a0)                                   ; $005F5C
        addq.w       #$4, a0                                       ; $005F5E
        move.b       (a1)+, (a0)                                   ; $005F60
        addq.w       #$4, a0                                       ; $005F62
        move.b       (a1)+, (a0)                                   ; $005F64
        addq.w       #$4, a0                                       ; $005F66
        move.b       (a1)+, (a0)                                   ; $005F68
        addq.w       #$4, a0                                       ; $005F6A
        move.b       (a1)+, (a0)                                   ; $005F6C
        addq.w       #$4, a0                                       ; $005F6E
        move.b       (a1)+, (a0)                                   ; $005F70
        addq.w       #$4, a0                                       ; $005F72
        move.b       (a1)+, (a0)                                   ; $005F74
        addq.w       #$4, a0                                       ; $005F76
        move.b       (a1)+, (a0)                                   ; $005F78
        addq.w       #$4, a0                                       ; $005F7A
        move.b       (a1)+, (a0)                                   ; $005F7C
        addq.w       #$4, a0                                       ; $005F7E
        move.b       (a1)+, (a0)                                   ; $005F80
        addq.w       #$4, a0                                       ; $005F82
        move.b       (a1)+, (a0)                                   ; $005F84
        addq.w       #$4, a0                                       ; $005F86
        move.b       (a1)+, (a0)                                   ; $005F88
        addq.w       #$4, a0                                       ; $005F8A
        move.b       (a1)+, (a0)                                   ; $005F8C
        addq.w       #$4, a0                                       ; $005F8E
        move.b       (a1)+, (a0)                                   ; $005F90
        addq.w       #$4, a0                                       ; $005F92
        move.b       (a1)+, (a0)                                   ; $005F94
        addq.w       #$4, a0                                       ; $005F96
        move.b       (a1)+, (a0)                                   ; $005F98
        addq.w       #$4, a0                                       ; $005F9A
        move.b       (a1)+, (a0)                                   ; $005F9C
        addq.w       #$4, a0                                       ; $005F9E
        move.b       (a1)+, (a0)                                   ; $005FA0
        addq.w       #$4, a0                                       ; $005FA2
        move.b       (a1)+, (a0)                                   ; $005FA4
        addq.w       #$4, a0                                       ; $005FA6
        lea.l        -$20(a1), a1                                  ; $005FA8
        move.b       (a2)+, (a0)                                   ; $005FAC
        addq.w       #$4, a0                                       ; $005FAE
        move.b       (a2)+, (a0)                                   ; $005FB0
        addq.w       #$4, a0                                       ; $005FB2
        move.b       (a2)+, (a0)                                   ; $005FB4
        addq.w       #$4, a0                                       ; $005FB6
        move.b       (a2)+, (a0)                                   ; $005FB8
        addq.w       #$4, a0                                       ; $005FBA
        move.b       (a2)+, (a0)                                   ; $005FBC
        addq.w       #$4, a0                                       ; $005FBE
        move.b       (a2)+, (a0)                                   ; $005FC0
        addq.w       #$4, a0                                       ; $005FC2
        move.b       (a2)+, (a0)                                   ; $005FC4
        addq.w       #$4, a0                                       ; $005FC6
        move.b       (a2)+, (a0)                                   ; $005FC8
        addq.w       #$4, a0                                       ; $005FCA
        move.b       (a2)+, (a0)                                   ; $005FCC
        addq.w       #$4, a0                                       ; $005FCE
        move.b       (a2)+, (a0)                                   ; $005FD0
        addq.w       #$4, a0                                       ; $005FD2
        move.b       (a2)+, (a0)                                   ; $005FD4
        addq.w       #$4, a0                                       ; $005FD6
        move.b       (a2)+, (a0)                                   ; $005FD8
        addq.w       #$4, a0                                       ; $005FDA
        move.b       (a2)+, (a0)                                   ; $005FDC
        addq.w       #$4, a0                                       ; $005FDE
        move.b       (a2)+, (a0)                                   ; $005FE0
        addq.w       #$4, a0                                       ; $005FE2
        move.b       (a2)+, (a0)                                   ; $005FE4
        addq.w       #$4, a0                                       ; $005FE6
        move.b       (a2)+, (a0)                                   ; $005FE8
        addq.w       #$4, a0                                       ; $005FEA
        move.b       (a2)+, (a0)                                   ; $005FEC
        addq.w       #$4, a0                                       ; $005FEE
        move.b       (a2)+, (a0)                                   ; $005FF0
        addq.w       #$4, a0                                       ; $005FF2
        move.b       (a2)+, (a0)                                   ; $005FF4
        addq.w       #$4, a0                                       ; $005FF6
        move.b       (a2)+, (a0)                                   ; $005FF8
        addq.w       #$4, a0                                       ; $005FFA
        move.b       (a2)+, (a0)                                   ; $005FFC
        addq.w       #$4, a0                                       ; $005FFE
        move.b       (a2)+, (a0)                                   ; $006000
        addq.w       #$4, a0                                       ; $006002
        move.b       (a2)+, (a0)                                   ; $006004
        addq.w       #$4, a0                                       ; $006006
        move.b       (a2)+, (a0)                                   ; $006008
        addq.w       #$4, a0                                       ; $00600A
        move.b       (a2)+, (a0)                                   ; $00600C
        addq.w       #$4, a0                                       ; $00600E
        move.b       (a2)+, (a0)                                   ; $006010
        addq.w       #$4, a0                                       ; $006012
        move.b       (a2)+, (a0)                                   ; $006014
        addq.w       #$4, a0                                       ; $006016
        move.b       (a2)+, (a0)                                   ; $006018
        addq.w       #$4, a0                                       ; $00601A
        move.b       (a2)+, (a0)                                   ; $00601C
        addq.w       #$4, a0                                       ; $00601E
        move.b       (a2)+, (a0)                                   ; $006020
        addq.w       #$4, a0                                       ; $006022
        move.b       (a2)+, (a0)                                   ; $006024
        addq.w       #$4, a0                                       ; $006026
        move.b       (a2)+, (a0)                                   ; $006028
        addq.w       #$4, a0                                       ; $00602A
        lea.l        -$20(a2), a2                                  ; $00602C
        lea.l        $40(a5), a5                                   ; $006030
        movea.l      $8(a7), a3                                    ; $006034
        jmp          (a3)                                          ; $006038

loc_00603A:
        movea.l      $4(a7), a3                                    ; $00603A
        jsr          (a3)                                          ; $00603E
        move.b       (a1)+, (a0)                                   ; $006040
        addq.w       #$4, a0                                       ; $006042
        move.b       (a1)+, (a0)                                   ; $006044
        addq.w       #$4, a0                                       ; $006046
        move.b       (a1)+, (a0)                                   ; $006048
        addq.w       #$4, a0                                       ; $00604A
        move.b       (a1)+, (a0)                                   ; $00604C
        addq.w       #$4, a0                                       ; $00604E
        move.b       (a1)+, (a0)                                   ; $006050
        addq.w       #$4, a0                                       ; $006052
        move.b       (a1)+, (a0)                                   ; $006054
        addq.w       #$4, a0                                       ; $006056
        move.b       (a1)+, (a0)                                   ; $006058
        addq.w       #$4, a0                                       ; $00605A
        move.b       (a1)+, (a0)                                   ; $00605C
        addq.w       #$4, a0                                       ; $00605E
        move.b       (a1)+, (a0)                                   ; $006060
        addq.w       #$4, a0                                       ; $006062
        move.b       (a1)+, (a0)                                   ; $006064
        addq.w       #$4, a0                                       ; $006066
        move.b       (a1)+, (a0)                                   ; $006068
        addq.w       #$4, a0                                       ; $00606A
        move.b       (a1)+, (a0)                                   ; $00606C
        addq.w       #$4, a0                                       ; $00606E
        move.b       (a1)+, (a0)                                   ; $006070
        addq.w       #$4, a0                                       ; $006072
        move.b       (a1)+, (a0)                                   ; $006074
        addq.w       #$4, a0                                       ; $006076
        move.b       (a1)+, (a0)                                   ; $006078
        addq.w       #$4, a0                                       ; $00607A
        move.b       (a1)+, (a0)                                   ; $00607C
        addq.w       #$4, a0                                       ; $00607E
        move.b       (a1)+, d0                                     ; $006080
        move.b       d0, (a0)                                      ; $006082
        addq.w       #$4, a0                                       ; $006084
        move.b       d0, (a0)                                      ; $006086
        addq.w       #$4, a0                                       ; $006088
        move.b       (a1)+, (a0)                                   ; $00608A
        addq.w       #$4, a0                                       ; $00608C
        move.b       (a1)+, (a0)                                   ; $00608E
        addq.w       #$4, a0                                       ; $006090
        move.b       (a1)+, (a0)                                   ; $006092
        addq.w       #$4, a0                                       ; $006094
        move.b       (a1)+, (a0)                                   ; $006096
        addq.w       #$4, a0                                       ; $006098
        move.b       (a1)+, (a0)                                   ; $00609A
        addq.w       #$4, a0                                       ; $00609C
        move.b       (a1)+, (a0)                                   ; $00609E
        addq.w       #$4, a0                                       ; $0060A0
        move.b       (a1)+, (a0)                                   ; $0060A2
        addq.w       #$4, a0                                       ; $0060A4
        move.b       (a1)+, (a0)                                   ; $0060A6
        addq.w       #$4, a0                                       ; $0060A8
        move.b       (a1)+, (a0)                                   ; $0060AA
        addq.w       #$4, a0                                       ; $0060AC
        move.b       (a1)+, (a0)                                   ; $0060AE
        addq.w       #$4, a0                                       ; $0060B0
        move.b       (a1)+, (a0)                                   ; $0060B2
        addq.w       #$4, a0                                       ; $0060B4
        move.b       (a1)+, (a0)                                   ; $0060B6
        addq.w       #$4, a0                                       ; $0060B8
        move.b       (a1)+, (a0)                                   ; $0060BA
        addq.w       #$4, a0                                       ; $0060BC
        move.b       (a1)+, (a0)                                   ; $0060BE
        addq.w       #$4, a0                                       ; $0060C0
        move.b       (a1)+, (a0)                                   ; $0060C2
        addq.w       #$4, a0                                       ; $0060C4
        lea.l        -$20(a1), a1                                  ; $0060C6
        move.b       (a2)+, (a0)                                   ; $0060CA
        addq.w       #$4, a0                                       ; $0060CC
        move.b       (a2)+, (a0)                                   ; $0060CE
        addq.w       #$4, a0                                       ; $0060D0
        move.b       (a2)+, (a0)                                   ; $0060D2
        addq.w       #$4, a0                                       ; $0060D4
        move.b       (a2)+, (a0)                                   ; $0060D6
        addq.w       #$4, a0                                       ; $0060D8
        move.b       (a2)+, (a0)                                   ; $0060DA
        addq.w       #$4, a0                                       ; $0060DC
        move.b       (a2)+, (a0)                                   ; $0060DE
        addq.w       #$4, a0                                       ; $0060E0
        move.b       (a2)+, (a0)                                   ; $0060E2
        addq.w       #$4, a0                                       ; $0060E4
        move.b       (a2)+, (a0)                                   ; $0060E6
        addq.w       #$4, a0                                       ; $0060E8
        move.b       (a2)+, (a0)                                   ; $0060EA
        addq.w       #$4, a0                                       ; $0060EC
        move.b       (a2)+, (a0)                                   ; $0060EE
        addq.w       #$4, a0                                       ; $0060F0
        move.b       (a2)+, (a0)                                   ; $0060F2
        addq.w       #$4, a0                                       ; $0060F4
        move.b       (a2)+, (a0)                                   ; $0060F6
        addq.w       #$4, a0                                       ; $0060F8
        move.b       (a2)+, (a0)                                   ; $0060FA
        addq.w       #$4, a0                                       ; $0060FC
        move.b       (a2)+, (a0)                                   ; $0060FE
        addq.w       #$4, a0                                       ; $006100
        move.b       (a2)+, (a0)                                   ; $006102
        addq.w       #$4, a0                                       ; $006104
        move.b       (a2)+, (a0)                                   ; $006106
        addq.w       #$4, a0                                       ; $006108
        move.b       (a2)+, d0                                     ; $00610A
        move.b       d0, (a0)                                      ; $00610C
        addq.w       #$4, a0                                       ; $00610E
        move.b       d0, (a0)                                      ; $006110
        addq.w       #$4, a0                                       ; $006112
        move.b       (a2)+, (a0)                                   ; $006114
        addq.w       #$4, a0                                       ; $006116
        move.b       (a2)+, (a0)                                   ; $006118
        addq.w       #$4, a0                                       ; $00611A
        move.b       (a2)+, (a0)                                   ; $00611C
        addq.w       #$4, a0                                       ; $00611E
        move.b       (a2)+, (a0)                                   ; $006120
        addq.w       #$4, a0                                       ; $006122
        move.b       (a2)+, (a0)                                   ; $006124
        addq.w       #$4, a0                                       ; $006126
        move.b       (a2)+, (a0)                                   ; $006128
        addq.w       #$4, a0                                       ; $00612A
        move.b       (a2)+, (a0)                                   ; $00612C
        addq.w       #$4, a0                                       ; $00612E
        move.b       (a2)+, (a0)                                   ; $006130
        addq.w       #$4, a0                                       ; $006132
        move.b       (a2)+, (a0)                                   ; $006134
        addq.w       #$4, a0                                       ; $006136
        move.b       (a2)+, (a0)                                   ; $006138
        addq.w       #$4, a0                                       ; $00613A
        move.b       (a2)+, (a0)                                   ; $00613C
        addq.w       #$4, a0                                       ; $00613E
        move.b       (a2)+, (a0)                                   ; $006140
        addq.w       #$4, a0                                       ; $006142
        move.b       (a2)+, (a0)                                   ; $006144
        addq.w       #$4, a0                                       ; $006146
        move.b       (a2)+, (a0)                                   ; $006148
        addq.w       #$4, a0                                       ; $00614A
        move.b       (a2)+, (a0)                                   ; $00614C
        addq.w       #$4, a0                                       ; $00614E
        lea.l        -$20(a2), a2                                  ; $006150
        lea.l        $42(a5), a5                                   ; $006154
        movea.l      $8(a7), a3                                    ; $006158
        jmp          (a3)                                          ; $00615C

loc_00615E:
        movea.l      $4(a7), a3                                    ; $00615E
        jsr          (a3)                                          ; $006162
        move.b       (a1)+, (a0)                                   ; $006164
        addq.w       #$4, a0                                       ; $006166
        move.b       (a1)+, (a0)                                   ; $006168
        addq.w       #$4, a0                                       ; $00616A
        move.b       (a1)+, (a0)                                   ; $00616C
        addq.w       #$4, a0                                       ; $00616E
        move.b       (a1)+, (a0)                                   ; $006170
        addq.w       #$4, a0                                       ; $006172
        move.b       (a1)+, (a0)                                   ; $006174
        addq.w       #$4, a0                                       ; $006176
        move.b       (a1)+, (a0)                                   ; $006178
        addq.w       #$4, a0                                       ; $00617A
        move.b       (a1)+, (a0)                                   ; $00617C
        addq.w       #$4, a0                                       ; $00617E
        move.b       (a1)+, (a0)                                   ; $006180
        addq.w       #$4, a0                                       ; $006182
        move.b       (a1)+, d0                                     ; $006184
        move.b       d0, (a0)                                      ; $006186
        addq.w       #$4, a0                                       ; $006188
        move.b       d0, (a0)                                      ; $00618A
        addq.w       #$4, a0                                       ; $00618C
        move.b       (a1)+, (a0)                                   ; $00618E
        addq.w       #$4, a0                                       ; $006190
        move.b       (a1)+, (a0)                                   ; $006192
        addq.w       #$4, a0                                       ; $006194
        move.b       (a1)+, (a0)                                   ; $006196
        addq.w       #$4, a0                                       ; $006198
        move.b       (a1)+, (a0)                                   ; $00619A
        addq.w       #$4, a0                                       ; $00619C
        move.b       (a1)+, (a0)                                   ; $00619E
        addq.w       #$4, a0                                       ; $0061A0
        move.b       (a1)+, (a0)                                   ; $0061A2
        addq.w       #$4, a0                                       ; $0061A4
        move.b       (a1)+, (a0)                                   ; $0061A6
        addq.w       #$4, a0                                       ; $0061A8
        move.b       (a1)+, (a0)                                   ; $0061AA
        addq.w       #$4, a0                                       ; $0061AC
        move.b       (a1)+, (a0)                                   ; $0061AE
        addq.w       #$4, a0                                       ; $0061B0
        move.b       (a1)+, (a0)                                   ; $0061B2
        addq.w       #$4, a0                                       ; $0061B4
        move.b       (a1)+, (a0)                                   ; $0061B6
        addq.w       #$4, a0                                       ; $0061B8
        move.b       (a1)+, (a0)                                   ; $0061BA
        addq.w       #$4, a0                                       ; $0061BC
        move.b       (a1)+, (a0)                                   ; $0061BE
        addq.w       #$4, a0                                       ; $0061C0
        move.b       (a1)+, (a0)                                   ; $0061C2
        addq.w       #$4, a0                                       ; $0061C4
        move.b       (a1)+, (a0)                                   ; $0061C6
        addq.w       #$4, a0                                       ; $0061C8
        move.b       (a1)+, d0                                     ; $0061CA
        move.b       d0, (a0)                                      ; $0061CC
        addq.w       #$4, a0                                       ; $0061CE
        move.b       d0, (a0)                                      ; $0061D0
        addq.w       #$4, a0                                       ; $0061D2
        move.b       (a1)+, (a0)                                   ; $0061D4
        addq.w       #$4, a0                                       ; $0061D6
        move.b       (a1)+, (a0)                                   ; $0061D8
        addq.w       #$4, a0                                       ; $0061DA
        move.b       (a1)+, (a0)                                   ; $0061DC
        addq.w       #$4, a0                                       ; $0061DE
        move.b       (a1)+, (a0)                                   ; $0061E0
        addq.w       #$4, a0                                       ; $0061E2
        move.b       (a1)+, (a0)                                   ; $0061E4
        addq.w       #$4, a0                                       ; $0061E6
        move.b       (a1)+, (a0)                                   ; $0061E8
        addq.w       #$4, a0                                       ; $0061EA
        move.b       (a1)+, (a0)                                   ; $0061EC
        addq.w       #$4, a0                                       ; $0061EE
        lea.l        -$20(a1), a1                                  ; $0061F0
        move.b       (a2)+, (a0)                                   ; $0061F4
        addq.w       #$4, a0                                       ; $0061F6
        move.b       (a2)+, (a0)                                   ; $0061F8
        addq.w       #$4, a0                                       ; $0061FA
        move.b       (a2)+, (a0)                                   ; $0061FC
        addq.w       #$4, a0                                       ; $0061FE
        move.b       (a2)+, (a0)                                   ; $006200
        addq.w       #$4, a0                                       ; $006202
        move.b       (a2)+, (a0)                                   ; $006204
        addq.w       #$4, a0                                       ; $006206
        move.b       (a2)+, (a0)                                   ; $006208
        addq.w       #$4, a0                                       ; $00620A
        move.b       (a2)+, (a0)                                   ; $00620C
        addq.w       #$4, a0                                       ; $00620E
        move.b       (a2)+, (a0)                                   ; $006210
        addq.w       #$4, a0                                       ; $006212
        move.b       (a2)+, d0                                     ; $006214
        move.b       d0, (a0)                                      ; $006216
        addq.w       #$4, a0                                       ; $006218
        move.b       d0, (a0)                                      ; $00621A
        addq.w       #$4, a0                                       ; $00621C
        move.b       (a2)+, (a0)                                   ; $00621E
        addq.w       #$4, a0                                       ; $006220
        move.b       (a2)+, (a0)                                   ; $006222
        addq.w       #$4, a0                                       ; $006224
        move.b       (a2)+, (a0)                                   ; $006226
        addq.w       #$4, a0                                       ; $006228
        move.b       (a2)+, (a0)                                   ; $00622A
        addq.w       #$4, a0                                       ; $00622C
        move.b       (a2)+, (a0)                                   ; $00622E
        addq.w       #$4, a0                                       ; $006230
        move.b       (a2)+, (a0)                                   ; $006232
        addq.w       #$4, a0                                       ; $006234
        move.b       (a2)+, (a0)                                   ; $006236
        addq.w       #$4, a0                                       ; $006238
        move.b       (a2)+, (a0)                                   ; $00623A
        addq.w       #$4, a0                                       ; $00623C
        move.b       (a2)+, (a0)                                   ; $00623E
        addq.w       #$4, a0                                       ; $006240
        move.b       (a2)+, (a0)                                   ; $006242
        addq.w       #$4, a0                                       ; $006244
        move.b       (a2)+, (a0)                                   ; $006246
        addq.w       #$4, a0                                       ; $006248
        move.b       (a2)+, (a0)                                   ; $00624A
        addq.w       #$4, a0                                       ; $00624C
        move.b       (a2)+, (a0)                                   ; $00624E
        addq.w       #$4, a0                                       ; $006250
        move.b       (a2)+, (a0)                                   ; $006252
        addq.w       #$4, a0                                       ; $006254
        move.b       (a2)+, (a0)                                   ; $006256
        addq.w       #$4, a0                                       ; $006258
        move.b       (a2)+, d0                                     ; $00625A
        move.b       d0, (a0)                                      ; $00625C
        addq.w       #$4, a0                                       ; $00625E
        move.b       d0, (a0)                                      ; $006260
        addq.w       #$4, a0                                       ; $006262
        move.b       (a2)+, (a0)                                   ; $006264
        addq.w       #$4, a0                                       ; $006266
        move.b       (a2)+, (a0)                                   ; $006268
        addq.w       #$4, a0                                       ; $00626A
        move.b       (a2)+, (a0)                                   ; $00626C
        addq.w       #$4, a0                                       ; $00626E
        move.b       (a2)+, (a0)                                   ; $006270
        addq.w       #$4, a0                                       ; $006272
        move.b       (a2)+, (a0)                                   ; $006274
        addq.w       #$4, a0                                       ; $006276
        move.b       (a2)+, (a0)                                   ; $006278
        addq.w       #$4, a0                                       ; $00627A
        move.b       (a2)+, (a0)                                   ; $00627C
        addq.w       #$4, a0                                       ; $00627E
        lea.l        -$20(a2), a2                                  ; $006280
        lea.l        $44(a5), a5                                   ; $006284
        movea.l      $8(a7), a3                                    ; $006288
        jmp          (a3)                                          ; $00628C

loc_00628E:
        movea.l      $4(a7), a3                                    ; $00628E
        jsr          (a3)                                          ; $006292
        move.b       (a1)+, (a0)                                   ; $006294
        addq.w       #$4, a0                                       ; $006296
        move.b       (a1)+, (a0)                                   ; $006298
        addq.w       #$4, a0                                       ; $00629A
        move.b       (a1)+, (a0)                                   ; $00629C
        addq.w       #$4, a0                                       ; $00629E
        move.b       (a1)+, (a0)                                   ; $0062A0
        addq.w       #$4, a0                                       ; $0062A2
        move.b       (a1)+, (a0)                                   ; $0062A4
        addq.w       #$4, a0                                       ; $0062A6
        move.b       (a1)+, d0                                     ; $0062A8
        move.b       d0, (a0)                                      ; $0062AA
        addq.w       #$4, a0                                       ; $0062AC
        move.b       d0, (a0)                                      ; $0062AE
        addq.w       #$4, a0                                       ; $0062B0
        move.b       (a1)+, (a0)                                   ; $0062B2
        addq.w       #$4, a0                                       ; $0062B4
        move.b       (a1)+, (a0)                                   ; $0062B6
        addq.w       #$4, a0                                       ; $0062B8
        move.b       (a1)+, (a0)                                   ; $0062BA
        addq.w       #$4, a0                                       ; $0062BC
        move.b       (a1)+, (a0)                                   ; $0062BE
        addq.w       #$4, a0                                       ; $0062C0
        move.b       (a1)+, (a0)                                   ; $0062C2
        addq.w       #$4, a0                                       ; $0062C4
        move.b       (a1)+, (a0)                                   ; $0062C6
        addq.w       #$4, a0                                       ; $0062C8
        move.b       (a1)+, (a0)                                   ; $0062CA
        addq.w       #$4, a0                                       ; $0062CC
        move.b       (a1)+, (a0)                                   ; $0062CE
        addq.w       #$4, a0                                       ; $0062D0
        move.b       (a1)+, (a0)                                   ; $0062D2
        addq.w       #$4, a0                                       ; $0062D4
        move.b       (a1)+, (a0)                                   ; $0062D6
        addq.w       #$4, a0                                       ; $0062D8
        move.b       (a1)+, d0                                     ; $0062DA
        move.b       d0, (a0)                                      ; $0062DC
        addq.w       #$4, a0                                       ; $0062DE
        move.b       d0, (a0)                                      ; $0062E0
        addq.w       #$4, a0                                       ; $0062E2
        move.b       (a1)+, (a0)                                   ; $0062E4
        addq.w       #$4, a0                                       ; $0062E6
        move.b       (a1)+, (a0)                                   ; $0062E8
        addq.w       #$4, a0                                       ; $0062EA
        move.b       (a1)+, (a0)                                   ; $0062EC
        addq.w       #$4, a0                                       ; $0062EE
        move.b       (a1)+, (a0)                                   ; $0062F0
        addq.w       #$4, a0                                       ; $0062F2
        move.b       (a1)+, (a0)                                   ; $0062F4
        addq.w       #$4, a0                                       ; $0062F6
        move.b       (a1)+, (a0)                                   ; $0062F8
        addq.w       #$4, a0                                       ; $0062FA
        move.b       (a1)+, (a0)                                   ; $0062FC
        addq.w       #$4, a0                                       ; $0062FE
        move.b       (a1)+, (a0)                                   ; $006300
        addq.w       #$4, a0                                       ; $006302
        move.b       (a1)+, (a0)                                   ; $006304
        addq.w       #$4, a0                                       ; $006306
        move.b       (a1)+, d0                                     ; $006308
        move.b       d0, (a0)                                      ; $00630A
        addq.w       #$4, a0                                       ; $00630C
        move.b       d0, (a0)                                      ; $00630E
        addq.w       #$4, a0                                       ; $006310
        move.b       (a1)+, (a0)                                   ; $006312
        addq.w       #$4, a0                                       ; $006314
        move.b       (a1)+, (a0)                                   ; $006316
        addq.w       #$4, a0                                       ; $006318
        move.b       (a1)+, (a0)                                   ; $00631A
        addq.w       #$4, a0                                       ; $00631C
        move.b       (a1)+, (a0)                                   ; $00631E
        addq.w       #$4, a0                                       ; $006320
        move.b       (a1)+, (a0)                                   ; $006322
        addq.w       #$4, a0                                       ; $006324
        lea.l        -$20(a1), a1                                  ; $006326
        move.b       (a2)+, (a0)                                   ; $00632A
        addq.w       #$4, a0                                       ; $00632C
        move.b       (a2)+, (a0)                                   ; $00632E
        addq.w       #$4, a0                                       ; $006330
        move.b       (a2)+, (a0)                                   ; $006332
        addq.w       #$4, a0                                       ; $006334
        move.b       (a2)+, (a0)                                   ; $006336
        addq.w       #$4, a0                                       ; $006338
        move.b       (a2)+, (a0)                                   ; $00633A
        addq.w       #$4, a0                                       ; $00633C
        move.b       (a2)+, d0                                     ; $00633E
        move.b       d0, (a0)                                      ; $006340
        addq.w       #$4, a0                                       ; $006342
        move.b       d0, (a0)                                      ; $006344
        addq.w       #$4, a0                                       ; $006346
        move.b       (a2)+, (a0)                                   ; $006348
        addq.w       #$4, a0                                       ; $00634A
        move.b       (a2)+, (a0)                                   ; $00634C
        addq.w       #$4, a0                                       ; $00634E
        move.b       (a2)+, (a0)                                   ; $006350
        addq.w       #$4, a0                                       ; $006352
        move.b       (a2)+, (a0)                                   ; $006354
        addq.w       #$4, a0                                       ; $006356
        move.b       (a2)+, (a0)                                   ; $006358
        addq.w       #$4, a0                                       ; $00635A
        move.b       (a2)+, (a0)                                   ; $00635C
        addq.w       #$4, a0                                       ; $00635E
        move.b       (a2)+, (a0)                                   ; $006360
        addq.w       #$4, a0                                       ; $006362
        move.b       (a2)+, (a0)                                   ; $006364
        addq.w       #$4, a0                                       ; $006366
        move.b       (a2)+, (a0)                                   ; $006368
        addq.w       #$4, a0                                       ; $00636A
        move.b       (a2)+, (a0)                                   ; $00636C
        addq.w       #$4, a0                                       ; $00636E
        move.b       (a2)+, d0                                     ; $006370
        move.b       d0, (a0)                                      ; $006372
        addq.w       #$4, a0                                       ; $006374
        move.b       d0, (a0)                                      ; $006376
        addq.w       #$4, a0                                       ; $006378
        move.b       (a2)+, (a0)                                   ; $00637A
        addq.w       #$4, a0                                       ; $00637C
        move.b       (a2)+, (a0)                                   ; $00637E
        addq.w       #$4, a0                                       ; $006380
        move.b       (a2)+, (a0)                                   ; $006382
        addq.w       #$4, a0                                       ; $006384
        move.b       (a2)+, (a0)                                   ; $006386
        addq.w       #$4, a0                                       ; $006388
        move.b       (a2)+, (a0)                                   ; $00638A
        addq.w       #$4, a0                                       ; $00638C
        move.b       (a2)+, (a0)                                   ; $00638E
        addq.w       #$4, a0                                       ; $006390
        move.b       (a2)+, (a0)                                   ; $006392
        addq.w       #$4, a0                                       ; $006394
        move.b       (a2)+, (a0)                                   ; $006396
        addq.w       #$4, a0                                       ; $006398
        move.b       (a2)+, (a0)                                   ; $00639A
        addq.w       #$4, a0                                       ; $00639C
        move.b       (a2)+, d0                                     ; $00639E
        move.b       d0, (a0)                                      ; $0063A0
        addq.w       #$4, a0                                       ; $0063A2
        move.b       d0, (a0)                                      ; $0063A4
        addq.w       #$4, a0                                       ; $0063A6
        move.b       (a2)+, (a0)                                   ; $0063A8
        addq.w       #$4, a0                                       ; $0063AA
        move.b       (a2)+, (a0)                                   ; $0063AC
        addq.w       #$4, a0                                       ; $0063AE
        move.b       (a2)+, (a0)                                   ; $0063B0
        addq.w       #$4, a0                                       ; $0063B2
        move.b       (a2)+, (a0)                                   ; $0063B4
        addq.w       #$4, a0                                       ; $0063B6
        move.b       (a2)+, (a0)                                   ; $0063B8
        addq.w       #$4, a0                                       ; $0063BA
        lea.l        -$20(a2), a2                                  ; $0063BC
        lea.l        $46(a5), a5                                   ; $0063C0
        movea.l      $8(a7), a3                                    ; $0063C4
        jmp          (a3)                                          ; $0063C8

loc_0063CA:
        movea.l      $4(a7), a3                                    ; $0063CA
        jsr          (a3)                                          ; $0063CE
        move.b       (a1)+, (a0)                                   ; $0063D0
        addq.w       #$4, a0                                       ; $0063D2
        move.b       (a1)+, (a0)                                   ; $0063D4
        addq.w       #$4, a0                                       ; $0063D6
        move.b       (a1)+, (a0)                                   ; $0063D8
        addq.w       #$4, a0                                       ; $0063DA
        move.b       (a1)+, (a0)                                   ; $0063DC
        addq.w       #$4, a0                                       ; $0063DE
        move.b       (a1)+, d0                                     ; $0063E0
        move.b       d0, (a0)                                      ; $0063E2
        addq.w       #$4, a0                                       ; $0063E4
        move.b       d0, (a0)                                      ; $0063E6
        addq.w       #$4, a0                                       ; $0063E8
        move.b       (a1)+, (a0)                                   ; $0063EA
        addq.w       #$4, a0                                       ; $0063EC
        move.b       (a1)+, (a0)                                   ; $0063EE
        addq.w       #$4, a0                                       ; $0063F0
        move.b       (a1)+, (a0)                                   ; $0063F2
        addq.w       #$4, a0                                       ; $0063F4
        move.b       (a1)+, (a0)                                   ; $0063F6
        addq.w       #$4, a0                                       ; $0063F8
        move.b       (a1)+, (a0)                                   ; $0063FA
        addq.w       #$4, a0                                       ; $0063FC
        move.b       (a1)+, (a0)                                   ; $0063FE
        addq.w       #$4, a0                                       ; $006400
        move.b       (a1)+, (a0)                                   ; $006402
        addq.w       #$4, a0                                       ; $006404
        move.b       (a1)+, d0                                     ; $006406
        move.b       d0, (a0)                                      ; $006408
        addq.w       #$4, a0                                       ; $00640A
        move.b       d0, (a0)                                      ; $00640C
        addq.w       #$4, a0                                       ; $00640E
        move.b       (a1)+, (a0)                                   ; $006410
        addq.w       #$4, a0                                       ; $006412
        move.b       (a1)+, (a0)                                   ; $006414
        addq.w       #$4, a0                                       ; $006416
        move.b       (a1)+, (a0)                                   ; $006418
        addq.w       #$4, a0                                       ; $00641A
        move.b       (a1)+, (a0)                                   ; $00641C
        addq.w       #$4, a0                                       ; $00641E
        move.b       (a1)+, (a0)                                   ; $006420
        addq.w       #$4, a0                                       ; $006422
        move.b       (a1)+, (a0)                                   ; $006424
        addq.w       #$4, a0                                       ; $006426
        move.b       (a1)+, (a0)                                   ; $006428
        addq.w       #$4, a0                                       ; $00642A
        move.b       (a1)+, d0                                     ; $00642C
        move.b       d0, (a0)                                      ; $00642E
        addq.w       #$4, a0                                       ; $006430
        move.b       d0, (a0)                                      ; $006432
        addq.w       #$4, a0                                       ; $006434
        move.b       (a1)+, (a0)                                   ; $006436
        addq.w       #$4, a0                                       ; $006438
        move.b       (a1)+, (a0)                                   ; $00643A
        addq.w       #$4, a0                                       ; $00643C
        move.b       (a1)+, (a0)                                   ; $00643E
        addq.w       #$4, a0                                       ; $006440
        move.b       (a1)+, (a0)                                   ; $006442
        addq.w       #$4, a0                                       ; $006444
        move.b       (a1)+, (a0)                                   ; $006446
        addq.w       #$4, a0                                       ; $006448
        move.b       (a1)+, (a0)                                   ; $00644A
        addq.w       #$4, a0                                       ; $00644C
        move.b       (a1)+, (a0)                                   ; $00644E
        addq.w       #$4, a0                                       ; $006450
        move.b       (a1)+, d0                                     ; $006452
        move.b       d0, (a0)                                      ; $006454
        addq.w       #$4, a0                                       ; $006456
        move.b       d0, (a0)                                      ; $006458
        addq.w       #$4, a0                                       ; $00645A
        move.b       (a1)+, (a0)                                   ; $00645C
        addq.w       #$4, a0                                       ; $00645E
        move.b       (a1)+, (a0)                                   ; $006460
        addq.w       #$4, a0                                       ; $006462
        move.b       (a1)+, (a0)                                   ; $006464
        addq.w       #$4, a0                                       ; $006466
        lea.l        -$20(a1), a1                                  ; $006468
        move.b       (a2)+, (a0)                                   ; $00646C
        addq.w       #$4, a0                                       ; $00646E
        move.b       (a2)+, (a0)                                   ; $006470
        addq.w       #$4, a0                                       ; $006472
        move.b       (a2)+, (a0)                                   ; $006474
        addq.w       #$4, a0                                       ; $006476
        move.b       (a2)+, (a0)                                   ; $006478
        addq.w       #$4, a0                                       ; $00647A
        move.b       (a2)+, d0                                     ; $00647C
        move.b       d0, (a0)                                      ; $00647E
        addq.w       #$4, a0                                       ; $006480
        move.b       d0, (a0)                                      ; $006482
        addq.w       #$4, a0                                       ; $006484
        move.b       (a2)+, (a0)                                   ; $006486
        addq.w       #$4, a0                                       ; $006488
        move.b       (a2)+, (a0)                                   ; $00648A
        addq.w       #$4, a0                                       ; $00648C
        move.b       (a2)+, (a0)                                   ; $00648E
        addq.w       #$4, a0                                       ; $006490
        move.b       (a2)+, (a0)                                   ; $006492
        addq.w       #$4, a0                                       ; $006494
        move.b       (a2)+, (a0)                                   ; $006496
        addq.w       #$4, a0                                       ; $006498
        move.b       (a2)+, (a0)                                   ; $00649A
        addq.w       #$4, a0                                       ; $00649C
        move.b       (a2)+, (a0)                                   ; $00649E
        addq.w       #$4, a0                                       ; $0064A0
        move.b       (a2)+, d0                                     ; $0064A2
        move.b       d0, (a0)                                      ; $0064A4
        addq.w       #$4, a0                                       ; $0064A6
        move.b       d0, (a0)                                      ; $0064A8
        addq.w       #$4, a0                                       ; $0064AA
        move.b       (a2)+, (a0)                                   ; $0064AC
        addq.w       #$4, a0                                       ; $0064AE
        move.b       (a2)+, (a0)                                   ; $0064B0
        addq.w       #$4, a0                                       ; $0064B2
        move.b       (a2)+, (a0)                                   ; $0064B4
        addq.w       #$4, a0                                       ; $0064B6
        move.b       (a2)+, (a0)                                   ; $0064B8
        addq.w       #$4, a0                                       ; $0064BA
        move.b       (a2)+, (a0)                                   ; $0064BC
        addq.w       #$4, a0                                       ; $0064BE
        move.b       (a2)+, (a0)                                   ; $0064C0
        addq.w       #$4, a0                                       ; $0064C2
        move.b       (a2)+, (a0)                                   ; $0064C4
        addq.w       #$4, a0                                       ; $0064C6
        move.b       (a2)+, d0                                     ; $0064C8
        move.b       d0, (a0)                                      ; $0064CA
        addq.w       #$4, a0                                       ; $0064CC
        move.b       d0, (a0)                                      ; $0064CE
        addq.w       #$4, a0                                       ; $0064D0
        move.b       (a2)+, (a0)                                   ; $0064D2
        addq.w       #$4, a0                                       ; $0064D4
        move.b       (a2)+, (a0)                                   ; $0064D6
        addq.w       #$4, a0                                       ; $0064D8
        move.b       (a2)+, (a0)                                   ; $0064DA
        addq.w       #$4, a0                                       ; $0064DC
        move.b       (a2)+, (a0)                                   ; $0064DE
        addq.w       #$4, a0                                       ; $0064E0
        move.b       (a2)+, (a0)                                   ; $0064E2
        addq.w       #$4, a0                                       ; $0064E4
        move.b       (a2)+, (a0)                                   ; $0064E6
        addq.w       #$4, a0                                       ; $0064E8
        move.b       (a2)+, (a0)                                   ; $0064EA
        addq.w       #$4, a0                                       ; $0064EC
        move.b       (a2)+, d0                                     ; $0064EE
        move.b       d0, (a0)                                      ; $0064F0
        addq.w       #$4, a0                                       ; $0064F2
        move.b       d0, (a0)                                      ; $0064F4
        addq.w       #$4, a0                                       ; $0064F6
        move.b       (a2)+, (a0)                                   ; $0064F8
        addq.w       #$4, a0                                       ; $0064FA
        move.b       (a2)+, (a0)                                   ; $0064FC
        addq.w       #$4, a0                                       ; $0064FE
        move.b       (a2)+, (a0)                                   ; $006500
        addq.w       #$4, a0                                       ; $006502
        lea.l        -$20(a2), a2                                  ; $006504
        lea.l        $48(a5), a5                                   ; $006508
        movea.l      $8(a7), a3                                    ; $00650C
        jmp          (a3)                                          ; $006510

loc_006512:
        movea.l      $4(a7), a3                                    ; $006512
        jsr          (a3)                                          ; $006516
        move.b       (a1)+, (a0)                                   ; $006518
        addq.w       #$4, a0                                       ; $00651A
        move.b       (a1)+, (a0)                                   ; $00651C
        addq.w       #$4, a0                                       ; $00651E
        move.b       (a1)+, (a0)                                   ; $006520
        addq.w       #$4, a0                                       ; $006522
        move.b       (a1)+, d0                                     ; $006524
        move.b       d0, (a0)                                      ; $006526
        addq.w       #$4, a0                                       ; $006528
        move.b       d0, (a0)                                      ; $00652A
        addq.w       #$4, a0                                       ; $00652C
        move.b       (a1)+, (a0)                                   ; $00652E
        addq.w       #$4, a0                                       ; $006530
        move.b       (a1)+, (a0)                                   ; $006532
        addq.w       #$4, a0                                       ; $006534
        move.b       (a1)+, (a0)                                   ; $006536
        addq.w       #$4, a0                                       ; $006538
        move.b       (a1)+, (a0)                                   ; $00653A
        addq.w       #$4, a0                                       ; $00653C
        move.b       (a1)+, (a0)                                   ; $00653E
        addq.w       #$4, a0                                       ; $006540
        move.b       (a1)+, d0                                     ; $006542
        move.b       d0, (a0)                                      ; $006544
        addq.w       #$4, a0                                       ; $006546
        move.b       d0, (a0)                                      ; $006548
        addq.w       #$4, a0                                       ; $00654A
        move.b       (a1)+, (a0)                                   ; $00654C
        addq.w       #$4, a0                                       ; $00654E
        move.b       (a1)+, (a0)                                   ; $006550
        addq.w       #$4, a0                                       ; $006552
        move.b       (a1)+, (a0)                                   ; $006554
        addq.w       #$4, a0                                       ; $006556
        move.b       (a1)+, (a0)                                   ; $006558
        addq.w       #$4, a0                                       ; $00655A
        move.b       (a1)+, (a0)                                   ; $00655C
        addq.w       #$4, a0                                       ; $00655E
        move.b       (a1)+, (a0)                                   ; $006560
        addq.w       #$4, a0                                       ; $006562
        move.b       (a1)+, d0                                     ; $006564
        move.b       d0, (a0)                                      ; $006566
        addq.w       #$4, a0                                       ; $006568
        move.b       d0, (a0)                                      ; $00656A
        addq.w       #$4, a0                                       ; $00656C
        move.b       (a1)+, (a0)                                   ; $00656E
        addq.w       #$4, a0                                       ; $006570
        move.b       (a1)+, (a0)                                   ; $006572
        addq.w       #$4, a0                                       ; $006574
        move.b       (a1)+, (a0)                                   ; $006576
        addq.w       #$4, a0                                       ; $006578
        move.b       (a1)+, (a0)                                   ; $00657A
        addq.w       #$4, a0                                       ; $00657C
        move.b       (a1)+, (a0)                                   ; $00657E
        addq.w       #$4, a0                                       ; $006580
        move.b       (a1)+, d0                                     ; $006582
        move.b       d0, (a0)                                      ; $006584
        addq.w       #$4, a0                                       ; $006586
        move.b       d0, (a0)                                      ; $006588
        addq.w       #$4, a0                                       ; $00658A
        move.b       (a1)+, (a0)                                   ; $00658C
        addq.w       #$4, a0                                       ; $00658E
        move.b       (a1)+, (a0)                                   ; $006590
        addq.w       #$4, a0                                       ; $006592
        move.b       (a1)+, (a0)                                   ; $006594
        addq.w       #$4, a0                                       ; $006596
        move.b       (a1)+, (a0)                                   ; $006598
        addq.w       #$4, a0                                       ; $00659A
        move.b       (a1)+, (a0)                                   ; $00659C
        addq.w       #$4, a0                                       ; $00659E
        move.b       (a1)+, d0                                     ; $0065A0
        move.b       d0, (a0)                                      ; $0065A2
        addq.w       #$4, a0                                       ; $0065A4
        move.b       d0, (a0)                                      ; $0065A6
        addq.w       #$4, a0                                       ; $0065A8
        move.b       (a1)+, (a0)                                   ; $0065AA
        addq.w       #$4, a0                                       ; $0065AC
        move.b       (a1)+, (a0)                                   ; $0065AE
        addq.w       #$4, a0                                       ; $0065B0
        move.b       (a1)+, (a0)                                   ; $0065B2
        addq.w       #$4, a0                                       ; $0065B4
        lea.l        -$20(a1), a1                                  ; $0065B6
        move.b       (a2)+, (a0)                                   ; $0065BA
        addq.w       #$4, a0                                       ; $0065BC
        move.b       (a2)+, (a0)                                   ; $0065BE
        addq.w       #$4, a0                                       ; $0065C0
        move.b       (a2)+, (a0)                                   ; $0065C2
        addq.w       #$4, a0                                       ; $0065C4
        move.b       (a2)+, d0                                     ; $0065C6
        move.b       d0, (a0)                                      ; $0065C8
        addq.w       #$4, a0                                       ; $0065CA
        move.b       d0, (a0)                                      ; $0065CC
        addq.w       #$4, a0                                       ; $0065CE
        move.b       (a2)+, (a0)                                   ; $0065D0
        addq.w       #$4, a0                                       ; $0065D2
        move.b       (a2)+, (a0)                                   ; $0065D4
        addq.w       #$4, a0                                       ; $0065D6
        move.b       (a2)+, (a0)                                   ; $0065D8
        addq.w       #$4, a0                                       ; $0065DA
        move.b       (a2)+, (a0)                                   ; $0065DC
        addq.w       #$4, a0                                       ; $0065DE
        move.b       (a2)+, (a0)                                   ; $0065E0
        addq.w       #$4, a0                                       ; $0065E2
        move.b       (a2)+, d0                                     ; $0065E4
        move.b       d0, (a0)                                      ; $0065E6
        addq.w       #$4, a0                                       ; $0065E8
        move.b       d0, (a0)                                      ; $0065EA
        addq.w       #$4, a0                                       ; $0065EC
        move.b       (a2)+, (a0)                                   ; $0065EE
        addq.w       #$4, a0                                       ; $0065F0
        move.b       (a2)+, (a0)                                   ; $0065F2
        addq.w       #$4, a0                                       ; $0065F4
        move.b       (a2)+, (a0)                                   ; $0065F6
        addq.w       #$4, a0                                       ; $0065F8
        move.b       (a2)+, (a0)                                   ; $0065FA
        addq.w       #$4, a0                                       ; $0065FC
        move.b       (a2)+, (a0)                                   ; $0065FE
        addq.w       #$4, a0                                       ; $006600
        move.b       (a2)+, (a0)                                   ; $006602
        addq.w       #$4, a0                                       ; $006604
        move.b       (a2)+, d0                                     ; $006606
        move.b       d0, (a0)                                      ; $006608
        addq.w       #$4, a0                                       ; $00660A
        move.b       d0, (a0)                                      ; $00660C
        addq.w       #$4, a0                                       ; $00660E
        move.b       (a2)+, (a0)                                   ; $006610
        addq.w       #$4, a0                                       ; $006612
        move.b       (a2)+, (a0)                                   ; $006614
        addq.w       #$4, a0                                       ; $006616
        move.b       (a2)+, (a0)                                   ; $006618
        addq.w       #$4, a0                                       ; $00661A
        move.b       (a2)+, (a0)                                   ; $00661C
        addq.w       #$4, a0                                       ; $00661E
        move.b       (a2)+, (a0)                                   ; $006620
        addq.w       #$4, a0                                       ; $006622
        move.b       (a2)+, d0                                     ; $006624
        move.b       d0, (a0)                                      ; $006626
        addq.w       #$4, a0                                       ; $006628
        move.b       d0, (a0)                                      ; $00662A
        addq.w       #$4, a0                                       ; $00662C
        move.b       (a2)+, (a0)                                   ; $00662E
        addq.w       #$4, a0                                       ; $006630
        move.b       (a2)+, (a0)                                   ; $006632
        addq.w       #$4, a0                                       ; $006634
        move.b       (a2)+, (a0)                                   ; $006636
        addq.w       #$4, a0                                       ; $006638
        move.b       (a2)+, (a0)                                   ; $00663A
        addq.w       #$4, a0                                       ; $00663C
        move.b       (a2)+, (a0)                                   ; $00663E
        addq.w       #$4, a0                                       ; $006640
        move.b       (a2)+, d0                                     ; $006642
        move.b       d0, (a0)                                      ; $006644
        addq.w       #$4, a0                                       ; $006646
        move.b       d0, (a0)                                      ; $006648
        addq.w       #$4, a0                                       ; $00664A
        move.b       (a2)+, (a0)                                   ; $00664C
        addq.w       #$4, a0                                       ; $00664E
        move.b       (a2)+, (a0)                                   ; $006650
        addq.w       #$4, a0                                       ; $006652
        move.b       (a2)+, (a0)                                   ; $006654
        addq.w       #$4, a0                                       ; $006656
        lea.l        -$20(a2), a2                                  ; $006658
        lea.l        $4a(a5), a5                                   ; $00665C
        movea.l      $8(a7), a3                                    ; $006660
        jmp          (a3)                                          ; $006664

loc_006666:
        move.b       (a5)+, (a0)                                   ; $006666
        addq.w       #$4, a0                                       ; $006668
        move.b       (a5)+, (a0)                                   ; $00666A
        addq.w       #$4, a0                                       ; $00666C
        move.b       (a1)+, (a0)                                   ; $00666E
        addq.w       #$4, a0                                       ; $006670
        move.b       (a1)+, (a0)                                   ; $006672
        addq.w       #$4, a0                                       ; $006674
        move.b       (a1)+, d0                                     ; $006676
        move.b       d0, (a0)                                      ; $006678
        addq.w       #$4, a0                                       ; $00667A
        move.b       d0, (a0)                                      ; $00667C
        addq.w       #$4, a0                                       ; $00667E
        move.b       (a1)+, (a0)                                   ; $006680
        addq.w       #$4, a0                                       ; $006682
        move.b       (a1)+, (a0)                                   ; $006684
        addq.w       #$4, a0                                       ; $006686
        move.b       (a1)+, (a0)                                   ; $006688
        addq.w       #$4, a0                                       ; $00668A
        move.b       (a1)+, (a0)                                   ; $00668C
        addq.w       #$4, a0                                       ; $00668E
        move.b       (a1)+, (a0)                                   ; $006690
        addq.w       #$4, a0                                       ; $006692
        move.b       (a1)+, d0                                     ; $006694
        move.b       d0, (a0)                                      ; $006696
        addq.w       #$4, a0                                       ; $006698
        move.b       d0, (a0)                                      ; $00669A
        addq.w       #$4, a0                                       ; $00669C
        move.b       (a1)+, (a0)                                   ; $00669E
        addq.w       #$4, a0                                       ; $0066A0
        move.b       (a1)+, (a0)                                   ; $0066A2
        addq.w       #$4, a0                                       ; $0066A4
        move.b       (a1)+, (a0)                                   ; $0066A6
        addq.w       #$4, a0                                       ; $0066A8
        move.b       (a1)+, (a0)                                   ; $0066AA
        addq.w       #$4, a0                                       ; $0066AC
        move.b       (a1)+, d0                                     ; $0066AE
        move.b       d0, (a0)                                      ; $0066B0
        addq.w       #$4, a0                                       ; $0066B2
        move.b       d0, (a0)                                      ; $0066B4
        addq.w       #$4, a0                                       ; $0066B6
        move.b       (a1)+, (a0)                                   ; $0066B8
        addq.w       #$4, a0                                       ; $0066BA
        move.b       (a1)+, (a0)                                   ; $0066BC
        addq.w       #$4, a0                                       ; $0066BE
        move.b       (a1)+, (a0)                                   ; $0066C0
        addq.w       #$4, a0                                       ; $0066C2
        move.b       (a1)+, (a0)                                   ; $0066C4
        addq.w       #$4, a0                                       ; $0066C6
        move.b       (a1)+, d0                                     ; $0066C8
        move.b       d0, (a0)                                      ; $0066CA
        addq.w       #$4, a0                                       ; $0066CC
        move.b       d0, (a0)                                      ; $0066CE
        addq.w       #$4, a0                                       ; $0066D0
        move.b       (a1)+, (a0)                                   ; $0066D2
        addq.w       #$4, a0                                       ; $0066D4
        move.b       (a1)+, (a0)                                   ; $0066D6
        addq.w       #$4, a0                                       ; $0066D8
        move.b       (a1)+, (a0)                                   ; $0066DA
        addq.w       #$4, a0                                       ; $0066DC
        move.b       (a1)+, (a0)                                   ; $0066DE
        addq.w       #$4, a0                                       ; $0066E0
        move.b       (a1)+, (a0)                                   ; $0066E2
        addq.w       #$4, a0                                       ; $0066E4
        move.b       (a1)+, d0                                     ; $0066E6
        move.b       d0, (a0)                                      ; $0066E8
        addq.w       #$4, a0                                       ; $0066EA
        move.b       d0, (a0)                                      ; $0066EC
        addq.w       #$4, a0                                       ; $0066EE
        move.b       (a1)+, (a0)                                   ; $0066F0
        addq.w       #$4, a0                                       ; $0066F2
        move.b       (a1)+, (a0)                                   ; $0066F4
        addq.w       #$4, a0                                       ; $0066F6
        move.b       (a1)+, (a0)                                   ; $0066F8
        addq.w       #$4, a0                                       ; $0066FA
        move.b       (a1)+, (a0)                                   ; $0066FC
        addq.w       #$4, a0                                       ; $0066FE
        move.b       (a1)+, d0                                     ; $006700
        move.b       d0, (a0)                                      ; $006702
        addq.w       #$4, a0                                       ; $006704
        move.b       d0, (a0)                                      ; $006706
        addq.w       #$4, a0                                       ; $006708
        move.b       (a1)+, (a0)                                   ; $00670A
        addq.w       #$4, a0                                       ; $00670C
        move.b       (a1)+, (a0)                                   ; $00670E
        addq.w       #$4, a0                                       ; $006710
        lea.l        -$20(a1), a1                                  ; $006712
        move.b       (a2)+, (a0)                                   ; $006716
        addq.w       #$4, a0                                       ; $006718
        move.b       (a2)+, (a0)                                   ; $00671A
        addq.w       #$4, a0                                       ; $00671C
        move.b       (a2)+, d0                                     ; $00671E
        move.b       d0, (a0)                                      ; $006720
        addq.w       #$4, a0                                       ; $006722
        move.b       d0, (a0)                                      ; $006724
        addq.w       #$4, a0                                       ; $006726
        move.b       (a2)+, (a0)                                   ; $006728
        addq.w       #$4, a0                                       ; $00672A
        move.b       (a2)+, (a0)                                   ; $00672C
        addq.w       #$4, a0                                       ; $00672E
        move.b       (a2)+, (a0)                                   ; $006730
        addq.w       #$4, a0                                       ; $006732
        move.b       (a2)+, (a0)                                   ; $006734
        addq.w       #$4, a0                                       ; $006736
        move.b       (a2)+, (a0)                                   ; $006738
        addq.w       #$4, a0                                       ; $00673A
        move.b       (a2)+, d0                                     ; $00673C
        move.b       d0, (a0)                                      ; $00673E
        addq.w       #$4, a0                                       ; $006740
        move.b       d0, (a0)                                      ; $006742
        addq.w       #$4, a0                                       ; $006744
        move.b       (a2)+, (a0)                                   ; $006746
        addq.w       #$4, a0                                       ; $006748
        move.b       (a2)+, (a0)                                   ; $00674A
        addq.w       #$4, a0                                       ; $00674C
        move.b       (a2)+, (a0)                                   ; $00674E
        addq.w       #$4, a0                                       ; $006750
        move.b       (a2)+, (a0)                                   ; $006752
        addq.w       #$4, a0                                       ; $006754
        move.b       (a2)+, d0                                     ; $006756
        move.b       d0, (a0)                                      ; $006758
        addq.w       #$4, a0                                       ; $00675A
        move.b       d0, (a0)                                      ; $00675C
        addq.w       #$4, a0                                       ; $00675E
        move.b       (a2)+, (a0)                                   ; $006760
        addq.w       #$4, a0                                       ; $006762
        move.b       (a2)+, (a0)                                   ; $006764
        addq.w       #$4, a0                                       ; $006766
        move.b       (a2)+, (a0)                                   ; $006768
        addq.w       #$4, a0                                       ; $00676A
        move.b       (a2)+, (a0)                                   ; $00676C
        addq.w       #$4, a0                                       ; $00676E
        move.b       (a2)+, d0                                     ; $006770
        move.b       d0, (a0)                                      ; $006772
        addq.w       #$4, a0                                       ; $006774
        move.b       d0, (a0)                                      ; $006776
        addq.w       #$4, a0                                       ; $006778
        move.b       (a2)+, (a0)                                   ; $00677A
        addq.w       #$4, a0                                       ; $00677C
        move.b       (a2)+, (a0)                                   ; $00677E
        addq.w       #$4, a0                                       ; $006780
        move.b       (a2)+, (a0)                                   ; $006782
        addq.w       #$4, a0                                       ; $006784
        move.b       (a2)+, (a0)                                   ; $006786
        addq.w       #$4, a0                                       ; $006788
        move.b       (a2)+, (a0)                                   ; $00678A
        addq.w       #$4, a0                                       ; $00678C
        move.b       (a2)+, d0                                     ; $00678E
        move.b       d0, (a0)                                      ; $006790
        addq.w       #$4, a0                                       ; $006792
        move.b       d0, (a0)                                      ; $006794
        addq.w       #$4, a0                                       ; $006796
        move.b       (a2)+, (a0)                                   ; $006798
        addq.w       #$4, a0                                       ; $00679A
        move.b       (a2)+, (a0)                                   ; $00679C
        addq.w       #$4, a0                                       ; $00679E
        move.b       (a2)+, (a0)                                   ; $0067A0
        addq.w       #$4, a0                                       ; $0067A2
        move.b       (a2)+, (a0)                                   ; $0067A4
        addq.w       #$4, a0                                       ; $0067A6
        move.b       (a2)+, d0                                     ; $0067A8
        move.b       d0, (a0)                                      ; $0067AA
        addq.w       #$4, a0                                       ; $0067AC
        move.b       d0, (a0)                                      ; $0067AE
        addq.w       #$4, a0                                       ; $0067B0
        move.b       (a2)+, (a0)                                   ; $0067B2
        addq.w       #$4, a0                                       ; $0067B4
        move.b       (a2)+, (a0)                                   ; $0067B6
        addq.w       #$4, a0                                       ; $0067B8
        lea.l        -$20(a2), a2                                  ; $0067BA
        lea.l        $4c(a5), a5                                   ; $0067BE
        move.b       (a5)+, (a0)                                   ; $0067C2
        addq.w       #$4, a0                                       ; $0067C4
        move.b       (a5)+, (a0)                                   ; $0067C6
        addq.w       #$4, a0                                       ; $0067C8
        rts                                                        ; $0067CA

loc_0067CC:
        move.b       (a5)+, (a0)                                   ; $0067CC
        addq.w       #$4, a0                                       ; $0067CE
        move.b       (a1)+, (a0)                                   ; $0067D0
        addq.w       #$4, a0                                       ; $0067D2
        move.b       (a1)+, (a0)                                   ; $0067D4
        addq.w       #$4, a0                                       ; $0067D6
        move.b       (a1)+, d0                                     ; $0067D8
        move.b       d0, (a0)                                      ; $0067DA
        addq.w       #$4, a0                                       ; $0067DC
        move.b       d0, (a0)                                      ; $0067DE
        addq.w       #$4, a0                                       ; $0067E0
        move.b       (a1)+, (a0)                                   ; $0067E2
        addq.w       #$4, a0                                       ; $0067E4
        move.b       (a1)+, (a0)                                   ; $0067E6
        addq.w       #$4, a0                                       ; $0067E8
        move.b       (a1)+, (a0)                                   ; $0067EA
        addq.w       #$4, a0                                       ; $0067EC
        move.b       (a1)+, d0                                     ; $0067EE
        move.b       d0, (a0)                                      ; $0067F0
        addq.w       #$4, a0                                       ; $0067F2
        move.b       d0, (a0)                                      ; $0067F4
        addq.w       #$4, a0                                       ; $0067F6
        move.b       (a1)+, (a0)                                   ; $0067F8
        addq.w       #$4, a0                                       ; $0067FA
        move.b       (a1)+, (a0)                                   ; $0067FC
        addq.w       #$4, a0                                       ; $0067FE
        move.b       (a1)+, (a0)                                   ; $006800
        addq.w       #$4, a0                                       ; $006802
        move.b       (a1)+, (a0)                                   ; $006804
        addq.w       #$4, a0                                       ; $006806
        move.b       (a1)+, d0                                     ; $006808
        move.b       d0, (a0)                                      ; $00680A
        addq.w       #$4, a0                                       ; $00680C
        move.b       d0, (a0)                                      ; $00680E
        addq.w       #$4, a0                                       ; $006810
        move.b       (a1)+, (a0)                                   ; $006812
        addq.w       #$4, a0                                       ; $006814
        move.b       (a1)+, (a0)                                   ; $006816
        addq.w       #$4, a0                                       ; $006818
        move.b       (a1)+, (a0)                                   ; $00681A
        addq.w       #$4, a0                                       ; $00681C
        move.b       (a1)+, (a0)                                   ; $00681E
        addq.w       #$4, a0                                       ; $006820
        move.b       (a1)+, d0                                     ; $006822
        move.b       d0, (a0)                                      ; $006824
        addq.w       #$4, a0                                       ; $006826
        move.b       d0, (a0)                                      ; $006828
        addq.w       #$4, a0                                       ; $00682A
        move.b       (a1)+, (a0)                                   ; $00682C
        addq.w       #$4, a0                                       ; $00682E
        move.b       (a1)+, (a0)                                   ; $006830
        addq.w       #$4, a0                                       ; $006832
        move.b       (a1)+, (a0)                                   ; $006834
        addq.w       #$4, a0                                       ; $006836
        move.b       (a1)+, d0                                     ; $006838
        move.b       d0, (a0)                                      ; $00683A
        addq.w       #$4, a0                                       ; $00683C
        move.b       d0, (a0)                                      ; $00683E
        addq.w       #$4, a0                                       ; $006840
        move.b       (a1)+, (a0)                                   ; $006842
        addq.w       #$4, a0                                       ; $006844
        move.b       (a1)+, (a0)                                   ; $006846
        addq.w       #$4, a0                                       ; $006848
        move.b       (a1)+, (a0)                                   ; $00684A
        addq.w       #$4, a0                                       ; $00684C
        move.b       (a1)+, (a0)                                   ; $00684E
        addq.w       #$4, a0                                       ; $006850
        move.b       (a1)+, d0                                     ; $006852
        move.b       d0, (a0)                                      ; $006854
        addq.w       #$4, a0                                       ; $006856
        move.b       d0, (a0)                                      ; $006858
        addq.w       #$4, a0                                       ; $00685A
        move.b       (a1)+, (a0)                                   ; $00685C
        addq.w       #$4, a0                                       ; $00685E
        move.b       (a1)+, (a0)                                   ; $006860
        addq.w       #$4, a0                                       ; $006862
        move.b       (a1)+, (a0)                                   ; $006864
        addq.w       #$4, a0                                       ; $006866
        move.b       (a1)+, d0                                     ; $006868
        move.b       d0, (a0)                                      ; $00686A
        addq.w       #$4, a0                                       ; $00686C
        move.b       d0, (a0)                                      ; $00686E
        addq.w       #$4, a0                                       ; $006870
        move.b       (a1)+, (a0)                                   ; $006872
        addq.w       #$4, a0                                       ; $006874
        move.b       (a1)+, (a0)                                   ; $006876
        addq.w       #$4, a0                                       ; $006878
        lea.l        -$20(a1), a1                                  ; $00687A
        move.b       (a2)+, (a0)                                   ; $00687E
        addq.w       #$4, a0                                       ; $006880
        move.b       (a2)+, (a0)                                   ; $006882
        addq.w       #$4, a0                                       ; $006884
        move.b       (a2)+, d0                                     ; $006886
        move.b       d0, (a0)                                      ; $006888
        addq.w       #$4, a0                                       ; $00688A
        move.b       d0, (a0)                                      ; $00688C
        addq.w       #$4, a0                                       ; $00688E
        move.b       (a2)+, (a0)                                   ; $006890
        addq.w       #$4, a0                                       ; $006892
        move.b       (a2)+, (a0)                                   ; $006894
        addq.w       #$4, a0                                       ; $006896
        move.b       (a2)+, (a0)                                   ; $006898
        addq.w       #$4, a0                                       ; $00689A
        move.b       (a2)+, d0                                     ; $00689C
        move.b       d0, (a0)                                      ; $00689E
        addq.w       #$4, a0                                       ; $0068A0
        move.b       d0, (a0)                                      ; $0068A2
        addq.w       #$4, a0                                       ; $0068A4
        move.b       (a2)+, (a0)                                   ; $0068A6
        addq.w       #$4, a0                                       ; $0068A8
        move.b       (a2)+, (a0)                                   ; $0068AA
        addq.w       #$4, a0                                       ; $0068AC
        move.b       (a2)+, (a0)                                   ; $0068AE
        addq.w       #$4, a0                                       ; $0068B0
        move.b       (a2)+, (a0)                                   ; $0068B2
        addq.w       #$4, a0                                       ; $0068B4
        move.b       (a2)+, d0                                     ; $0068B6
        move.b       d0, (a0)                                      ; $0068B8
        addq.w       #$4, a0                                       ; $0068BA
        move.b       d0, (a0)                                      ; $0068BC
        addq.w       #$4, a0                                       ; $0068BE
        move.b       (a2)+, (a0)                                   ; $0068C0
        addq.w       #$4, a0                                       ; $0068C2
        move.b       (a2)+, (a0)                                   ; $0068C4
        addq.w       #$4, a0                                       ; $0068C6
        move.b       (a2)+, (a0)                                   ; $0068C8
        addq.w       #$4, a0                                       ; $0068CA
        move.b       (a2)+, (a0)                                   ; $0068CC
        addq.w       #$4, a0                                       ; $0068CE
        move.b       (a2)+, d0                                     ; $0068D0
        move.b       d0, (a0)                                      ; $0068D2
        addq.w       #$4, a0                                       ; $0068D4
        move.b       d0, (a0)                                      ; $0068D6
        addq.w       #$4, a0                                       ; $0068D8
        move.b       (a2)+, (a0)                                   ; $0068DA
        addq.w       #$4, a0                                       ; $0068DC
        move.b       (a2)+, (a0)                                   ; $0068DE
        addq.w       #$4, a0                                       ; $0068E0
        move.b       (a2)+, (a0)                                   ; $0068E2
        addq.w       #$4, a0                                       ; $0068E4
        move.b       (a2)+, d0                                     ; $0068E6
        move.b       d0, (a0)                                      ; $0068E8
        addq.w       #$4, a0                                       ; $0068EA
        move.b       d0, (a0)                                      ; $0068EC
        addq.w       #$4, a0                                       ; $0068EE
        move.b       (a2)+, (a0)                                   ; $0068F0
        addq.w       #$4, a0                                       ; $0068F2
        move.b       (a2)+, (a0)                                   ; $0068F4
        addq.w       #$4, a0                                       ; $0068F6
        move.b       (a2)+, (a0)                                   ; $0068F8
        addq.w       #$4, a0                                       ; $0068FA
        move.b       (a2)+, (a0)                                   ; $0068FC
        addq.w       #$4, a0                                       ; $0068FE
        move.b       (a2)+, d0                                     ; $006900
        move.b       d0, (a0)                                      ; $006902
        addq.w       #$4, a0                                       ; $006904
        move.b       d0, (a0)                                      ; $006906
        addq.w       #$4, a0                                       ; $006908
        move.b       (a2)+, (a0)                                   ; $00690A
        addq.w       #$4, a0                                       ; $00690C
        move.b       (a2)+, (a0)                                   ; $00690E
        addq.w       #$4, a0                                       ; $006910
        move.b       (a2)+, (a0)                                   ; $006912
        addq.w       #$4, a0                                       ; $006914
        move.b       (a2)+, d0                                     ; $006916
        move.b       d0, (a0)                                      ; $006918
        addq.w       #$4, a0                                       ; $00691A
        move.b       d0, (a0)                                      ; $00691C
        addq.w       #$4, a0                                       ; $00691E
        move.b       (a2)+, (a0)                                   ; $006920
        addq.w       #$4, a0                                       ; $006922
        move.b       (a2)+, (a0)                                   ; $006924
        addq.w       #$4, a0                                       ; $006926
        lea.l        -$20(a2), a2                                  ; $006928
        lea.l        $4e(a5), a5                                   ; $00692C
        move.b       (a5)+, (a0)                                   ; $006930
        addq.w       #$4, a0                                       ; $006932
        rts                                                        ; $006934

loc_006936:
        move.b       (a1)+, (a0)                                   ; $006936
        addq.w       #$4, a0                                       ; $006938
        move.b       (a1)+, (a0)                                   ; $00693A
        addq.w       #$4, a0                                       ; $00693C
        move.b       (a1)+, d0                                     ; $00693E
        move.b       d0, (a0)                                      ; $006940
        addq.w       #$4, a0                                       ; $006942
        move.b       d0, (a0)                                      ; $006944
        addq.w       #$4, a0                                       ; $006946
        move.b       (a1)+, (a0)                                   ; $006948
        addq.w       #$4, a0                                       ; $00694A
        move.b       (a1)+, (a0)                                   ; $00694C
        addq.w       #$4, a0                                       ; $00694E
        move.b       (a1)+, (a0)                                   ; $006950
        addq.w       #$4, a0                                       ; $006952
        move.b       (a1)+, d0                                     ; $006954
        move.b       d0, (a0)                                      ; $006956
        addq.w       #$4, a0                                       ; $006958
        move.b       d0, (a0)                                      ; $00695A
        addq.w       #$4, a0                                       ; $00695C
        move.b       (a1)+, (a0)                                   ; $00695E
        addq.w       #$4, a0                                       ; $006960
        move.b       (a1)+, (a0)                                   ; $006962
        addq.w       #$4, a0                                       ; $006964
        move.b       (a1)+, (a0)                                   ; $006966
        addq.w       #$4, a0                                       ; $006968
        move.b       (a1)+, d0                                     ; $00696A
        move.b       d0, (a0)                                      ; $00696C
        addq.w       #$4, a0                                       ; $00696E
        move.b       d0, (a0)                                      ; $006970
        addq.w       #$4, a0                                       ; $006972
        move.b       (a1)+, (a0)                                   ; $006974
        addq.w       #$4, a0                                       ; $006976
        move.b       (a1)+, (a0)                                   ; $006978
        addq.w       #$4, a0                                       ; $00697A
        move.b       (a1)+, (a0)                                   ; $00697C
        addq.w       #$4, a0                                       ; $00697E
        move.b       (a1)+, d0                                     ; $006980
        move.b       d0, (a0)                                      ; $006982
        addq.w       #$4, a0                                       ; $006984
        move.b       d0, (a0)                                      ; $006986
        addq.w       #$4, a0                                       ; $006988
        move.b       (a1)+, (a0)                                   ; $00698A
        addq.w       #$4, a0                                       ; $00698C
        move.b       (a1)+, (a0)                                   ; $00698E
        addq.w       #$4, a0                                       ; $006990
        move.b       (a1)+, (a0)                                   ; $006992
        addq.w       #$4, a0                                       ; $006994
        move.b       (a1)+, d0                                     ; $006996
        move.b       d0, (a0)                                      ; $006998
        addq.w       #$4, a0                                       ; $00699A
        move.b       d0, (a0)                                      ; $00699C
        addq.w       #$4, a0                                       ; $00699E
        move.b       (a1)+, (a0)                                   ; $0069A0
        addq.w       #$4, a0                                       ; $0069A2
        move.b       (a1)+, (a0)                                   ; $0069A4
        addq.w       #$4, a0                                       ; $0069A6
        move.b       (a1)+, (a0)                                   ; $0069A8
        addq.w       #$4, a0                                       ; $0069AA
        move.b       (a1)+, d0                                     ; $0069AC
        move.b       d0, (a0)                                      ; $0069AE
        addq.w       #$4, a0                                       ; $0069B0
        move.b       d0, (a0)                                      ; $0069B2
        addq.w       #$4, a0                                       ; $0069B4
        move.b       (a1)+, (a0)                                   ; $0069B6
        addq.w       #$4, a0                                       ; $0069B8
        move.b       (a1)+, (a0)                                   ; $0069BA
        addq.w       #$4, a0                                       ; $0069BC
        move.b       (a1)+, (a0)                                   ; $0069BE
        addq.w       #$4, a0                                       ; $0069C0
        move.b       (a1)+, d0                                     ; $0069C2
        move.b       d0, (a0)                                      ; $0069C4
        addq.w       #$4, a0                                       ; $0069C6
        move.b       d0, (a0)                                      ; $0069C8
        addq.w       #$4, a0                                       ; $0069CA
        move.b       (a1)+, (a0)                                   ; $0069CC
        addq.w       #$4, a0                                       ; $0069CE
        move.b       (a1)+, (a0)                                   ; $0069D0
        addq.w       #$4, a0                                       ; $0069D2
        move.b       (a1)+, (a0)                                   ; $0069D4
        addq.w       #$4, a0                                       ; $0069D6
        move.b       (a1)+, d0                                     ; $0069D8
        move.b       d0, (a0)                                      ; $0069DA
        addq.w       #$4, a0                                       ; $0069DC
        move.b       d0, (a0)                                      ; $0069DE
        addq.w       #$4, a0                                       ; $0069E0
        move.b       (a1)+, (a0)                                   ; $0069E2
        addq.w       #$4, a0                                       ; $0069E4
        lea.l        -$20(a1), a1                                  ; $0069E6
        move.b       (a2)+, (a0)                                   ; $0069EA
        addq.w       #$4, a0                                       ; $0069EC
        move.b       (a2)+, (a0)                                   ; $0069EE
        addq.w       #$4, a0                                       ; $0069F0
        move.b       (a2)+, d0                                     ; $0069F2
        move.b       d0, (a0)                                      ; $0069F4
        addq.w       #$4, a0                                       ; $0069F6
        move.b       d0, (a0)                                      ; $0069F8
        addq.w       #$4, a0                                       ; $0069FA
        move.b       (a2)+, (a0)                                   ; $0069FC
        addq.w       #$4, a0                                       ; $0069FE
        move.b       (a2)+, (a0)                                   ; $006A00
        addq.w       #$4, a0                                       ; $006A02
        move.b       (a2)+, (a0)                                   ; $006A04
        addq.w       #$4, a0                                       ; $006A06
        move.b       (a2)+, d0                                     ; $006A08
        move.b       d0, (a0)                                      ; $006A0A
        addq.w       #$4, a0                                       ; $006A0C
        move.b       d0, (a0)                                      ; $006A0E
        addq.w       #$4, a0                                       ; $006A10
        move.b       (a2)+, (a0)                                   ; $006A12
        addq.w       #$4, a0                                       ; $006A14
        move.b       (a2)+, (a0)                                   ; $006A16
        addq.w       #$4, a0                                       ; $006A18
        move.b       (a2)+, (a0)                                   ; $006A1A
        addq.w       #$4, a0                                       ; $006A1C
        move.b       (a2)+, d0                                     ; $006A1E
        move.b       d0, (a0)                                      ; $006A20
        addq.w       #$4, a0                                       ; $006A22
        move.b       d0, (a0)                                      ; $006A24
        addq.w       #$4, a0                                       ; $006A26
        move.b       (a2)+, (a0)                                   ; $006A28
        addq.w       #$4, a0                                       ; $006A2A
        move.b       (a2)+, (a0)                                   ; $006A2C
        addq.w       #$4, a0                                       ; $006A2E
        move.b       (a2)+, (a0)                                   ; $006A30
        addq.w       #$4, a0                                       ; $006A32
        move.b       (a2)+, d0                                     ; $006A34
        move.b       d0, (a0)                                      ; $006A36
        addq.w       #$4, a0                                       ; $006A38
        move.b       d0, (a0)                                      ; $006A3A
        addq.w       #$4, a0                                       ; $006A3C
        move.b       (a2)+, (a0)                                   ; $006A3E
        addq.w       #$4, a0                                       ; $006A40
        move.b       (a2)+, (a0)                                   ; $006A42
        addq.w       #$4, a0                                       ; $006A44
        move.b       (a2)+, (a0)                                   ; $006A46
        addq.w       #$4, a0                                       ; $006A48
        move.b       (a2)+, d0                                     ; $006A4A
        move.b       d0, (a0)                                      ; $006A4C
        addq.w       #$4, a0                                       ; $006A4E
        move.b       d0, (a0)                                      ; $006A50
        addq.w       #$4, a0                                       ; $006A52
        move.b       (a2)+, (a0)                                   ; $006A54
        addq.w       #$4, a0                                       ; $006A56
        move.b       (a2)+, (a0)                                   ; $006A58
        addq.w       #$4, a0                                       ; $006A5A
        move.b       (a2)+, (a0)                                   ; $006A5C
        addq.w       #$4, a0                                       ; $006A5E
        move.b       (a2)+, d0                                     ; $006A60
        move.b       d0, (a0)                                      ; $006A62
        addq.w       #$4, a0                                       ; $006A64
        move.b       d0, (a0)                                      ; $006A66
        addq.w       #$4, a0                                       ; $006A68
        move.b       (a2)+, (a0)                                   ; $006A6A
        addq.w       #$4, a0                                       ; $006A6C
        move.b       (a2)+, (a0)                                   ; $006A6E
        addq.w       #$4, a0                                       ; $006A70
        move.b       (a2)+, (a0)                                   ; $006A72
        addq.w       #$4, a0                                       ; $006A74
        move.b       (a2)+, d0                                     ; $006A76
        move.b       d0, (a0)                                      ; $006A78
        addq.w       #$4, a0                                       ; $006A7A
        move.b       d0, (a0)                                      ; $006A7C
        addq.w       #$4, a0                                       ; $006A7E
        move.b       (a2)+, (a0)                                   ; $006A80
        addq.w       #$4, a0                                       ; $006A82
        move.b       (a2)+, (a0)                                   ; $006A84
        addq.w       #$4, a0                                       ; $006A86
        move.b       (a2)+, (a0)                                   ; $006A88
        addq.w       #$4, a0                                       ; $006A8A
        move.b       (a2)+, d0                                     ; $006A8C
        move.b       d0, (a0)                                      ; $006A8E
        addq.w       #$4, a0                                       ; $006A90
        move.b       d0, (a0)                                      ; $006A92
        addq.w       #$4, a0                                       ; $006A94
        move.b       (a2)+, (a0)                                   ; $006A96
        addq.w       #$4, a0                                       ; $006A98
        lea.l        -$20(a2), a2                                  ; $006A9A
        lea.l        $50(a5), a5                                   ; $006A9E
        rts                                                        ; $006AA2

loc_006AA4:
        movea.l      $4(a7), a3                                    ; $006AA4
        jsr          (a3)                                          ; $006AA8
        move.b       $10(a1), (a0)                                 ; $006AAA
        addq.w       #$4, a0                                       ; $006AAE
        move.b       $10(a2), (a0)                                 ; $006AB0
        addq.w       #$4, a0                                       ; $006AB4
        lea.l        $2(a5), a5                                    ; $006AB6
        movea.l      $8(a7), a3                                    ; $006ABA
        jmp          (a3)                                          ; $006ABE

loc_006AC0:
        movea.l      $4(a7), a3                                    ; $006AC0
        jsr          (a3)                                          ; $006AC4
        move.b       $8(a1), (a0)                                  ; $006AC6
        addq.w       #$4, a0                                       ; $006ACA
        move.b       $18(a1), (a0)                                 ; $006ACC
        addq.w       #$4, a0                                       ; $006AD0
        move.b       $8(a2), (a0)                                  ; $006AD2
        addq.w       #$4, a0                                       ; $006AD6
        move.b       $18(a2), (a0)                                 ; $006AD8
        addq.w       #$4, a0                                       ; $006ADC
        lea.l        $4(a5), a5                                    ; $006ADE
        movea.l      $8(a7), a3                                    ; $006AE2
        jmp          (a3)                                          ; $006AE6

loc_006AE8:
        movea.l      $4(a7), a3                                    ; $006AE8
        jsr          (a3)                                          ; $006AEC
        move.b       $5(a1), (a0)                                  ; $006AEE
        addq.w       #$4, a0                                       ; $006AF2
        move.b       $10(a1), (a0)                                 ; $006AF4
        addq.w       #$4, a0                                       ; $006AF8
        move.b       $1a(a1), (a0)                                 ; $006AFA
        addq.w       #$4, a0                                       ; $006AFE
        move.b       $5(a2), (a0)                                  ; $006B00
        addq.w       #$4, a0                                       ; $006B04
        move.b       $10(a2), (a0)                                 ; $006B06
        addq.w       #$4, a0                                       ; $006B0A
        move.b       $1a(a2), (a0)                                 ; $006B0C
        addq.w       #$4, a0                                       ; $006B10
        lea.l        $6(a5), a5                                    ; $006B12
        movea.l      $8(a7), a3                                    ; $006B16
        jmp          (a3)                                          ; $006B1A

loc_006B1C:
        movea.l      $4(a7), a3                                    ; $006B1C
        jsr          (a3)                                          ; $006B20
        move.b       $4(a1), (a0)                                  ; $006B22
        addq.w       #$4, a0                                       ; $006B26
        move.b       $c(a1), (a0)                                  ; $006B28
        addq.w       #$4, a0                                       ; $006B2C
        move.b       $14(a1), (a0)                                 ; $006B2E
        addq.w       #$4, a0                                       ; $006B32
        move.b       $1c(a1), (a0)                                 ; $006B34
        addq.w       #$4, a0                                       ; $006B38
        move.b       $4(a2), (a0)                                  ; $006B3A
        addq.w       #$4, a0                                       ; $006B3E
        move.b       $c(a2), (a0)                                  ; $006B40
        addq.w       #$4, a0                                       ; $006B44
        move.b       $14(a2), (a0)                                 ; $006B46
        addq.w       #$4, a0                                       ; $006B4A
        move.b       $1c(a2), (a0)                                 ; $006B4C
        addq.w       #$4, a0                                       ; $006B50
        lea.l        $8(a5), a5                                    ; $006B52
        movea.l      $8(a7), a3                                    ; $006B56
        jmp          (a3)                                          ; $006B5A

loc_006B5C:
        movea.l      $4(a7), a3                                    ; $006B5C
        jsr          (a3)                                          ; $006B60
        move.b       $3(a1), (a0)                                  ; $006B62
        addq.w       #$4, a0                                       ; $006B66
        move.b       $9(a1), (a0)                                  ; $006B68
        addq.w       #$4, a0                                       ; $006B6C
        move.b       $10(a1), (a0)                                 ; $006B6E
        addq.w       #$4, a0                                       ; $006B72
        move.b       $16(a1), (a0)                                 ; $006B74
        addq.w       #$4, a0                                       ; $006B78
        move.b       $1c(a1), (a0)                                 ; $006B7A
        addq.w       #$4, a0                                       ; $006B7E
        move.b       $3(a2), (a0)                                  ; $006B80
        addq.w       #$4, a0                                       ; $006B84
        move.b       $9(a2), (a0)                                  ; $006B86
        addq.w       #$4, a0                                       ; $006B8A
        move.b       $10(a2), (a0)                                 ; $006B8C
        addq.w       #$4, a0                                       ; $006B90
        move.b       $16(a2), (a0)                                 ; $006B92
        addq.w       #$4, a0                                       ; $006B96
        move.b       $1c(a2), (a0)                                 ; $006B98
        addq.w       #$4, a0                                       ; $006B9C
        lea.l        $a(a5), a5                                    ; $006B9E
        movea.l      $8(a7), a3                                    ; $006BA2
        jmp          (a3)                                          ; $006BA6

loc_006BA8:
        movea.l      $4(a7), a3                                    ; $006BA8
        jsr          (a3)                                          ; $006BAC
        move.b       $2(a1), (a0)                                  ; $006BAE
        addq.w       #$4, a0                                       ; $006BB2
        move.b       $8(a1), (a0)                                  ; $006BB4
        addq.w       #$4, a0                                       ; $006BB8
        move.b       $d(a1), (a0)                                  ; $006BBA
        addq.w       #$4, a0                                       ; $006BBE
        move.b       $12(a1), (a0)                                 ; $006BC0
        addq.w       #$4, a0                                       ; $006BC4
        move.b       $18(a1), (a0)                                 ; $006BC6
        addq.w       #$4, a0                                       ; $006BCA
        move.b       $1d(a1), (a0)                                 ; $006BCC
        addq.w       #$4, a0                                       ; $006BD0
        move.b       $2(a2), (a0)                                  ; $006BD2
        addq.w       #$4, a0                                       ; $006BD6
        move.b       $8(a2), (a0)                                  ; $006BD8
        addq.w       #$4, a0                                       ; $006BDC
        move.b       $d(a2), (a0)                                  ; $006BDE
        addq.w       #$4, a0                                       ; $006BE2
        move.b       $12(a2), (a0)                                 ; $006BE4
        addq.w       #$4, a0                                       ; $006BE8
        move.b       $18(a2), (a0)                                 ; $006BEA
        addq.w       #$4, a0                                       ; $006BEE
        move.b       $1d(a2), (a0)                                 ; $006BF0
        addq.w       #$4, a0                                       ; $006BF4
        lea.l        $c(a5), a5                                    ; $006BF6
        movea.l      $8(a7), a3                                    ; $006BFA
        jmp          (a3)                                          ; $006BFE

loc_006C00:
        movea.l      $4(a7), a3                                    ; $006C00
        jsr          (a3)                                          ; $006C04
        move.b       $2(a1), (a0)                                  ; $006C06
        addq.w       #$4, a0                                       ; $006C0A
        move.b       $6(a1), (a0)                                  ; $006C0C
        addq.w       #$4, a0                                       ; $006C10
        move.b       $b(a1), (a0)                                  ; $006C12
        addq.w       #$4, a0                                       ; $006C16
        move.b       $10(a1), (a0)                                 ; $006C18
        addq.w       #$4, a0                                       ; $006C1C
        move.b       $14(a1), (a0)                                 ; $006C1E
        addq.w       #$4, a0                                       ; $006C22
        move.b       $19(a1), (a0)                                 ; $006C24
        addq.w       #$4, a0                                       ; $006C28
        move.b       $1d(a1), (a0)                                 ; $006C2A
        addq.w       #$4, a0                                       ; $006C2E
        move.b       $2(a2), (a0)                                  ; $006C30
        addq.w       #$4, a0                                       ; $006C34
        move.b       $6(a2), (a0)                                  ; $006C36
        addq.w       #$4, a0                                       ; $006C3A
        move.b       $b(a2), (a0)                                  ; $006C3C
        addq.w       #$4, a0                                       ; $006C40
        move.b       $10(a2), (a0)                                 ; $006C42
        addq.w       #$4, a0                                       ; $006C46
        move.b       $14(a2), (a0)                                 ; $006C48
        addq.w       #$4, a0                                       ; $006C4C
        move.b       $19(a2), (a0)                                 ; $006C4E
        addq.w       #$4, a0                                       ; $006C52
        move.b       $1d(a2), (a0)                                 ; $006C54
        addq.w       #$4, a0                                       ; $006C58
        lea.l        $e(a5), a5                                    ; $006C5A
        movea.l      $8(a7), a3                                    ; $006C5E
        jmp          (a3)                                          ; $006C62

loc_006C64:
        movea.l      $4(a7), a3                                    ; $006C64
        jsr          (a3)                                          ; $006C68
        move.b       $2(a1), (a0)                                  ; $006C6A
        addq.w       #$4, a0                                       ; $006C6E
        move.b       $6(a1), (a0)                                  ; $006C70
        addq.w       #$4, a0                                       ; $006C74
        move.b       $a(a1), (a0)                                  ; $006C76
        addq.w       #$4, a0                                       ; $006C7A
        move.b       $e(a1), (a0)                                  ; $006C7C
        addq.w       #$4, a0                                       ; $006C80
        move.b       $12(a1), (a0)                                 ; $006C82
        addq.w       #$4, a0                                       ; $006C86
        move.b       $16(a1), (a0)                                 ; $006C88
        addq.w       #$4, a0                                       ; $006C8C
        move.b       $1a(a1), (a0)                                 ; $006C8E
        addq.w       #$4, a0                                       ; $006C92
        move.b       $1e(a1), (a0)                                 ; $006C94
        addq.w       #$4, a0                                       ; $006C98
        move.b       $2(a2), (a0)                                  ; $006C9A
        addq.w       #$4, a0                                       ; $006C9E
        move.b       $6(a2), (a0)                                  ; $006CA0
        addq.w       #$4, a0                                       ; $006CA4
        move.b       $a(a2), (a0)                                  ; $006CA6
        addq.w       #$4, a0                                       ; $006CAA
        move.b       $e(a2), (a0)                                  ; $006CAC
        addq.w       #$4, a0                                       ; $006CB0
        move.b       $12(a2), (a0)                                 ; $006CB2
        addq.w       #$4, a0                                       ; $006CB6
        move.b       $16(a2), (a0)                                 ; $006CB8
        addq.w       #$4, a0                                       ; $006CBC
        move.b       $1a(a2), (a0)                                 ; $006CBE
        addq.w       #$4, a0                                       ; $006CC2
        move.b       $1e(a2), (a0)                                 ; $006CC4
        addq.w       #$4, a0                                       ; $006CC8
        lea.l        $10(a5), a5                                   ; $006CCA
        movea.l      $8(a7), a3                                    ; $006CCE
        jmp          (a3)                                          ; $006CD2

loc_006CD4:
        movea.l      $4(a7), a3                                    ; $006CD4
        jsr          (a3)                                          ; $006CD8
        move.b       $1(a1), (a0)                                  ; $006CDA
        addq.w       #$4, a0                                       ; $006CDE
        move.b       $5(a1), (a0)                                  ; $006CE0
        addq.w       #$4, a0                                       ; $006CE4
        move.b       $8(a1), (a0)                                  ; $006CE6
        addq.w       #$4, a0                                       ; $006CEA
        move.b       $c(a1), (a0)                                  ; $006CEC
        addq.w       #$4, a0                                       ; $006CF0
        move.b       $10(a1), (a0)                                 ; $006CF2
        addq.w       #$4, a0                                       ; $006CF6
        move.b       $13(a1), (a0)                                 ; $006CF8
        addq.w       #$4, a0                                       ; $006CFC
        move.b       $17(a1), (a0)                                 ; $006CFE
        addq.w       #$4, a0                                       ; $006D02
        move.b       $1a(a1), (a0)                                 ; $006D04
        addq.w       #$4, a0                                       ; $006D08
        move.b       $1e(a1), (a0)                                 ; $006D0A
        addq.w       #$4, a0                                       ; $006D0E
        move.b       $1(a2), (a0)                                  ; $006D10
        addq.w       #$4, a0                                       ; $006D14
        move.b       $5(a2), (a0)                                  ; $006D16
        addq.w       #$4, a0                                       ; $006D1A
        move.b       $8(a2), (a0)                                  ; $006D1C
        addq.w       #$4, a0                                       ; $006D20
        move.b       $c(a2), (a0)                                  ; $006D22
        addq.w       #$4, a0                                       ; $006D26
        move.b       $10(a2), (a0)                                 ; $006D28
        addq.w       #$4, a0                                       ; $006D2C
        move.b       $13(a2), (a0)                                 ; $006D2E
        addq.w       #$4, a0                                       ; $006D32
        move.b       $17(a2), (a0)                                 ; $006D34
        addq.w       #$4, a0                                       ; $006D38
        move.b       $1a(a2), (a0)                                 ; $006D3A
        addq.w       #$4, a0                                       ; $006D3E
        move.b       $1e(a2), (a0)                                 ; $006D40
        addq.w       #$4, a0                                       ; $006D44
        lea.l        $12(a5), a5                                   ; $006D46
        movea.l      $8(a7), a3                                    ; $006D4A
        jmp          (a3)                                          ; $006D4E

loc_006D50:
        movea.l      $4(a7), a3                                    ; $006D50
        jsr          (a3)                                          ; $006D54
        move.b       $1(a1), (a0)                                  ; $006D56
        addq.w       #$4, a0                                       ; $006D5A
        move.b       $4(a1), (a0)                                  ; $006D5C
        addq.w       #$4, a0                                       ; $006D60
        move.b       $8(a1), (a0)                                  ; $006D62
        addq.w       #$4, a0                                       ; $006D66
        move.b       $b(a1), (a0)                                  ; $006D68
        addq.w       #$4, a0                                       ; $006D6C
        move.b       $e(a1), (a0)                                  ; $006D6E
        addq.w       #$4, a0                                       ; $006D72
        move.b       $11(a1), (a0)                                 ; $006D74
        addq.w       #$4, a0                                       ; $006D78
        move.b       $14(a1), (a0)                                 ; $006D7A
        addq.w       #$4, a0                                       ; $006D7E
        move.b       $18(a1), (a0)                                 ; $006D80
        addq.w       #$4, a0                                       ; $006D84
        move.b       $1b(a1), (a0)                                 ; $006D86
        addq.w       #$4, a0                                       ; $006D8A
        move.b       $1e(a1), (a0)                                 ; $006D8C
        addq.w       #$4, a0                                       ; $006D90
        move.b       $1(a2), (a0)                                  ; $006D92
        addq.w       #$4, a0                                       ; $006D96
        move.b       $4(a2), (a0)                                  ; $006D98
        addq.w       #$4, a0                                       ; $006D9C
        move.b       $8(a2), (a0)                                  ; $006D9E
        addq.w       #$4, a0                                       ; $006DA2
        move.b       $b(a2), (a0)                                  ; $006DA4
        addq.w       #$4, a0                                       ; $006DA8
        move.b       $e(a2), (a0)                                  ; $006DAA
        addq.w       #$4, a0                                       ; $006DAE
        move.b       $11(a2), (a0)                                 ; $006DB0
        addq.w       #$4, a0                                       ; $006DB4
        move.b       $14(a2), (a0)                                 ; $006DB6
        addq.w       #$4, a0                                       ; $006DBA
        move.b       $18(a2), (a0)                                 ; $006DBC
        addq.w       #$4, a0                                       ; $006DC0
        move.b       $1b(a2), (a0)                                 ; $006DC2
        addq.w       #$4, a0                                       ; $006DC6
        move.b       $1e(a2), (a0)                                 ; $006DC8
        addq.w       #$4, a0                                       ; $006DCC
        lea.l        $14(a5), a5                                   ; $006DCE
        movea.l      $8(a7), a3                                    ; $006DD2
        jmp          (a3)                                          ; $006DD6

loc_006DD8:
        movea.l      $4(a7), a3                                    ; $006DD8
        jsr          (a3)                                          ; $006DDC
        move.b       $1(a1), (a0)                                  ; $006DDE
        addq.w       #$4, a0                                       ; $006DE2
        move.b       $4(a1), (a0)                                  ; $006DE4
        addq.w       #$4, a0                                       ; $006DE8
        move.b       $7(a1), (a0)                                  ; $006DEA
        addq.w       #$4, a0                                       ; $006DEE
        move.b       $a(a1), (a0)                                  ; $006DF0
        addq.w       #$4, a0                                       ; $006DF4
        move.b       $d(a1), (a0)                                  ; $006DF6
        addq.w       #$4, a0                                       ; $006DFA
        move.b       $10(a1), (a0)                                 ; $006DFC
        addq.w       #$4, a0                                       ; $006E00
        move.b       $12(a1), (a0)                                 ; $006E02
        addq.w       #$4, a0                                       ; $006E06
        move.b       $15(a1), (a0)                                 ; $006E08
        addq.w       #$4, a0                                       ; $006E0C
        move.b       $18(a1), (a0)                                 ; $006E0E
        addq.w       #$4, a0                                       ; $006E12
        move.b       $1b(a1), (a0)                                 ; $006E14
        addq.w       #$4, a0                                       ; $006E18
        move.b       $1e(a1), (a0)                                 ; $006E1A
        addq.w       #$4, a0                                       ; $006E1E
        move.b       $1(a2), (a0)                                  ; $006E20
        addq.w       #$4, a0                                       ; $006E24
        move.b       $4(a2), (a0)                                  ; $006E26
        addq.w       #$4, a0                                       ; $006E2A
        move.b       $7(a2), (a0)                                  ; $006E2C
        addq.w       #$4, a0                                       ; $006E30
        move.b       $a(a2), (a0)                                  ; $006E32
        addq.w       #$4, a0                                       ; $006E36
        move.b       $d(a2), (a0)                                  ; $006E38
        addq.w       #$4, a0                                       ; $006E3C
        move.b       $10(a2), (a0)                                 ; $006E3E
        addq.w       #$4, a0                                       ; $006E42
        move.b       $12(a2), (a0)                                 ; $006E44
        addq.w       #$4, a0                                       ; $006E48
        move.b       $15(a2), (a0)                                 ; $006E4A
        addq.w       #$4, a0                                       ; $006E4E
        move.b       $18(a2), (a0)                                 ; $006E50
        addq.w       #$4, a0                                       ; $006E54
        move.b       $1b(a2), (a0)                                 ; $006E56
        addq.w       #$4, a0                                       ; $006E5A
        move.b       $1e(a2), (a0)                                 ; $006E5C
        addq.w       #$4, a0                                       ; $006E60
        lea.l        $16(a5), a5                                   ; $006E62
        movea.l      $8(a7), a3                                    ; $006E66
        jmp          (a3)                                          ; $006E6A

loc_006E6C:
        movea.l      $4(a7), a3                                    ; $006E6C
        jsr          (a3)                                          ; $006E70
        move.b       $1(a1), (a0)                                  ; $006E72
        addq.w       #$4, a0                                       ; $006E76
        move.b       $4(a1), (a0)                                  ; $006E78
        addq.w       #$4, a0                                       ; $006E7C
        move.b       $6(a1), (a0)                                  ; $006E7E
        addq.w       #$4, a0                                       ; $006E82
        move.b       $9(a1), (a0)                                  ; $006E84
        addq.w       #$4, a0                                       ; $006E88
        move.b       $c(a1), (a0)                                  ; $006E8A
        addq.w       #$4, a0                                       ; $006E8E
        move.b       $e(a1), (a0)                                  ; $006E90
        addq.w       #$4, a0                                       ; $006E94
        move.b       $11(a1), (a0)                                 ; $006E96
        addq.w       #$4, a0                                       ; $006E9A
        move.b       $14(a1), (a0)                                 ; $006E9C
        addq.w       #$4, a0                                       ; $006EA0
        move.b       $16(a1), (a0)                                 ; $006EA2
        addq.w       #$4, a0                                       ; $006EA6
        move.b       $19(a1), (a0)                                 ; $006EA8
        addq.w       #$4, a0                                       ; $006EAC
        move.b       $1c(a1), (a0)                                 ; $006EAE
        addq.w       #$4, a0                                       ; $006EB2
        move.b       $1e(a1), (a0)                                 ; $006EB4
        addq.w       #$4, a0                                       ; $006EB8
        move.b       $1(a2), (a0)                                  ; $006EBA
        addq.w       #$4, a0                                       ; $006EBE
        move.b       $4(a2), (a0)                                  ; $006EC0
        addq.w       #$4, a0                                       ; $006EC4
        move.b       $6(a2), (a0)                                  ; $006EC6
        addq.w       #$4, a0                                       ; $006ECA
        move.b       $9(a2), (a0)                                  ; $006ECC
        addq.w       #$4, a0                                       ; $006ED0
        move.b       $c(a2), (a0)                                  ; $006ED2
        addq.w       #$4, a0                                       ; $006ED6
        move.b       $e(a2), (a0)                                  ; $006ED8
        addq.w       #$4, a0                                       ; $006EDC
        move.b       $11(a2), (a0)                                 ; $006EDE
        addq.w       #$4, a0                                       ; $006EE2
        move.b       $14(a2), (a0)                                 ; $006EE4
        addq.w       #$4, a0                                       ; $006EE8
        move.b       $16(a2), (a0)                                 ; $006EEA
        addq.w       #$4, a0                                       ; $006EEE
        move.b       $19(a2), (a0)                                 ; $006EF0
        addq.w       #$4, a0                                       ; $006EF4
        move.b       $1c(a2), (a0)                                 ; $006EF6
        addq.w       #$4, a0                                       ; $006EFA
        move.b       $1e(a2), (a0)                                 ; $006EFC
        addq.w       #$4, a0                                       ; $006F00
        lea.l        $18(a5), a5                                   ; $006F02
        movea.l      $8(a7), a3                                    ; $006F06
        jmp          (a3)                                          ; $006F0A

loc_006F0C:
        movea.l      $4(a7), a3                                    ; $006F0C
        jsr          (a3)                                          ; $006F10
        move.b       $1(a1), (a0)                                  ; $006F12
        addq.w       #$4, a0                                       ; $006F16
        move.b       $3(a1), (a0)                                  ; $006F18
        addq.w       #$4, a0                                       ; $006F1C
        move.b       $6(a1), (a0)                                  ; $006F1E
        addq.w       #$4, a0                                       ; $006F22
        move.b       $8(a1), (a0)                                  ; $006F24
        addq.w       #$4, a0                                       ; $006F28
        move.b       $b(a1), (a0)                                  ; $006F2A
        addq.w       #$4, a0                                       ; $006F2E
        move.b       $d(a1), (a0)                                  ; $006F30
        addq.w       #$4, a0                                       ; $006F34
        move.b       $10(a1), (a0)                                 ; $006F36
        addq.w       #$4, a0                                       ; $006F3A
        move.b       $12(a1), (a0)                                 ; $006F3C
        addq.w       #$4, a0                                       ; $006F40
        move.b       $14(a1), (a0)                                 ; $006F42
        addq.w       #$4, a0                                       ; $006F46
        move.b       $17(a1), (a0)                                 ; $006F48
        addq.w       #$4, a0                                       ; $006F4C
        move.b       $19(a1), (a0)                                 ; $006F4E
        addq.w       #$4, a0                                       ; $006F52
        move.b       $1c(a1), (a0)                                 ; $006F54
        addq.w       #$4, a0                                       ; $006F58
        move.b       $1e(a1), (a0)                                 ; $006F5A
        addq.w       #$4, a0                                       ; $006F5E
        move.b       $1(a2), (a0)                                  ; $006F60
        addq.w       #$4, a0                                       ; $006F64
        move.b       $3(a2), (a0)                                  ; $006F66
        addq.w       #$4, a0                                       ; $006F6A
        move.b       $6(a2), (a0)                                  ; $006F6C
        addq.w       #$4, a0                                       ; $006F70
        move.b       $8(a2), (a0)                                  ; $006F72
        addq.w       #$4, a0                                       ; $006F76
        move.b       $b(a2), (a0)                                  ; $006F78
        addq.w       #$4, a0                                       ; $006F7C
        move.b       $d(a2), (a0)                                  ; $006F7E
        addq.w       #$4, a0                                       ; $006F82
        move.b       $10(a2), (a0)                                 ; $006F84
        addq.w       #$4, a0                                       ; $006F88
        move.b       $12(a2), (a0)                                 ; $006F8A
        addq.w       #$4, a0                                       ; $006F8E
        move.b       $14(a2), (a0)                                 ; $006F90
        addq.w       #$4, a0                                       ; $006F94
        move.b       $17(a2), (a0)                                 ; $006F96
        addq.w       #$4, a0                                       ; $006F9A
        move.b       $19(a2), (a0)                                 ; $006F9C
        addq.w       #$4, a0                                       ; $006FA0
        move.b       $1c(a2), (a0)                                 ; $006FA2
        addq.w       #$4, a0                                       ; $006FA6
        move.b       $1e(a2), (a0)                                 ; $006FA8
        addq.w       #$4, a0                                       ; $006FAC
        lea.l        $1a(a5), a5                                   ; $006FAE
        movea.l      $8(a7), a3                                    ; $006FB2
        jmp          (a3)                                          ; $006FB6

loc_006FB8:
        movea.l      $4(a7), a3                                    ; $006FB8
        jsr          (a3)                                          ; $006FBC
        move.b       $1(a1), (a0)                                  ; $006FBE
        addq.w       #$4, a0                                       ; $006FC2
        move.b       $3(a1), (a0)                                  ; $006FC4
        addq.w       #$4, a0                                       ; $006FC8
        move.b       $5(a1), (a0)                                  ; $006FCA
        addq.w       #$4, a0                                       ; $006FCE
        move.b       $8(a1), (a0)                                  ; $006FD0
        addq.w       #$4, a0                                       ; $006FD4
        move.b       $a(a1), (a0)                                  ; $006FD6
        addq.w       #$4, a0                                       ; $006FDA
        move.b       $c(a1), (a0)                                  ; $006FDC
        addq.w       #$4, a0                                       ; $006FE0
        move.b       $e(a1), (a0)                                  ; $006FE2
        addq.w       #$4, a0                                       ; $006FE6
        move.b       $11(a1), (a0)                                 ; $006FE8
        addq.w       #$4, a0                                       ; $006FEC
        move.b       $13(a1), (a0)                                 ; $006FEE
        addq.w       #$4, a0                                       ; $006FF2
        move.b       $15(a1), (a0)                                 ; $006FF4
        addq.w       #$4, a0                                       ; $006FF8
        move.b       $18(a1), (a0)                                 ; $006FFA
        addq.w       #$4, a0                                       ; $006FFE
        move.b       $1a(a1), (a0)                                 ; $007000
        addq.w       #$4, a0                                       ; $007004
        move.b       $1c(a1), (a0)                                 ; $007006
        addq.w       #$4, a0                                       ; $00700A
        move.b       $1e(a1), (a0)                                 ; $00700C
        addq.w       #$4, a0                                       ; $007010
        move.b       $1(a2), (a0)                                  ; $007012
        addq.w       #$4, a0                                       ; $007016
        move.b       $3(a2), (a0)                                  ; $007018
        addq.w       #$4, a0                                       ; $00701C
        move.b       $5(a2), (a0)                                  ; $00701E
        addq.w       #$4, a0                                       ; $007022
        move.b       $8(a2), (a0)                                  ; $007024
        addq.w       #$4, a0                                       ; $007028
        move.b       $a(a2), (a0)                                  ; $00702A
        addq.w       #$4, a0                                       ; $00702E
        move.b       $c(a2), (a0)                                  ; $007030
        addq.w       #$4, a0                                       ; $007034
        move.b       $e(a2), (a0)                                  ; $007036
        addq.w       #$4, a0                                       ; $00703A
        move.b       $11(a2), (a0)                                 ; $00703C
        addq.w       #$4, a0                                       ; $007040
        move.b       $13(a2), (a0)                                 ; $007042
        addq.w       #$4, a0                                       ; $007046
        move.b       $15(a2), (a0)                                 ; $007048
        addq.w       #$4, a0                                       ; $00704C
        move.b       $18(a2), (a0)                                 ; $00704E
        addq.w       #$4, a0                                       ; $007052
        move.b       $1a(a2), (a0)                                 ; $007054
        addq.w       #$4, a0                                       ; $007058
        move.b       $1c(a2), (a0)                                 ; $00705A
        addq.w       #$4, a0                                       ; $00705E
        move.b       $1e(a2), (a0)                                 ; $007060
        addq.w       #$4, a0                                       ; $007064
        lea.l        $1c(a5), a5                                   ; $007066
        movea.l      $8(a7), a3                                    ; $00706A
        jmp          (a3)                                          ; $00706E

loc_007070:
        movea.l      $4(a7), a3                                    ; $007070
        jsr          (a3)                                          ; $007074
        move.b       $1(a1), (a0)                                  ; $007076
        addq.w       #$4, a0                                       ; $00707A
        move.b       $3(a1), (a0)                                  ; $00707C
        addq.w       #$4, a0                                       ; $007080
        move.b       $5(a1), (a0)                                  ; $007082
        addq.w       #$4, a0                                       ; $007086
        move.b       $7(a1), (a0)                                  ; $007088
        addq.w       #$4, a0                                       ; $00708C
        move.b       $9(a1), (a0)                                  ; $00708E
        addq.w       #$4, a0                                       ; $007092
        move.b       $b(a1), (a0)                                  ; $007094
        addq.w       #$4, a0                                       ; $007098
        move.b       $d(a1), (a0)                                  ; $00709A
        addq.w       #$4, a0                                       ; $00709E
        move.b       $10(a1), (a0)                                 ; $0070A0
        addq.w       #$4, a0                                       ; $0070A4
        move.b       $12(a1), (a0)                                 ; $0070A6
        addq.w       #$4, a0                                       ; $0070AA
        move.b       $14(a1), (a0)                                 ; $0070AC
        addq.w       #$4, a0                                       ; $0070B0
        move.b       $16(a1), (a0)                                 ; $0070B2
        addq.w       #$4, a0                                       ; $0070B6
        move.b       $18(a1), (a0)                                 ; $0070B8
        addq.w       #$4, a0                                       ; $0070BC
        move.b       $1a(a1), (a0)                                 ; $0070BE
        addq.w       #$4, a0                                       ; $0070C2
        move.b       $1c(a1), (a0)                                 ; $0070C4
        addq.w       #$4, a0                                       ; $0070C8
        move.b       $1e(a1), (a0)                                 ; $0070CA
        addq.w       #$4, a0                                       ; $0070CE
        move.b       $1(a2), (a0)                                  ; $0070D0
        addq.w       #$4, a0                                       ; $0070D4
        move.b       $3(a2), (a0)                                  ; $0070D6
        addq.w       #$4, a0                                       ; $0070DA
        move.b       $5(a2), (a0)                                  ; $0070DC
        addq.w       #$4, a0                                       ; $0070E0
        move.b       $7(a2), (a0)                                  ; $0070E2
        addq.w       #$4, a0                                       ; $0070E6
        move.b       $9(a2), (a0)                                  ; $0070E8
        addq.w       #$4, a0                                       ; $0070EC
        move.b       $b(a2), (a0)                                  ; $0070EE
        addq.w       #$4, a0                                       ; $0070F2
        move.b       $d(a2), (a0)                                  ; $0070F4
        addq.w       #$4, a0                                       ; $0070F8
        move.b       $10(a2), (a0)                                 ; $0070FA
        addq.w       #$4, a0                                       ; $0070FE
        move.b       $12(a2), (a0)                                 ; $007100
        addq.w       #$4, a0                                       ; $007104
        move.b       $14(a2), (a0)                                 ; $007106
        addq.w       #$4, a0                                       ; $00710A
        move.b       $16(a2), (a0)                                 ; $00710C
        addq.w       #$4, a0                                       ; $007110
        move.b       $18(a2), (a0)                                 ; $007112
        addq.w       #$4, a0                                       ; $007116
        move.b       $1a(a2), (a0)                                 ; $007118
        addq.w       #$4, a0                                       ; $00711C
        move.b       $1c(a2), (a0)                                 ; $00711E
        addq.w       #$4, a0                                       ; $007122
        move.b       $1e(a2), (a0)                                 ; $007124
        addq.w       #$4, a0                                       ; $007128
        lea.l        $1e(a5), a5                                   ; $00712A
        movea.l      $8(a7), a3                                    ; $00712E
        jmp          (a3)                                          ; $007132

loc_007134:
        movea.l      $4(a7), a3                                    ; $007134
        jsr          (a3)                                          ; $007138
        move.b       $1(a1), (a0)                                  ; $00713A
        addq.w       #$4, a0                                       ; $00713E
        move.b       $3(a1), (a0)                                  ; $007140
        addq.w       #$4, a0                                       ; $007144
        move.b       $5(a1), (a0)                                  ; $007146
        addq.w       #$4, a0                                       ; $00714A
        move.b       $7(a1), (a0)                                  ; $00714C
        addq.w       #$4, a0                                       ; $007150
        move.b       $9(a1), (a0)                                  ; $007152
        addq.w       #$4, a0                                       ; $007156
        move.b       $b(a1), (a0)                                  ; $007158
        addq.w       #$4, a0                                       ; $00715C
        move.b       $d(a1), (a0)                                  ; $00715E
        addq.w       #$4, a0                                       ; $007162
        move.b       $f(a1), (a0)                                  ; $007164
        addq.w       #$4, a0                                       ; $007168
        move.b       $11(a1), (a0)                                 ; $00716A
        addq.w       #$4, a0                                       ; $00716E
        move.b       $13(a1), (a0)                                 ; $007170
        addq.w       #$4, a0                                       ; $007174
        move.b       $15(a1), (a0)                                 ; $007176
        addq.w       #$4, a0                                       ; $00717A
        move.b       $17(a1), (a0)                                 ; $00717C
        addq.w       #$4, a0                                       ; $007180
        move.b       $19(a1), (a0)                                 ; $007182
        addq.w       #$4, a0                                       ; $007186
        move.b       $1b(a1), (a0)                                 ; $007188
        addq.w       #$4, a0                                       ; $00718C
        move.b       $1d(a1), (a0)                                 ; $00718E
        addq.w       #$4, a0                                       ; $007192
        move.b       $1f(a1), (a0)                                 ; $007194
        addq.w       #$4, a0                                       ; $007198
        move.b       $1(a2), (a0)                                  ; $00719A
        addq.w       #$4, a0                                       ; $00719E
        move.b       $3(a2), (a0)                                  ; $0071A0
        addq.w       #$4, a0                                       ; $0071A4
        move.b       $5(a2), (a0)                                  ; $0071A6
        addq.w       #$4, a0                                       ; $0071AA
        move.b       $7(a2), (a0)                                  ; $0071AC
        addq.w       #$4, a0                                       ; $0071B0
        move.b       $9(a2), (a0)                                  ; $0071B2
        addq.w       #$4, a0                                       ; $0071B6
        move.b       $b(a2), (a0)                                  ; $0071B8
        addq.w       #$4, a0                                       ; $0071BC
        move.b       $d(a2), (a0)                                  ; $0071BE
        addq.w       #$4, a0                                       ; $0071C2
        move.b       $f(a2), (a0)                                  ; $0071C4
        addq.w       #$4, a0                                       ; $0071C8
        move.b       $11(a2), (a0)                                 ; $0071CA
        addq.w       #$4, a0                                       ; $0071CE
        move.b       $13(a2), (a0)                                 ; $0071D0
        addq.w       #$4, a0                                       ; $0071D4
        move.b       $15(a2), (a0)                                 ; $0071D6
        addq.w       #$4, a0                                       ; $0071DA
        move.b       $17(a2), (a0)                                 ; $0071DC
        addq.w       #$4, a0                                       ; $0071E0
        move.b       $19(a2), (a0)                                 ; $0071E2
        addq.w       #$4, a0                                       ; $0071E6
        move.b       $1b(a2), (a0)                                 ; $0071E8
        addq.w       #$4, a0                                       ; $0071EC
        move.b       $1d(a2), (a0)                                 ; $0071EE
        addq.w       #$4, a0                                       ; $0071F2
        move.b       $1f(a2), (a0)                                 ; $0071F4
        addq.w       #$4, a0                                       ; $0071F8
        lea.l        $20(a5), a5                                   ; $0071FA
        movea.l      $8(a7), a3                                    ; $0071FE
        jmp          (a3)                                          ; $007202

loc_007204:
        movea.l      $4(a7), a3                                    ; $007204
        jsr          (a3)                                          ; $007208
        move.b       (a1), (a0)                                    ; $00720A
        addq.w       #$4, a0                                       ; $00720C
        move.b       $2(a1), (a0)                                  ; $00720E
        addq.w       #$4, a0                                       ; $007212
        move.b       $4(a1), (a0)                                  ; $007214
        addq.w       #$4, a0                                       ; $007218
        move.b       $6(a1), (a0)                                  ; $00721A
        addq.w       #$4, a0                                       ; $00721E
        move.b       $8(a1), (a0)                                  ; $007220
        addq.w       #$4, a0                                       ; $007224
        move.b       $a(a1), (a0)                                  ; $007226
        addq.w       #$4, a0                                       ; $00722A
        move.b       $c(a1), (a0)                                  ; $00722C
        addq.w       #$4, a0                                       ; $007230
        move.b       $e(a1), (a0)                                  ; $007232
        addq.w       #$4, a0                                       ; $007236
        move.b       $10(a1), (a0)                                 ; $007238
        addq.w       #$4, a0                                       ; $00723C
        move.b       $11(a1), (a0)                                 ; $00723E
        addq.w       #$4, a0                                       ; $007242
        move.b       $13(a1), (a0)                                 ; $007244
        addq.w       #$4, a0                                       ; $007248
        move.b       $15(a1), (a0)                                 ; $00724A
        addq.w       #$4, a0                                       ; $00724E
        move.b       $17(a1), (a0)                                 ; $007250
        addq.w       #$4, a0                                       ; $007254
        move.b       $19(a1), (a0)                                 ; $007256
        addq.w       #$4, a0                                       ; $00725A
        move.b       $1b(a1), (a0)                                 ; $00725C
        addq.w       #$4, a0                                       ; $007260
        move.b       $1d(a1), (a0)                                 ; $007262
        addq.w       #$4, a0                                       ; $007266
        move.b       $1f(a1), (a0)                                 ; $007268
        addq.w       #$4, a0                                       ; $00726C
        move.b       (a2), (a0)                                    ; $00726E
        addq.w       #$4, a0                                       ; $007270
        move.b       $2(a2), (a0)                                  ; $007272
        addq.w       #$4, a0                                       ; $007276
        move.b       $4(a2), (a0)                                  ; $007278
        addq.w       #$4, a0                                       ; $00727C
        move.b       $6(a2), (a0)                                  ; $00727E
        addq.w       #$4, a0                                       ; $007282
        move.b       $8(a2), (a0)                                  ; $007284
        addq.w       #$4, a0                                       ; $007288
        move.b       $a(a2), (a0)                                  ; $00728A
        addq.w       #$4, a0                                       ; $00728E
        move.b       $c(a2), (a0)                                  ; $007290
        addq.w       #$4, a0                                       ; $007294
        move.b       $e(a2), (a0)                                  ; $007296
        addq.w       #$4, a0                                       ; $00729A
        move.b       $10(a2), (a0)                                 ; $00729C
        addq.w       #$4, a0                                       ; $0072A0
        move.b       $11(a2), (a0)                                 ; $0072A2
        addq.w       #$4, a0                                       ; $0072A6
        move.b       $13(a2), (a0)                                 ; $0072A8
        addq.w       #$4, a0                                       ; $0072AC
        move.b       $15(a2), (a0)                                 ; $0072AE
        addq.w       #$4, a0                                       ; $0072B2
        move.b       $17(a2), (a0)                                 ; $0072B4
        addq.w       #$4, a0                                       ; $0072B8
        move.b       $19(a2), (a0)                                 ; $0072BA
        addq.w       #$4, a0                                       ; $0072BE
        move.b       $1b(a2), (a0)                                 ; $0072C0
        addq.w       #$4, a0                                       ; $0072C4
        move.b       $1d(a2), (a0)                                 ; $0072C6
        addq.w       #$4, a0                                       ; $0072CA
        move.b       $1f(a2), (a0)                                 ; $0072CC
        addq.w       #$4, a0                                       ; $0072D0
        lea.l        $22(a5), a5                                   ; $0072D2
        movea.l      $8(a7), a3                                    ; $0072D6
        jmp          (a3)                                          ; $0072DA

loc_0072DC:
        movea.l      $4(a7), a3                                    ; $0072DC
        jsr          (a3)                                          ; $0072E0
        move.b       (a1), (a0)                                    ; $0072E2
        addq.w       #$4, a0                                       ; $0072E4
        move.b       $2(a1), (a0)                                  ; $0072E6
        addq.w       #$4, a0                                       ; $0072EA
        move.b       $4(a1), (a0)                                  ; $0072EC
        addq.w       #$4, a0                                       ; $0072F0
        move.b       $6(a1), (a0)                                  ; $0072F2
        addq.w       #$4, a0                                       ; $0072F6
        move.b       $8(a1), (a0)                                  ; $0072F8
        addq.w       #$4, a0                                       ; $0072FC
        move.b       $9(a1), (a0)                                  ; $0072FE
        addq.w       #$4, a0                                       ; $007302
        move.b       $b(a1), (a0)                                  ; $007304
        addq.w       #$4, a0                                       ; $007308
        move.b       $d(a1), (a0)                                  ; $00730A
        addq.w       #$4, a0                                       ; $00730E
        move.b       $f(a1), (a0)                                  ; $007310
        addq.w       #$4, a0                                       ; $007314
        move.b       $10(a1), (a0)                                 ; $007316
        addq.w       #$4, a0                                       ; $00731A
        move.b       $12(a1), (a0)                                 ; $00731C
        addq.w       #$4, a0                                       ; $007320
        move.b       $14(a1), (a0)                                 ; $007322
        addq.w       #$4, a0                                       ; $007326
        move.b       $16(a1), (a0)                                 ; $007328
        addq.w       #$4, a0                                       ; $00732C
        move.b       $18(a1), (a0)                                 ; $00732E
        addq.w       #$4, a0                                       ; $007332
        move.b       $19(a1), (a0)                                 ; $007334
        addq.w       #$4, a0                                       ; $007338
        move.b       $1b(a1), (a0)                                 ; $00733A
        addq.w       #$4, a0                                       ; $00733E
        move.b       $1d(a1), (a0)                                 ; $007340
        addq.w       #$4, a0                                       ; $007344
        move.b       $1f(a1), (a0)                                 ; $007346
        addq.w       #$4, a0                                       ; $00734A
        move.b       (a2), (a0)                                    ; $00734C
        addq.w       #$4, a0                                       ; $00734E
        move.b       $2(a2), (a0)                                  ; $007350
        addq.w       #$4, a0                                       ; $007354
        move.b       $4(a2), (a0)                                  ; $007356
        addq.w       #$4, a0                                       ; $00735A
        move.b       $6(a2), (a0)                                  ; $00735C
        addq.w       #$4, a0                                       ; $007360
        move.b       $8(a2), (a0)                                  ; $007362
        addq.w       #$4, a0                                       ; $007366
        move.b       $9(a2), (a0)                                  ; $007368
        addq.w       #$4, a0                                       ; $00736C
        move.b       $b(a2), (a0)                                  ; $00736E
        addq.w       #$4, a0                                       ; $007372
        move.b       $d(a2), (a0)                                  ; $007374
        addq.w       #$4, a0                                       ; $007378
        move.b       $f(a2), (a0)                                  ; $00737A
        addq.w       #$4, a0                                       ; $00737E
        move.b       $10(a2), (a0)                                 ; $007380
        addq.w       #$4, a0                                       ; $007384
        move.b       $12(a2), (a0)                                 ; $007386
        addq.w       #$4, a0                                       ; $00738A
        move.b       $14(a2), (a0)                                 ; $00738C
        addq.w       #$4, a0                                       ; $007390
        move.b       $16(a2), (a0)                                 ; $007392
        addq.w       #$4, a0                                       ; $007396
        move.b       $18(a2), (a0)                                 ; $007398
        addq.w       #$4, a0                                       ; $00739C
        move.b       $19(a2), (a0)                                 ; $00739E
        addq.w       #$4, a0                                       ; $0073A2
        move.b       $1b(a2), (a0)                                 ; $0073A4
        addq.w       #$4, a0                                       ; $0073A8
        move.b       $1d(a2), (a0)                                 ; $0073AA
        addq.w       #$4, a0                                       ; $0073AE
        move.b       $1f(a2), (a0)                                 ; $0073B0
        addq.w       #$4, a0                                       ; $0073B4
        lea.l        $24(a5), a5                                   ; $0073B6
        movea.l      $8(a7), a3                                    ; $0073BA
        jmp          (a3)                                          ; $0073BE

loc_0073C0:
        movea.l      $4(a7), a3                                    ; $0073C0
        jsr          (a3)                                          ; $0073C4
        move.b       (a1), (a0)                                    ; $0073C6
        addq.w       #$4, a0                                       ; $0073C8
        move.b       $2(a1), (a0)                                  ; $0073CA
        addq.w       #$4, a0                                       ; $0073CE
        move.b       $4(a1), (a0)                                  ; $0073D0
        addq.w       #$4, a0                                       ; $0073D4
        move.b       $5(a1), (a0)                                  ; $0073D6
        addq.w       #$4, a0                                       ; $0073DA
        move.b       $7(a1), (a0)                                  ; $0073DC
        addq.w       #$4, a0                                       ; $0073E0
        move.b       $9(a1), (a0)                                  ; $0073E2
        addq.w       #$4, a0                                       ; $0073E6
        move.b       $a(a1), (a0)                                  ; $0073E8
        addq.w       #$4, a0                                       ; $0073EC
        move.b       $c(a1), (a0)                                  ; $0073EE
        addq.w       #$4, a0                                       ; $0073F2
        move.b       $e(a1), (a0)                                  ; $0073F4
        addq.w       #$4, a0                                       ; $0073F8
        move.b       $10(a1), (a0)                                 ; $0073FA
        addq.w       #$4, a0                                       ; $0073FE
        move.b       $11(a1), (a0)                                 ; $007400
        addq.w       #$4, a0                                       ; $007404
        move.b       $13(a1), (a0)                                 ; $007406
        addq.w       #$4, a0                                       ; $00740A
        move.b       $15(a1), (a0)                                 ; $00740C
        addq.w       #$4, a0                                       ; $007410
        move.b       $16(a1), (a0)                                 ; $007412
        addq.w       #$4, a0                                       ; $007416
        move.b       $18(a1), (a0)                                 ; $007418
        addq.w       #$4, a0                                       ; $00741C
        move.b       $1a(a1), (a0)                                 ; $00741E
        addq.w       #$4, a0                                       ; $007422
        move.b       $1b(a1), (a0)                                 ; $007424
        addq.w       #$4, a0                                       ; $007428
        move.b       $1d(a1), (a0)                                 ; $00742A
        addq.w       #$4, a0                                       ; $00742E
        move.b       $1f(a1), (a0)                                 ; $007430
        addq.w       #$4, a0                                       ; $007434
        move.b       (a2), (a0)                                    ; $007436
        addq.w       #$4, a0                                       ; $007438
        move.b       $2(a2), (a0)                                  ; $00743A
        addq.w       #$4, a0                                       ; $00743E
        move.b       $4(a2), (a0)                                  ; $007440
        addq.w       #$4, a0                                       ; $007444
        move.b       $5(a2), (a0)                                  ; $007446
        addq.w       #$4, a0                                       ; $00744A
        move.b       $7(a2), (a0)                                  ; $00744C
        addq.w       #$4, a0                                       ; $007450
        move.b       $9(a2), (a0)                                  ; $007452
        addq.w       #$4, a0                                       ; $007456
        move.b       $a(a2), (a0)                                  ; $007458
        addq.w       #$4, a0                                       ; $00745C
        move.b       $c(a2), (a0)                                  ; $00745E
        addq.w       #$4, a0                                       ; $007462
        move.b       $e(a2), (a0)                                  ; $007464
        addq.w       #$4, a0                                       ; $007468
        move.b       $10(a2), (a0)                                 ; $00746A
        addq.w       #$4, a0                                       ; $00746E
        move.b       $11(a2), (a0)                                 ; $007470
        addq.w       #$4, a0                                       ; $007474
        move.b       $13(a2), (a0)                                 ; $007476
        addq.w       #$4, a0                                       ; $00747A
        move.b       $15(a2), (a0)                                 ; $00747C
        addq.w       #$4, a0                                       ; $007480
        move.b       $16(a2), (a0)                                 ; $007482
        addq.w       #$4, a0                                       ; $007486
        move.b       $18(a2), (a0)                                 ; $007488
        addq.w       #$4, a0                                       ; $00748C
        move.b       $1a(a2), (a0)                                 ; $00748E
        addq.w       #$4, a0                                       ; $007492
        move.b       $1b(a2), (a0)                                 ; $007494
        addq.w       #$4, a0                                       ; $007498
        move.b       $1d(a2), (a0)                                 ; $00749A
        addq.w       #$4, a0                                       ; $00749E
        move.b       $1f(a2), (a0)                                 ; $0074A0
        addq.w       #$4, a0                                       ; $0074A4
        lea.l        $26(a5), a5                                   ; $0074A6
        movea.l      $8(a7), a3                                    ; $0074AA
        jmp          (a3)                                          ; $0074AE

loc_0074B0:
        movea.l      $4(a7), a3                                    ; $0074B0
        jsr          (a3)                                          ; $0074B4
        move.b       (a1), (a0)                                    ; $0074B6
        addq.w       #$4, a0                                       ; $0074B8
        move.b       $2(a1), (a0)                                  ; $0074BA
        addq.w       #$4, a0                                       ; $0074BE
        move.b       $4(a1), (a0)                                  ; $0074C0
        addq.w       #$4, a0                                       ; $0074C4
        move.b       $5(a1), (a0)                                  ; $0074C6
        addq.w       #$4, a0                                       ; $0074CA
        move.b       $7(a1), (a0)                                  ; $0074CC
        addq.w       #$4, a0                                       ; $0074D0
        move.b       $8(a1), (a0)                                  ; $0074D2
        addq.w       #$4, a0                                       ; $0074D6
        move.b       $a(a1), (a0)                                  ; $0074D8
        addq.w       #$4, a0                                       ; $0074DC
        move.b       $c(a1), (a0)                                  ; $0074DE
        addq.w       #$4, a0                                       ; $0074E2
        move.b       $d(a1), (a0)                                  ; $0074E4
        addq.w       #$4, a0                                       ; $0074E8
        move.b       $f(a1), (a0)                                  ; $0074EA
        addq.w       #$4, a0                                       ; $0074EE
        move.b       $10(a1), (a0)                                 ; $0074F0
        addq.w       #$4, a0                                       ; $0074F4
        move.b       $12(a1), (a0)                                 ; $0074F6
        addq.w       #$4, a0                                       ; $0074FA
        move.b       $14(a1), (a0)                                 ; $0074FC
        addq.w       #$4, a0                                       ; $007500
        move.b       $15(a1), (a0)                                 ; $007502
        addq.w       #$4, a0                                       ; $007506
        move.b       $17(a1), (a0)                                 ; $007508
        addq.w       #$4, a0                                       ; $00750C
        move.b       $18(a1), (a0)                                 ; $00750E
        addq.w       #$4, a0                                       ; $007512
        move.b       $1a(a1), (a0)                                 ; $007514
        addq.w       #$4, a0                                       ; $007518
        move.b       $1c(a1), (a0)                                 ; $00751A
        addq.w       #$4, a0                                       ; $00751E
        move.b       $1d(a1), (a0)                                 ; $007520
        addq.w       #$4, a0                                       ; $007524
        move.b       $1f(a1), (a0)                                 ; $007526
        addq.w       #$4, a0                                       ; $00752A
        move.b       (a2), (a0)                                    ; $00752C
        addq.w       #$4, a0                                       ; $00752E
        move.b       $2(a2), (a0)                                  ; $007530
        addq.w       #$4, a0                                       ; $007534
        move.b       $4(a2), (a0)                                  ; $007536
        addq.w       #$4, a0                                       ; $00753A
        move.b       $5(a2), (a0)                                  ; $00753C
        addq.w       #$4, a0                                       ; $007540
        move.b       $7(a2), (a0)                                  ; $007542
        addq.w       #$4, a0                                       ; $007546
        move.b       $8(a2), (a0)                                  ; $007548
        addq.w       #$4, a0                                       ; $00754C
        move.b       $a(a2), (a0)                                  ; $00754E
        addq.w       #$4, a0                                       ; $007552
        move.b       $c(a2), (a0)                                  ; $007554
        addq.w       #$4, a0                                       ; $007558
        move.b       $d(a2), (a0)                                  ; $00755A
        addq.w       #$4, a0                                       ; $00755E
        move.b       $f(a2), (a0)                                  ; $007560
        addq.w       #$4, a0                                       ; $007564
        move.b       $10(a2), (a0)                                 ; $007566
        addq.w       #$4, a0                                       ; $00756A
        move.b       $12(a2), (a0)                                 ; $00756C
        addq.w       #$4, a0                                       ; $007570
        move.b       $14(a2), (a0)                                 ; $007572
        addq.w       #$4, a0                                       ; $007576
        move.b       $15(a2), (a0)                                 ; $007578
        addq.w       #$4, a0                                       ; $00757C
        move.b       $17(a2), (a0)                                 ; $00757E
        addq.w       #$4, a0                                       ; $007582
        move.b       $18(a2), (a0)                                 ; $007584
        addq.w       #$4, a0                                       ; $007588
        move.b       $1a(a2), (a0)                                 ; $00758A
        addq.w       #$4, a0                                       ; $00758E
        move.b       $1c(a2), (a0)                                 ; $007590
        addq.w       #$4, a0                                       ; $007594
        move.b       $1d(a2), (a0)                                 ; $007596
        addq.w       #$4, a0                                       ; $00759A
        move.b       $1f(a2), (a0)                                 ; $00759C
        addq.w       #$4, a0                                       ; $0075A0
        lea.l        $28(a5), a5                                   ; $0075A2
        movea.l      $8(a7), a3                                    ; $0075A6
        jmp          (a3)                                          ; $0075AA

loc_0075AC:
        movea.l      $4(a7), a3                                    ; $0075AC
        jsr          (a3)                                          ; $0075B0
        move.b       (a1), (a0)                                    ; $0075B2
        addq.w       #$4, a0                                       ; $0075B4
        move.b       $2(a1), (a0)                                  ; $0075B6
        addq.w       #$4, a0                                       ; $0075BA
        move.b       $3(a1), (a0)                                  ; $0075BC
        addq.w       #$4, a0                                       ; $0075C0
        move.b       $5(a1), (a0)                                  ; $0075C2
        addq.w       #$4, a0                                       ; $0075C6
        move.b       $6(a1), (a0)                                  ; $0075C8
        addq.w       #$4, a0                                       ; $0075CC
        move.b       $8(a1), (a0)                                  ; $0075CE
        addq.w       #$4, a0                                       ; $0075D2
        move.b       $9(a1), (a0)                                  ; $0075D4
        addq.w       #$4, a0                                       ; $0075D8
        move.b       $b(a1), (a0)                                  ; $0075DA
        addq.w       #$4, a0                                       ; $0075DE
        move.b       $c(a1), (a0)                                  ; $0075E0
        addq.w       #$4, a0                                       ; $0075E4
        move.b       $e(a1), (a0)                                  ; $0075E6
        addq.w       #$4, a0                                       ; $0075EA
        move.b       $10(a1), (a0)                                 ; $0075EC
        addq.w       #$4, a0                                       ; $0075F0
        move.b       $11(a1), (a0)                                 ; $0075F2
        addq.w       #$4, a0                                       ; $0075F6
        move.b       $13(a1), (a0)                                 ; $0075F8
        addq.w       #$4, a0                                       ; $0075FC
        move.b       $14(a1), (a0)                                 ; $0075FE
        addq.w       #$4, a0                                       ; $007602
        move.b       $16(a1), (a0)                                 ; $007604
        addq.w       #$4, a0                                       ; $007608
        move.b       $17(a1), (a0)                                 ; $00760A
        addq.w       #$4, a0                                       ; $00760E
        move.b       $19(a1), (a0)                                 ; $007610
        addq.w       #$4, a0                                       ; $007614
        move.b       $1a(a1), (a0)                                 ; $007616
        addq.w       #$4, a0                                       ; $00761A
        move.b       $1c(a1), (a0)                                 ; $00761C
        addq.w       #$4, a0                                       ; $007620
        move.b       $1d(a1), (a0)                                 ; $007622
        addq.w       #$4, a0                                       ; $007626
        move.b       $1f(a1), (a0)                                 ; $007628
        addq.w       #$4, a0                                       ; $00762C
        move.b       (a2), (a0)                                    ; $00762E
        addq.w       #$4, a0                                       ; $007630
        move.b       $2(a2), (a0)                                  ; $007632
        addq.w       #$4, a0                                       ; $007636
        move.b       $3(a2), (a0)                                  ; $007638
        addq.w       #$4, a0                                       ; $00763C
        move.b       $5(a2), (a0)                                  ; $00763E
        addq.w       #$4, a0                                       ; $007642
        move.b       $6(a2), (a0)                                  ; $007644
        addq.w       #$4, a0                                       ; $007648
        move.b       $8(a2), (a0)                                  ; $00764A
        addq.w       #$4, a0                                       ; $00764E
        move.b       $9(a2), (a0)                                  ; $007650
        addq.w       #$4, a0                                       ; $007654
        move.b       $b(a2), (a0)                                  ; $007656
        addq.w       #$4, a0                                       ; $00765A
        move.b       $c(a2), (a0)                                  ; $00765C
        addq.w       #$4, a0                                       ; $007660
        move.b       $e(a2), (a0)                                  ; $007662
        addq.w       #$4, a0                                       ; $007666
        move.b       $10(a2), (a0)                                 ; $007668
        addq.w       #$4, a0                                       ; $00766C
        move.b       $11(a2), (a0)                                 ; $00766E
        addq.w       #$4, a0                                       ; $007672
        move.b       $13(a2), (a0)                                 ; $007674
        addq.w       #$4, a0                                       ; $007678
        move.b       $14(a2), (a0)                                 ; $00767A
        addq.w       #$4, a0                                       ; $00767E
        move.b       $16(a2), (a0)                                 ; $007680
        addq.w       #$4, a0                                       ; $007684
        move.b       $17(a2), (a0)                                 ; $007686
        addq.w       #$4, a0                                       ; $00768A
        move.b       $19(a2), (a0)                                 ; $00768C
        addq.w       #$4, a0                                       ; $007690
        move.b       $1a(a2), (a0)                                 ; $007692
        addq.w       #$4, a0                                       ; $007696
        move.b       $1c(a2), (a0)                                 ; $007698
        addq.w       #$4, a0                                       ; $00769C
        move.b       $1d(a2), (a0)                                 ; $00769E
        addq.w       #$4, a0                                       ; $0076A2
        move.b       $1f(a2), (a0)                                 ; $0076A4
        addq.w       #$4, a0                                       ; $0076A8
        lea.l        $2a(a5), a5                                   ; $0076AA
        movea.l      $8(a7), a3                                    ; $0076AE
        jmp          (a3)                                          ; $0076B2

loc_0076B4:
        movea.l      $4(a7), a3                                    ; $0076B4
        jsr          (a3)                                          ; $0076B8
        move.b       (a1), (a0)                                    ; $0076BA
        addq.w       #$4, a0                                       ; $0076BC
        move.b       $2(a1), (a0)                                  ; $0076BE
        addq.w       #$4, a0                                       ; $0076C2
        move.b       $3(a1), (a0)                                  ; $0076C4
        addq.w       #$4, a0                                       ; $0076C8
        move.b       $5(a1), (a0)                                  ; $0076CA
        addq.w       #$4, a0                                       ; $0076CE
        move.b       $6(a1), (a0)                                  ; $0076D0
        addq.w       #$4, a0                                       ; $0076D4
        move.b       $8(a1), (a0)                                  ; $0076D6
        addq.w       #$4, a0                                       ; $0076DA
        move.b       $9(a1), (a0)                                  ; $0076DC
        addq.w       #$4, a0                                       ; $0076E0
        move.b       $a(a1), (a0)                                  ; $0076E2
        addq.w       #$4, a0                                       ; $0076E6
        move.b       $c(a1), (a0)                                  ; $0076E8
        addq.w       #$4, a0                                       ; $0076EC
        move.b       $d(a1), (a0)                                  ; $0076EE
        addq.w       #$4, a0                                       ; $0076F2
        move.b       $f(a1), (a0)                                  ; $0076F4
        addq.w       #$4, a0                                       ; $0076F8
        move.b       $10(a1), (a0)                                 ; $0076FA
        addq.w       #$4, a0                                       ; $0076FE
        move.b       $12(a1), (a0)                                 ; $007700
        addq.w       #$4, a0                                       ; $007704
        move.b       $13(a1), (a0)                                 ; $007706
        addq.w       #$4, a0                                       ; $00770A
        move.b       $15(a1), (a0)                                 ; $00770C
        addq.w       #$4, a0                                       ; $007710
        move.b       $16(a1), (a0)                                 ; $007712
        addq.w       #$4, a0                                       ; $007716
        move.b       $18(a1), (a0)                                 ; $007718
        addq.w       #$4, a0                                       ; $00771C
        move.b       $19(a1), (a0)                                 ; $00771E
        addq.w       #$4, a0                                       ; $007722
        move.b       $1a(a1), (a0)                                 ; $007724
        addq.w       #$4, a0                                       ; $007728
        move.b       $1c(a1), (a0)                                 ; $00772A
        addq.w       #$4, a0                                       ; $00772E
        move.b       $1d(a1), (a0)                                 ; $007730
        addq.w       #$4, a0                                       ; $007734
        move.b       $1f(a1), (a0)                                 ; $007736
        addq.w       #$4, a0                                       ; $00773A
        move.b       (a2), (a0)                                    ; $00773C
        addq.w       #$4, a0                                       ; $00773E
        move.b       $2(a2), (a0)                                  ; $007740
        addq.w       #$4, a0                                       ; $007744
        move.b       $3(a2), (a0)                                  ; $007746
        addq.w       #$4, a0                                       ; $00774A
        move.b       $5(a2), (a0)                                  ; $00774C
        addq.w       #$4, a0                                       ; $007750
        move.b       $6(a2), (a0)                                  ; $007752
        addq.w       #$4, a0                                       ; $007756
        move.b       $8(a2), (a0)                                  ; $007758
        addq.w       #$4, a0                                       ; $00775C
        move.b       $9(a2), (a0)                                  ; $00775E
        addq.w       #$4, a0                                       ; $007762
        move.b       $a(a2), (a0)                                  ; $007764
        addq.w       #$4, a0                                       ; $007768
        move.b       $c(a2), (a0)                                  ; $00776A
        addq.w       #$4, a0                                       ; $00776E
        move.b       $d(a2), (a0)                                  ; $007770
        addq.w       #$4, a0                                       ; $007774
        move.b       $f(a2), (a0)                                  ; $007776
        addq.w       #$4, a0                                       ; $00777A
        move.b       $10(a2), (a0)                                 ; $00777C
        addq.w       #$4, a0                                       ; $007780
        move.b       $12(a2), (a0)                                 ; $007782
        addq.w       #$4, a0                                       ; $007786
        move.b       $13(a2), (a0)                                 ; $007788
        addq.w       #$4, a0                                       ; $00778C
        move.b       $15(a2), (a0)                                 ; $00778E
        addq.w       #$4, a0                                       ; $007792
        move.b       $16(a2), (a0)                                 ; $007794
        addq.w       #$4, a0                                       ; $007798
        move.b       $18(a2), (a0)                                 ; $00779A
        addq.w       #$4, a0                                       ; $00779E
        move.b       $19(a2), (a0)                                 ; $0077A0
        addq.w       #$4, a0                                       ; $0077A4
        move.b       $1a(a2), (a0)                                 ; $0077A6
        addq.w       #$4, a0                                       ; $0077AA
        move.b       $1c(a2), (a0)                                 ; $0077AC
        addq.w       #$4, a0                                       ; $0077B0
        move.b       $1d(a2), (a0)                                 ; $0077B2
        addq.w       #$4, a0                                       ; $0077B6
        move.b       $1f(a2), (a0)                                 ; $0077B8
        addq.w       #$4, a0                                       ; $0077BC
        lea.l        $2c(a5), a5                                   ; $0077BE
        movea.l      $8(a7), a3                                    ; $0077C2
        jmp          (a3)                                          ; $0077C6

loc_0077C8:
        movea.l      $4(a7), a3                                    ; $0077C8
        jsr          (a3)                                          ; $0077CC
        move.b       (a1), (a0)                                    ; $0077CE
        addq.w       #$4, a0                                       ; $0077D0
        addq.w       #$2, a1                                       ; $0077D2
        move.b       (a1)+, (a0)                                   ; $0077D4
        addq.w       #$4, a0                                       ; $0077D6
        move.b       (a1)+, (a0)                                   ; $0077D8
        addq.w       #$4, a0                                       ; $0077DA
        move.b       (a1), (a0)                                    ; $0077DC
        addq.w       #$2, a1                                       ; $0077DE
        addq.w       #$4, a0                                       ; $0077E0
        move.b       (a1)+, (a0)                                   ; $0077E2
        addq.w       #$4, a0                                       ; $0077E4
        move.b       (a1), (a0)                                    ; $0077E6
        addq.w       #$2, a1                                       ; $0077E8
        addq.w       #$4, a0                                       ; $0077EA
        move.b       (a1)+, (a0)                                   ; $0077EC
        addq.w       #$4, a0                                       ; $0077EE
        move.b       (a1)+, (a0)                                   ; $0077F0
        addq.w       #$4, a0                                       ; $0077F2
        move.b       (a1), (a0)                                    ; $0077F4
        addq.w       #$2, a1                                       ; $0077F6
        addq.w       #$4, a0                                       ; $0077F8
        move.b       (a1)+, (a0)                                   ; $0077FA
        addq.w       #$4, a0                                       ; $0077FC
        move.b       (a1), (a0)                                    ; $0077FE
        addq.w       #$2, a1                                       ; $007800
        addq.w       #$4, a0                                       ; $007802
        move.b       (a1)+, (a0)                                   ; $007804
        addq.w       #$4, a0                                       ; $007806
        move.b       (a1)+, (a0)                                   ; $007808
        addq.w       #$4, a0                                       ; $00780A
        move.b       (a1), (a0)                                    ; $00780C
        addq.w       #$2, a1                                       ; $00780E
        addq.w       #$4, a0                                       ; $007810
        move.b       (a1)+, (a0)                                   ; $007812
        addq.w       #$4, a0                                       ; $007814
        move.b       (a1)+, (a0)                                   ; $007816
        addq.w       #$4, a0                                       ; $007818
        move.b       (a1), (a0)                                    ; $00781A
        addq.w       #$2, a1                                       ; $00781C
        addq.w       #$4, a0                                       ; $00781E
        move.b       (a1)+, (a0)                                   ; $007820
        addq.w       #$4, a0                                       ; $007822
        move.b       (a1), (a0)                                    ; $007824
        addq.w       #$2, a1                                       ; $007826
        addq.w       #$4, a0                                       ; $007828
        move.b       (a1)+, (a0)                                   ; $00782A
        addq.w       #$4, a0                                       ; $00782C
        move.b       (a1)+, (a0)                                   ; $00782E
        addq.w       #$4, a0                                       ; $007830
        move.b       (a1), (a0)                                    ; $007832
        addq.w       #$2, a1                                       ; $007834
        addq.w       #$4, a0                                       ; $007836
        move.b       (a1)+, (a0)                                   ; $007838
        addq.w       #$4, a0                                       ; $00783A
        lea.l        -$20(a1), a1                                  ; $00783C
        move.b       (a2), (a0)                                    ; $007840
        addq.w       #$4, a0                                       ; $007842
        addq.w       #$2, a2                                       ; $007844
        move.b       (a2)+, (a0)                                   ; $007846
        addq.w       #$4, a0                                       ; $007848
        move.b       (a2)+, (a0)                                   ; $00784A
        addq.w       #$4, a0                                       ; $00784C
        move.b       (a2), (a0)                                    ; $00784E
        addq.w       #$2, a2                                       ; $007850
        addq.w       #$4, a0                                       ; $007852
        move.b       (a2)+, (a0)                                   ; $007854
        addq.w       #$4, a0                                       ; $007856
        move.b       (a2), (a0)                                    ; $007858
        addq.w       #$2, a2                                       ; $00785A
        addq.w       #$4, a0                                       ; $00785C
        move.b       (a2)+, (a0)                                   ; $00785E
        addq.w       #$4, a0                                       ; $007860
        move.b       (a2)+, (a0)                                   ; $007862
        addq.w       #$4, a0                                       ; $007864
        move.b       (a2), (a0)                                    ; $007866
        addq.w       #$2, a2                                       ; $007868
        addq.w       #$4, a0                                       ; $00786A
        move.b       (a2)+, (a0)                                   ; $00786C
        addq.w       #$4, a0                                       ; $00786E
        move.b       (a2), (a0)                                    ; $007870
        addq.w       #$2, a2                                       ; $007872
        addq.w       #$4, a0                                       ; $007874
        move.b       (a2)+, (a0)                                   ; $007876
        addq.w       #$4, a0                                       ; $007878
        move.b       (a2)+, (a0)                                   ; $00787A
        addq.w       #$4, a0                                       ; $00787C
        move.b       (a2), (a0)                                    ; $00787E
        addq.w       #$2, a2                                       ; $007880
        addq.w       #$4, a0                                       ; $007882
        move.b       (a2)+, (a0)                                   ; $007884
        addq.w       #$4, a0                                       ; $007886
        move.b       (a2)+, (a0)                                   ; $007888
        addq.w       #$4, a0                                       ; $00788A
        move.b       (a2), (a0)                                    ; $00788C
        addq.w       #$2, a2                                       ; $00788E
        addq.w       #$4, a0                                       ; $007890
        move.b       (a2)+, (a0)                                   ; $007892
        addq.w       #$4, a0                                       ; $007894
        move.b       (a2), (a0)                                    ; $007896
        addq.w       #$2, a2                                       ; $007898
        addq.w       #$4, a0                                       ; $00789A
        move.b       (a2)+, (a0)                                   ; $00789C
        addq.w       #$4, a0                                       ; $00789E
        move.b       (a2)+, (a0)                                   ; $0078A0
        addq.w       #$4, a0                                       ; $0078A2
        move.b       (a2), (a0)                                    ; $0078A4
        addq.w       #$2, a2                                       ; $0078A6
        addq.w       #$4, a0                                       ; $0078A8
        move.b       (a2)+, (a0)                                   ; $0078AA
        addq.w       #$4, a0                                       ; $0078AC
        lea.l        -$20(a2), a2                                  ; $0078AE
        lea.l        $2e(a5), a5                                   ; $0078B2
        movea.l      $8(a7), a3                                    ; $0078B6
        jmp          (a3)                                          ; $0078BA
        ifne *-$78BC
        fail "ROM end moved"
        endif
