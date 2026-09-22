; $01B136..$01B155 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Draw final corpse3/6 and arm Byte52=20/counter80 when Byte52==0. Preceding retained gate has no known ordinary entry; ordinary default corpse has its own live arm path.
        ifne *-$1B136
        fail "ROM start moved"
        endif

RetainedGunnerFinalCorpseAndArmExit:
; Draw final corpse3/6 and arm Byte52=20/counter80 when Byte52==0. Preceding retained gate has no known ordinary entry; ordinary default corpse has its own live arm path.
        move.w       #$3, d0                                       ; $01B136
        move.w       #$6, d2                                       ; $01B13A
        tst.b        ActorBehaviorByte52(a0)                       ; $01B13E
        bne.b        loc_01B150                                    ; $01B142
        move.b       #$14, ActorBehaviorByte52(a0)                 ; $01B144
        move.b       #$50, ActorStateCounter(a0)                   ; $01B14A

loc_01B150:
        jmp          DrawActorAnimation.l                          ; $01B150
        ifne *-$1B156
        fail "ROM end moved"
        endif
