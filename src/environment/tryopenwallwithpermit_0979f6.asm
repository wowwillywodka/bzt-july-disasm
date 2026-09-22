; $0979F6..$097A3F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; WallOpeningPermit must equal 1; type $86/$87 queues permanent opening and consumes permit even if the queue was full. This is a RAM flag, not an inventory quantity. No such cells occur in the active ROM grids.
        ifne *-$979F6
        fail "ROM start moved"
        endif

TryOpenWallWithPermit:
; WallOpeningPermit must equal 1; type $86/$87 queues permanent opening and consumes permit even if the queue was full. This is a RAM flag, not an inventory quantity. No such cells occur in the active ROM grids.
        cmpi.w       #$1, rWallOpeningPermit(a6)                   ; $0979F6
        beq.b        loc_097A04                                    ; $0979FC
        move.w       #$0, d0                                       ; $0979FE
        rts                                                        ; $097A02

loc_097A04:
; Coordinates here are unscaled local cell X/Y, unlike the charge caller fixed-point inputs. Mode 2 does not use them for occupancy checks.
        move.l       a0, d0                                        ; $097A04
        subi.l       #$ffa5fa, d0                                  ; $097A06
        move.w       d0, d1                                        ; $097A0C
        andi.w       #$1f, d0                                      ; $097A0E
        lsr.w        #$5, d1                                       ; $097A12
        cmpi.b       #$86, d2                                      ; $097A14
        bne.b        loc_097A22                                    ; $097A18
        jsr          QueuePermanentWallOpeningType2D.l             ; $097A1A
        bra.b        loc_097A34                                    ; $097A20

loc_097A22:
        cmpi.b       #$87, d2                                      ; $097A22
        beq.b        loc_097A2E                                    ; $097A26
        move.w       #$0, d0                                       ; $097A28
        rts                                                        ; $097A2C

loc_097A2E:
        jsr          QueuePermanentWallOpeningType2E.l             ; $097A2E

loc_097A34:
        move.w       #$0, rWallOpeningPermit(a6)                   ; $097A34
        move.w       #$1, d0                                       ; $097A3A
        rts                                                        ; $097A3E
        ifne *-$97A40
        fail "ROM end moved"
        endif
