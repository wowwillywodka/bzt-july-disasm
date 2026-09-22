; $01C76C..$01C771 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0/D1=point. GetVisibleMapBase always selects current FFA5FA window. No bounds/floor/Z check. Raw cell -> current type LUT -> collision class -> fractional diagonal test; D3.b=0 clear, nonzero blocked.
        ifne *-$1C76C
        fail "ROM start moved"
        endif

TestProjectilePointInActiveWindow:
; D0/D1=point. GetVisibleMapBase always selects current FFA5FA window. No bounds/floor/Z check. Raw cell -> current type LUT -> collision class -> fractional diagonal test; D3.b=0 clear, nonzero blocked.
        bsr.w        GetVisibleMapBase                             ; $01C76C
        bra.b        TestProjectilePointCommon                     ; $01C770
        ifne *-$1C772
        fail "ROM end moved"
        endif
