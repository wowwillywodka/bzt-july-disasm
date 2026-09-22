; $097920..$097963 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Tracked move tail. Estimated old cells=(finalXY-ActorMotionXY) ASR8. Absolute-short LEA $DECA.W SIGN-EXTENDS to $FFFFDECA (bus $FFDECA), NOT loaded ActorMarkerRecords at $FF5ECA. Searches count $FF5EC8 without zero guard; compares XY only, no kind/floor/origin. First match gets final cell bytes. Overwrites returned D0/D1.
        ifne *-$97920
        fail "ROM start moved"
        endif

UpdateTrackedActorMarkerAfterMove:
; Tracked move tail. Estimated old cells=(finalXY-ActorMotionXY) ASR8. Absolute-short LEA $DECA.W SIGN-EXTENDS to $FFFFDECA (bus $FFDECA), NOT loaded ActorMarkerRecords at $FF5ECA. Searches count $FF5EC8 without zero guard; compares XY only, no kind/floor/origin. First match gets final cell bytes. Overwrites returned D0/D1.
        clr.w        d0                                            ; $097920
        clr.w        d1                                            ; $097922
        move.w       ActorX(a0), d0                                ; $097924
        sub.w        ActorMotionX(a0), d0                          ; $097928
        move.w       ActorY(a0), d1                                ; $09792C
        sub.w        ActorMotionY(a0), d1                          ; $097930
; Raw opcode43F8 DECA: absolute-short sign extension points to RAM bus$FFDECA. Loader $9727C writes marker triples to$FF5ECA; do not silently repair this mismatch.
        lea.l        $FFFFDECA.w, a1                               ; $097934
        asr.w        #$8, d0                                       ; $097938
        asr.w        #$8, d1                                       ; $09793A
        move.w       rActorMarkerCount(a6), d7                     ; $09793C
; Count0 underflows D7.w to$FFFF and starts65536 candidates unless an XY match returns first. No capacity/pointer bound here.
        subq.w       #$1, d7                                       ; $097940

loc_097942:
; Matches only low bytes of estimated old cell X/Y; first record wins. Record kind byte not tested; no window-origin adjustment.
        cmp.b        $1(a1), d0                                    ; $097942
        bne.b        loc_09795C                                    ; $097946
        cmp.b        $2(a1), d1                                    ; $097948
        bne.b        loc_09795C                                    ; $09794C
; Writes high bytes of final ActorX/Y into selected triple; preserves kind byte. No D0/D1 save/restore.
        move.b       ActorCellX(a0), $1(a1)                        ; $09794E
        move.b       ActorCellY(a0), $2(a1)                        ; $097954
        rts                                                        ; $09795A

loc_09795C:
        addq.w       #$3, a1                                       ; $09795C
        dbra         d7, loc_097942                                ; $09795E
        rts                                                        ; $097962
        ifne *-$97964
        fail "ROM end moved"
        endif
