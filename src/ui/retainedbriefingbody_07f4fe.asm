; $07F4FE..$07F563 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Retained briefing implementation behind the original RTS. Six handlers; graphics/map/palette addresses in the page handlers point to code at $081C5C. See docs/TEXT.md.
        ifne *-$7F4FE
        fail "ROM start moved"
        endif

RetainedBriefingBody:
; Retained implementation after DisabledBriefingEntry RTS; do not mistake static decoding for normal reachability.
; Retained briefing implementation behind the original RTS. Six handlers; graphics/map/palette addresses in the page handlers point to code at $081C5C. See docs/TEXT.md.
        move.l       a6, -(a7)                                     ; $07F4FE
        move.l       a1, -(a7)                                     ; $07F500
        move.w       d0, -(a7)                                     ; $07F502
        jsr          ClearCram.l                                   ; $07F504
        jsr          ClearAllVram.l                                ; $07F50A
        jsr          InitializeMenuVdp.l                           ; $07F510
        movea.l      #VDP_CONTROL, a0                              ; $07F516
        cmpi.w       #$2100, ramLinkPortStatusShadow.l                             ; $07F51C
        bne.w        loc_07F530                                    ; $07F524
        move.w       #$8b0b, (a0)                                  ; $07F528
        bra.w        loc_07F534                                    ; $07F52C

loc_07F530:
        move.w       #$8b03, (a0)                                  ; $07F530

loc_07F534:
        move.w       #$9003, (a0)                                  ; $07F534
        jsr          DrawHorizontalGauge.l                         ; $07F538
        lea.l        CommonInterfaceCompressedTiles.l, a3          ; $07F53E
        move.w       #$4b0, d0                                     ; $07F544
        jsr          DecompressBytePairToVramLong.l                ; $07F548
        move.w       (a7)+, d0                                     ; $07F54E
        andi.l       #$ff, d0                                      ; $07F550
        lsl.w        #$2, d0                                       ; $07F556
        lea.l        RetainedBriefingHandlers.l, a0                ; $07F558
        adda.l       d0, a0                                        ; $07F55E
        movea.l      (a0), a0                                      ; $07F560
; Selector D0 low byte indexes 6-entry table; caller $000E02 can pass 0/1/2; other original calls pass 3 and 5. Entry currently disabled.
; D0 low byte selects one of six handlers without a bounds check. Call $000E02 can supply 0, 1 or 2; $000E36 supplies 3, $001A40 supplies 5. Public entry returns early.
        jmp          (a0)                                          ; $07F562
        ifne *-$7F564
        fail "ROM end moved"
        endif
