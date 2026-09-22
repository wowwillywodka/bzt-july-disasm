; $07ACE8..$07AE75 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Диспетчер GEMS-звукового события по коду D0: по таблице (тип 0..3) выбирает действие — фон, чередующиеся каналы $FF2A54/$2A56/$2A5A, позиционный SFX; проверяет флаги звука $FF0014
        ifne *-$7ACE8
        fail "ROM start moved"
        endif

PlaySoundEvent:
        move.l       a6, -(a7)                                     ; $07ACE8
        andi.l       #$ff, d0                                      ; $07ACEA
        move.w       d0, d1                                        ; $07ACF0
        lsl.w        #$1, d0                                       ; $07ACF2
        add.w        d1, d0                                        ; $07ACF4
        clr.l        d1                                            ; $07ACF6
        clr.l        d2                                            ; $07ACF8
        lea.l        SoundEventRecords(pc), a0                     ; $07ACFA
        move.b       (a0, d0.w), d1                                ; $07ACFE
        move.b       $2(a0, d0.w), d2                              ; $07AD02
        move.b       $1(a0, d0.w), d0                              ; $07AD06
        andi.w       #$ff, d0                                      ; $07AD0A
        cmpi.w       #$0, d1                                       ; $07AD0E
        beq.w        loc_07AD32                                    ; $07AD12
        cmpi.w       #$1, d1                                       ; $07AD16
        beq.w        loc_07AD54                                    ; $07AD1A
        cmpi.w       #$2, d1                                       ; $07AD1E
        beq.w        loc_07AE12                                    ; $07AD22
        cmpi.w       #$3, d1                                       ; $07AD26
        beq.w        loc_07AE4E                                    ; $07AD2A
        bra.w        loc_07AE72                                    ; $07AD2E

loc_07AD32:
        move.w       ramSoundOptions.l, d7                         ; $07AD32
        btst.l       #$0, d7                                       ; $07AD38
        beq.w        loc_07AE72                                    ; $07AD3C
        move.l       d0, -(a7)                                     ; $07AD40
        move.l       d2, -(a7)                                     ; $07AD42
        jsr          SoundRoutine_07A96C(pc)                       ; $07AD44
        addq.l       #$4, a7                                       ; $07AD48
        jsr          SoundRoutine_07A94E(pc)                       ; $07AD4A
        addq.l       #$4, a7                                       ; $07AD4E
        bra.w        loc_07AE72                                    ; $07AD50

loc_07AD54:
        move.w       ramSoundOptions.l, d7                         ; $07AD54
        btst.l       #$2, d7                                       ; $07AD5A
        beq.w        loc_07AE72                                    ; $07AD5E
        cmpi.w       #$d, $ff2a54.l                                ; $07AD62
        beq.b        loc_07ADAE                                    ; $07AD6A
        movem.l      d0/d2, -(a7)                                  ; $07AD6C
        move.l       $ff2a5a.l, -(a7)                              ; $07AD70
        bmi.b        loc_07AD84                                    ; $07AD76
        move.l       #$e, -(a7)                                    ; $07AD78
        jsr          loc_07A9D4(pc)                                ; $07AD7E
        addq.w       #$4, a7                                       ; $07AD82

loc_07AD84:
        addq.w       #$4, a7                                       ; $07AD84
        movem.l      (a7)+, d0/d2                                  ; $07AD86
        move.l       d2, $ff2a5a.l                                 ; $07AD8A
        move.l       d2, -(a7)                                     ; $07AD90
        move.l       d0, -(a7)                                     ; $07AD92
        move.l       #$e, -(a7)                                    ; $07AD94
        jsr          GemsSetChannelPatch(pc)                       ; $07AD9A
        addq.w       #$8, a7                                       ; $07AD9E
        move.l       #$e, -(a7)                                    ; $07ADA0
        jsr          SoundRoutine_07A9CC(pc)                       ; $07ADA6
        addq.w       #$8, a7                                       ; $07ADAA
        bra.b        loc_07ADEE                                    ; $07ADAC

loc_07ADAE:
        movem.l      d0/d2, -(a7)                                  ; $07ADAE
        move.l       $ff2a56.l, -(a7)                              ; $07ADB2
        bmi.b        loc_07ADC6                                    ; $07ADB8
        move.l       #$d, -(a7)                                    ; $07ADBA
        jsr          loc_07A9D4(pc)                                ; $07ADC0
        addq.w       #$4, a7                                       ; $07ADC4

loc_07ADC6:
        addq.w       #$4, a7                                       ; $07ADC6
        movem.l      (a7)+, d0/d2                                  ; $07ADC8
        move.l       d2, $ff2a56.l                                 ; $07ADCC
        move.l       d2, -(a7)                                     ; $07ADD2
        move.l       d0, -(a7)                                     ; $07ADD4
        move.l       #$d, -(a7)                                    ; $07ADD6
        jsr          GemsSetChannelPatch(pc)                       ; $07ADDC
        addq.w       #$8, a7                                       ; $07ADE0
        move.l       #$d, -(a7)                                    ; $07ADE2
        jsr          SoundRoutine_07A9CC(pc)                       ; $07ADE8
        addq.w       #$8, a7                                       ; $07ADEC

loc_07ADEE:
        move.w       $ff2a54.l, d0                                 ; $07ADEE
        cmpi.w       #$e, d0                                       ; $07ADF4
        bcs.w        loc_07AE08                                    ; $07ADF8
        move.w       #$d, $ff2a54.l                                ; $07ADFC
        bra.w        loc_07AE72                                    ; $07AE04

loc_07AE08:
        addq.w       #$1, $ff2a54.l                                ; $07AE08
        bra.w        loc_07AE72                                    ; $07AE0E

loc_07AE12:
        move.w       ramSoundOptions.l, d7                         ; $07AE12
        btst.l       #$3, d7                                       ; $07AE18
        beq.w        loc_07AE72                                    ; $07AE1C
        tst.w        $ff2a60.l                                     ; $07AE20
        bne.b        loc_07AE72                                    ; $07AE26
        tst.w        $ff2a62.l                                     ; $07AE28
        bne.b        loc_07AE72                                    ; $07AE2E
        move.l       d0, -(a7)                                     ; $07AE30
        move.l       #$f, -(a7)                                    ; $07AE32
        move.l       d2, -(a7)                                     ; $07AE38
        move.l       #$f, -(a7)                                    ; $07AE3A
        jsr          SoundRoutine_07AA8E(pc)                       ; $07AE40
        addq.w       #$8, a7                                       ; $07AE44
        jsr          SoundRoutine_07A9CC(pc)                       ; $07AE46
        addq.l       #$8, a7                                       ; $07AE4A
        bra.b        loc_07AE72                                    ; $07AE4C

loc_07AE4E:
        tst.w        $ff2a62.l                                     ; $07AE4E
        bne.b        loc_07AE72                                    ; $07AE54
        move.l       d0, -(a7)                                     ; $07AE56
        move.l       #$f, -(a7)                                    ; $07AE58
        move.l       d2, -(a7)                                     ; $07AE5E
        move.l       #$f, -(a7)                                    ; $07AE60
        jsr          SoundRoutine_07AA8E(pc)                       ; $07AE66
        addq.w       #$8, a7                                       ; $07AE6A
        jsr          SoundRoutine_07A9CC(pc)                       ; $07AE6C
        addq.l       #$8, a7                                       ; $07AE70

loc_07AE72:
        movea.l      (a7)+, a6                                     ; $07AE72
        rts                                                        ; $07AE74
        ifne *-$7AE76
        fail "ROM end moved"
        endif
