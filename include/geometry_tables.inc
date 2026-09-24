; July episode tables copied to work RAM. Cell indices and types are bytes.
CellTypeTableEntries equ $100
TextureDefinitionBytes equ $1000
TextureDefinitionEntryBytes equ $10
TextureOrderBytes equ $800
TextureOrderEntryBytes equ $8
TrainTextureFirstCellIndex equ $DA
TrainTextureOrderStart equ TrainTextureFirstCellIndex*TextureOrderEntryBytes
