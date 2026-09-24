; July software-viewport and projected-queue dimensions.
SoftwareFrameColumnCount equ $80
SoftwareFrameRowCount equ $50
SoftwareFrameColumnInterleave equ $4
SoftwareFrameColumnSpan equ SoftwareFrameRowCount*SoftwareFrameColumnInterleave
SoftwareFrameBytes equ SoftwareFrameColumnCount*SoftwareFrameRowCount
ScreenColumnDepthBytes equ SoftwareFrameColumnCount*2
SceneBackgroundColumnBytes equ $50
SceneBackgroundBytes equ SceneBackgroundColumnBytes*2
; For |Z| <= 32, |Z| + floor(|Z|/4) <= 40: each resampled half fits.
SceneBackgroundSafeViewOffsetZ equ $20
ProjectedActorHeapEntryBytes equ $8
ProjectedActorHeapEntryShift equ $3
ProjectedActorHeapCapacity equ ActorCapacity
ProjectedActorHeapEnd equ ramProjectedActorHeap+ProjectedActorHeapCapacity*ProjectedActorHeapEntryBytes
ProjectedWorldObjectEntryBytes equ $A
ProjectedWorldObjectCapacity equ $14
ProjectedWorldObjectQueueBytes equ ProjectedWorldObjectEntryBytes*ProjectedWorldObjectCapacity
