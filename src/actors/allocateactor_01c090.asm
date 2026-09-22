; $01C090..$01C14F | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; ⭐АЛЛОКАТОР АКТЁРОВ July: пул @$FF123A (-0x6DC6), лимит 0x40 (-0x57C6), **СТРИД 0x58** (эволюция ZT 0x4C → June 0x56 → July 0x58), связный список; 5 слотов: +0xA/+0x12/+0x16/+0x1A(free=1C150)/+0x1E(hLinkSend), заглушка 1BEBC; +0x36 этаж; id +0x42=(адр−база)/0x58+1 [VERIFIED]
        ifne *-$1C090
        fail "ROM start moved"
        endif

AllocateActor:
; Out: A0=slot, D0=local ID, Z=0; full pool: A0=0, D0=0, Z=1. A1 may change.
        cmpi.w       #ActorCapacity, rActiveActorCount(a6)         ; $01C090
        bne.b        loc_01C0A2                                    ; $01C096
        movea.l      #$0, a0                                       ; $01C098
        clr.w        d0                                            ; $01C09E
        rts                                                        ; $01C0A0

loc_01C0A2:
        addq.w       #$1, rActiveActorCount(a6)                    ; $01C0A2
        lea.l        rActorPool(a6), a0                            ; $01C0A6
        tst.w        ActorFlags(a0)                                ; $01C0AA
        beq.b        loc_01C0F8                                    ; $01C0AE

loc_01C0B0:
        movea.l      a0, a1                                        ; $01C0B0
        adda.w       #ActorSize, a0                                ; $01C0B2
        tst.w        ActorFlags(a0)                                ; $01C0B6
        bne.b        loc_01C0B0                                    ; $01C0BA
; Splice ActorNext after the preceding occupied physical slot; preserve pool-address order.
        move.l       (a1), (a0)                                    ; $01C0BC
        move.l       a0, (a1)                                      ; $01C0BE
        move.l       #ActorNoOp, ActorUpdateCallback(a0)           ; $01C0C0
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C0C8
        move.l       #ActorNoOp, ActorLinkCallback(a0)             ; $01C0D0
        move.l       #RemoveActor, ActorExitCallback(a0)           ; $01C0D8
        move.l       #ActorNoOp, ActorDrawCallback(a0)             ; $01C0E0
; Partial initialization only: untouched coordinates, counters and type-specific bytes may be stale.
; Clear alternate-death byte on reused non-head slot. State/counter/marker bytes are not a full reset. No nonzero literal writer of byte34 found in decoded July instructions.
        clr.b        ActorAlternateDeathSignal(a0)                 ; $01C0E8
        clr.b        ActorUpdateDelay(a0)                          ; $01C0EC
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $01C0F0
        bra.b        loc_01C136                                    ; $01C0F6

loc_01C0F8:
        move.l       rActiveActorHead(a6), (a0)                    ; $01C0F8
        move.l       a0, rActiveActorHead(a6)                      ; $01C0FC
        move.l       #ActorNoOp, ActorUpdateCallback(a0)           ; $01C100
        move.l       #ActorNoOp, ActorHitCallback(a0)              ; $01C108
        move.l       #ActorNoOp, ActorLinkCallback(a0)             ; $01C110
        move.l       #RemoveActor, ActorExitCallback(a0)           ; $01C118
        move.l       #ActorNoOp, ActorDrawCallback(a0)             ; $01C120
; Head-slot allocation also clears alternate-death byte34. Both allocator paths suppress a stale legacy-death signal.
        clr.b        ActorAlternateDeathSignal(a0)                 ; $01C128
        clr.b        ActorUpdateDelay(a0)                          ; $01C12C
        move.b       rCurrentFloorLow(a6), ActorFloor(a0)          ; $01C130

loc_01C136:
; Local link ID = physical slot index + 1. Remote spawn overwrites it with the sender ID.
        move.l       a0, d0                                        ; $01C136
        subi.l       #$ff123a, d0                                  ; $01C138
        divu.w       #ActorSize, d0                                ; $01C13E
        addq.b       #$1, d0                                       ; $01C142
        move.b       d0, ActorLinkId(a0)                           ; $01C144
        move.w       #$1, ActorFlags(a0)                           ; $01C148
        rts                                                        ; $01C14E
        ifne *-$1C150
        fail "ROM end moved"
        endif
