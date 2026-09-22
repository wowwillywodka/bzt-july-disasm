; $02E8D4..$02EBDF | gems-sample-descriptors
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$2E8D4
        fail "ROM start moved"
        endif

GemsSampleDescriptors equ $02E8D4
GemsSampleDescriptor01 equ $02E8E0
GemsSampleDescriptor02 equ $02E8EC
GemsSampleDescriptor03 equ $02E8F8
GemsSampleDescriptor04 equ $02E904
GemsSampleDescriptor05 equ $02E910
GemsSampleDescriptor06 equ $02E91C
GemsSampleDescriptor07 equ $02E928
GemsSampleDescriptor08 equ $02E934
GemsSampleDescriptor09 equ $02E940
GemsSampleDescriptor10 equ $02E94C
GemsSampleDescriptor11 equ $02E958
GemsSampleDescriptor12 equ $02E964
GemsSampleDescriptor13 equ $02E970
GemsSampleDescriptor14 equ $02E97C
GemsSampleDescriptor15 equ $02E988
GemsSampleDescriptor16 equ $02E994
GemsSampleDescriptor17 equ $02E9A0
GemsSampleDescriptor18 equ $02E9AC
GemsSampleDescriptor19 equ $02E9B8
GemsSampleDescriptor20 equ $02E9C4
GemsSampleDescriptor21 equ $02E9D0
GemsSampleDescriptor22 equ $02E9DC
GemsSampleDescriptor23 equ $02E9E8
GemsSampleDescriptor24 equ $02E9F4
GemsSampleDescriptor25 equ $02EA00
GemsSampleDescriptor26 equ $02EA0C
GemsSampleDescriptor27 equ $02EA18
GemsSampleDescriptor28 equ $02EA24
GemsSampleDescriptor29 equ $02EA30
GemsSampleDescriptor30 equ $02EA3C
GemsSampleDescriptor31 equ $02EA48
GemsSampleDescriptor32 equ $02EA54
GemsSampleDescriptor33 equ $02EA60
GemsSampleDescriptor34 equ $02EA6C
GemsSampleDescriptor35 equ $02EA78
GemsSampleDescriptor36 equ $02EA84
GemsSampleDescriptor37 equ $02EA90
GemsSampleDescriptor38 equ $02EA9C
GemsSampleDescriptor39 equ $02EAA8
GemsSampleDescriptor40 equ $02EAB4
GemsSampleDescriptor41 equ $02EAC0
GemsSampleDescriptor42 equ $02EACC
GemsSampleDescriptor43 equ $02EAD8
GemsSampleDescriptor44 equ $02EAE4
GemsSampleDescriptor45 equ $02EAF0
GemsSampleDescriptor46 equ $02EAFC
GemsSampleDescriptor47 equ $02EB08
GemsSampleDescriptor48 equ $02EB14
GemsSampleDescriptor49 equ $02EB20
GemsSampleDescriptor50 equ $02EB2C
GemsSampleDescriptor51 equ $02EB38
GemsSampleDescriptor52 equ $02EB44
GemsSampleDescriptor53 equ $02EB50
GemsSampleDescriptor54 equ $02EB5C
GemsSampleDescriptor55 equ $02EB68
GemsSampleDescriptor56 equ $02EB74
GemsSampleDescriptor57 equ $02EB80
GemsSampleDescriptor58 equ $02EB8C
GemsSampleDescriptor59 equ $02EB98
GemsSampleDescriptor60 equ $02EBA4
GemsSampleDescriptor61 equ $02EBB0
GemsSampleDescriptor62 equ $02EBBC
GemsSampleDescriptor63 equ $02EBC8
GemsSampleDescriptor64 equ $02EBD4

        incbin "generated/data/02e8d4.bin"
        ifne *-$2EBE0
        fail "ROM end moved"
        endif
