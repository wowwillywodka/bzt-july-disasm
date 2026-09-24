; $07FC8A..$07FD6F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0 points to 37-byte rows (36 printable bytes + NUL), followed by an extra zero. Draws whole 8x16-character rows and scrolls one pixel; not a character-at-a-time typewriter.
        ifne *-$7FC8A
        fail "ROM start moved"
        endif

RunBriefingTextLoop:
; A0 points to 37-byte rows (36 printable bytes + NUL), followed by an extra zero. Draws whole 8x16-character rows and scrolls one pixel; not a character-at-a-time typewriter.
        move.l       a0, $ff2a48.l                                 ; $07FC8A
        moveq        #$0, d0                                       ; $07FC90
        jsr          ClearMenuTileRectangle.l                      ; $07FC92
        move.w       #$0, d0                                       ; $07FC98
        move.w       d0, $ff2a4e.l                                 ; $07FC9C
        jsr          WriteVerticalScrollToVsram.l                         ; $07FCA2

loc_07FCA8:
        move.w       #$3, d0                                       ; $07FCA8
        btst.b       #$0, ramControllerState.l                     ; $07FCAC
        beq.w        loc_07FCBC                                    ; $07FCB4
        move.w       #$0, d0                                       ; $07FCB8

loc_07FCBC:
        move.w       d0, -(a7)                                     ; $07FCBC
        jsr          WaitForVBlank.l                               ; $07FCBE
        movea.l      $6(a7), a1                                    ; $07FCC4
; Saved briefing A1 callback: 6(sp) = loop word + JSR return + caller saved A1. Ten callers in retained body.
        jsr          (a1)                                          ; $07FCC8
        move.w       (a7)+, d0                                     ; $07FCCA
        dbra         d0, loc_07FCBC                                ; $07FCCC

loc_07FCD0:
        jsr          ReadController.l                              ; $07FCD0
        btst.b       #$7, ramControllerState.l                     ; $07FCD6
        beq.w        loc_07FCF2                                    ; $07FCDE
        btst.b       #$7, ramPreviousControllerState.l             ; $07FCE2
        bne.w        loc_07FCF2                                    ; $07FCEA
        bra.w        loc_07FD6E                                    ; $07FCEE

loc_07FCF2:
        btst.b       #$1, ramControllerState.l                     ; $07FCF2
        bne.b        loc_07FCA8                                    ; $07FCFA
        btst.b       #$6, ramControllerState.l                     ; $07FCFC
        bne.b        loc_07FCA8                                    ; $07FD04
        move.w       $ff2a4e.l, d1                                 ; $07FD06
        move.w       d1, d0                                        ; $07FD0C
        andi.w       #$f, d1                                       ; $07FD0E
        bne.w        loc_07FD40                                    ; $07FD12
        andi.w       #$ff, d0                                      ; $07FD16
        lsl.w        #$5, d0                                       ; $07FD1A
        addq.w       #$4, d0                                       ; $07FD1C
        ori.w        #$c000, d0                                    ; $07FD1E
        movea.l      $ff2a48.l, a0                                 ; $07FD22
; Print both tile rows of one text line. The next record starts at the previous row pointer +$25, not strlen+1.
        jsr          PrintTextPlaneString.l                        ; $07FD28
        cmpi.b       #$0, (a0)                                     ; $07FD2E
        beq.w        loc_07FD56                                    ; $07FD32
        addi.l       #$25, $ff2a48.l                               ; $07FD36

loc_07FD40:
        move.w       #$0, d0                                       ; $07FD40

loc_07FD44:
        move.w       d0, -(a7)                                     ; $07FD44
        jsr          AdvanceRetainedBriefingScroll.l                                  ; $07FD46
        move.w       (a7)+, d0                                     ; $07FD4C
        dbra         d0, loc_07FD44                                ; $07FD4E
        bra.w        loc_07FCA8                                    ; $07FD52

loc_07FD56:
; A0 advanced past the final row NUL. If it equals BriefingScrollEnd, exit; otherwise start the shared 16-row blank tail.
        cmpa.l       #$81acf, a0                                   ; $07FD56
        beq.w        loc_07FD6E                                    ; $07FD5C
        move.l       #BriefingBlankScrollTail, $ff2a48.l           ; $07FD60
        bra.w        loc_07FCD0                                    ; $07FD6A

loc_07FD6E:
        rts                                                        ; $07FD6E
        ifne *-$7FD70
        fail "ROM end moved"
        endif
