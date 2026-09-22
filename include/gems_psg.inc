; PSG RAM planes: each field is an array[4], IY=base+lane. See docs/GEMS_PSG.md.
zRamPsgEnvelopes                     equ $0009
psgEnvelopeCommand                   equ $00
psgEnvelopeLevel                     equ $04
psgEnvelopeAttackStep                equ $08
psgEnvelopeDecayStep                 equ $0C
psgEnvelopeSustainLevel              equ $10
psgEnvelopeReleaseStep               equ $14
psgEnvelopePhase                     equ $18
psgEnvelopeLatchValue                equ $1C
psgEnvelopePeriodHigh                equ $20
psgEnvelopeAttackTarget              equ $24
psgEnvelopeVolumeDirty               equ $28
; Patch fields relative to patch+1, excluding type.
psgPatchNoiseControl                 equ $00
psgPatchAttackStep                   equ $01
psgPatchSustainLevel                 equ $02
psgPatchAttackTarget                 equ $03
psgPatchDecayStep                    equ $04
psgPatchReleaseStep                  equ $05
