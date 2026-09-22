; Z80 legacy program, ROM $000718..$00073F.
; RAM destination $0000; initialize registers, then jump through HL.
        org 0
        xor a
        ld bc,0x1fd7
        ld de,0x29
        ld hl,0x28
        ld sp,hl
        ld (hl),a
        ldir
        pop ix
        pop iy
        ld i,a
        ld r,a
        ex af,af'
        exx
        pop af
        pop bc
        pop de
        pop hl
        ex af,af'
        exx
        pop af
        pop de
        pop hl
        ld sp,hl
        di
        im 1
        ld (hl),0xe9
        jp (hl)
