; $01BEBE..$01BFCD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Project eligible actors into an 8-byte min-heap (scale, screen X, actor),
; then merge its root with the back of the 10-byte world-object queue.
; Actor draw ABI: A0=actor, D5=scale, D1=screen X. See docs/ACTOR_RENDER_QUEUE.md.
        ifne *-$1BEBE
        fail "ROM start moved"
        endif

ProjectAndDrawActors:
; No-actor path skips heap-count reset; the original ROM keeps this behavior.
; Callback ABI after projection: A0=actor, D5.w=scale (capped at $12C),
; D1.w=screen X. A6 is RAM base. D0/D2 animation selectors are supplied
; by each draw handler, not by this queue; draw may mutate the actor.
        move.w       rActiveActorCount(a6), d7                     ; $01BEBE
        bne.b        loc_01BEC8                                    ; $01BEC2
        bra.w        loc_01BF4A                                    ; $01BEC4

loc_01BEC8:
        subq.w       #$1, d7                                       ; $01BEC8
        clr.w        rProjectedActorHeapCount(a6)                                    ; $01BECA
        movea.l      rActiveActorHead(a6), a0                      ; $01BECE

loc_01BED2:
        move.b       ActorFloor(a0), d4                            ; $01BED2
        cmp.b        rCurrentFloorLow(a6), d4                      ; $01BED6
        bne.b        loc_01BF44                                    ; $01BEDA
        move.w       ActorX(a0), d4                                ; $01BEDC
        sub.w        rPlayerX(a6), d4                              ; $01BEE0
        move.w       d4, d0                                        ; $01BEE4
        move.w       d4, d5                                        ; $01BEE6
        muls.w       rPlayerFacingVectorX(a6), d4                                ; $01BEE8
        move.w       ActorY(a0), d3                                ; $01BEEC
        sub.w        rPlayerY(a6), d3                              ; $01BEF0
        move.w       d3, d1                                        ; $01BEF4
        jsr          OctagonalDistance.l                           ; $01BEF6
        cmpi.w       #$c00, d0                                     ; $01BEFC
        bhi.b        loc_01BF44                                    ; $01BF00
        move.w       d3, d6                                        ; $01BF02
        muls.w       rPlayerFacingVectorY(a6), d3                                ; $01BF04
        add.l        d3, d4                                        ; $01BF08
        muls.w       rPlayerFacingVectorX(a6), d6                                ; $01BF0A
        muls.w       rPlayerFacingVectorY(a6), d5                                ; $01BF0E
        sub.l        d5, d6                                        ; $01BF12
        asr.l        #$6, d4                                       ; $01BF14
        cmpi.l       #$2, d4                                       ; $01BF16
        blt.b        loc_01BF44                                    ; $01BF1C
        divs.w       d4, d6                                        ; $01BF1E
        bvs.b        loc_01BF44                                    ; $01BF20
        addi.w       #$40, d6                                      ; $01BF22
        move.l       #$10000, d5                                   ; $01BF26
        divs.w       d4, d5                                        ; $01BF2C
        bvs.b        loc_01BF44                                    ; $01BF2E
        cmpi.w       #$12c, d5                                     ; $01BF30
        bls.b        loc_01BF3A                                    ; $01BF34
        move.w       #$12c, d5                                     ; $01BF36

loc_01BF3A:
; Reserve a heap slot, then commit the projected record there.
        bsr.w        ReserveProjectedActorHeapSlot                        ; $01BF3A
        move.w       d5, (a2)+                                     ; $01BF3E
        move.w       d6, (a2)+                                     ; $01BF40
        move.l       a0, (a2)+                                     ; $01BF42

loc_01BF44:
        movea.l      (a0), a0                                      ; $01BF44
        dbra         d7, loc_01BED2                                ; $01BF46

loc_01BF4A:
; A3 is the one-past-last object record; object drawing pops 10 bytes.
        movea.l      rProjectedWorldObjectQueueEnd(a6), a3                                ; $01BF4A
        cmpa.l       #ramProjectedWorldObjectQueue, a3                                  ; $01BF4E
        beq.b        loc_01BF98                                    ; $01BF54
        tst.w        rProjectedActorHeapCount(a6)                                    ; $01BF56
        beq.b        loc_01BFBE                                    ; $01BF5A

loc_01BF5C:
        move.w       rProjectedActorHeapRootScale(a6), d5                                ; $01BF5C
        cmp.w        -$4(a3), d5                                   ; $01BF60
        blt.b        loc_01BF76                                    ; $01BF64
        jsr          DispatchWorldObjectDrawing.l                  ; $01BF66
        cmpa.l       #ramProjectedWorldObjectQueue, a3                                  ; $01BF6C
        bne.b        loc_01BF5C                                    ; $01BF72
        bra.b        loc_01BFA0                                    ; $01BF74

loc_01BF76:
; Smaller projected scale sorts first (farther actor). The world-object
; queue is consumed in reverse producer order; it is not heap-sorted here.
        move.w       rProjectedActorHeapRootScale(a6), d5                                ; $01BF76
        move.w       rProjectedActorHeapRootScreenX(a6), d1                                ; $01BF7A
        movea.l      rProjectedActorHeapRootActor(a6), a0                                ; $01BF7E
        movea.l      ActorDrawCallback(a0), a1                     ; $01BF82
; Preserve only the world-object cursor here. No general register save ABI.
        move.l       a3, -(a7)                                     ; $01BF86
        jsr          (a1)                                          ; $01BF88
        movea.l      (a7)+, a3                                     ; $01BF8A
        bsr.w        PopProjectedActorHeapRoot                        ; $01BF8C
        tst.w        rProjectedActorHeapCount(a6)                                    ; $01BF90
        bne.b        loc_01BF5C                                    ; $01BF94
        bra.b        loc_01BFBE                                    ; $01BF96

loc_01BF98:
        tst.w        rProjectedActorHeapCount(a6)                                    ; $01BF98
        bne.b        loc_01BFA0                                    ; $01BF9C
        rts                                                        ; $01BF9E

loc_01BFA0:
        move.w       rProjectedActorHeapRootScale(a6), d5                                ; $01BFA0
        move.w       rProjectedActorHeapRootScreenX(a6), d1                                ; $01BFA4
        movea.l      rProjectedActorHeapRootActor(a6), a0                                ; $01BFA8
        movea.l      ActorDrawCallback(a0), a1                     ; $01BFAC
        jsr          (a1)                                          ; $01BFB0
        bsr.w        PopProjectedActorHeapRoot                        ; $01BFB2
        tst.w        rProjectedActorHeapCount(a6)                                    ; $01BFB6
        bne.b        loc_01BFA0                                    ; $01BFBA
        rts                                                        ; $01BFBC

loc_01BFBE:
        jsr          DispatchWorldObjectDrawing.l                  ; $01BFBE
        cmpa.l       #ramProjectedWorldObjectQueue, a3                                  ; $01BFC4
        bne.b        loc_01BFBE                                    ; $01BFCA
        rts                                                        ; $01BFCC
        ifne *-$1BFCE
        fail "ROM end moved"
        endif
