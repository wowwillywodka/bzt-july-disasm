; Z80 reset program, ROM $0002C4..$0002E9.
; RAM destination $0000; initialize registers, then jump through HL.
        org 0
        xor a
        ld bc,0x1fd9
        ld de,0x27
        ld hl,0x26
        ld sp,hl
        ld (hl),a
        ldir
        pop ix
        pop iy
        ld i,a
        ld r,a
        pop de
        pop hl
        pop af
        ex af,af'
        exx
        pop bc
        pop de
        pop hl
        pop af
        ld sp,hl
        di
        im 1
        ld (hl),0xe9
        jp (hl)
