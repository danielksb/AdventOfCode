# Experimental!

Input ← (
  $ 0:
  $ ###
  $ ##.
  $ ##.
  $ 
  $ 1:
  $ ###
  $ ##.
  $ .##
  $ 
  $ 2:
  $ .##
  $ ###
  $ ##.
  $ 
  $ 3:
  $ ##.
  $ ###
  $ ##.
  $ 
  $ 4:
  $ ###
  $ #..
  $ ###
  $ 
  $ 5:
  $ ###
  $ .#.
  $ ###
  $ 
  $ 4x4: 0 0 0 0 2 0
  $ 12x5: 1 0 1 0 2 2
  $ 12x5: 1 0 1 0 3 2
)

Input ← &fras "input.txt"

~Region {Area Quantities}

SplitInput ← ⊜□ ⊸(¬⌕"\n\n")

ParseRegions ← (
  °□⊣
  ⊜□ ⊸≠@\n
  ≡(Region ⊙(⊜⋕ ⊸≠@ ) ⊂∩⋕ °$"_x_:_")
)

ParseShapes ← (
  ↘₋₁
  ≡(⌕ @# (⊜∘ ⊸≠@\n) ↘3 °□)
)

Shapes  ← ParseShapes SplitInput Input
Regions ← ParseRegions SplitInput Input

RegionsSizes ← ≡(/× Region~Area) Regions

MinSpace ← (
  ≡(/+/+) Shapes
  ≡Region~Quantities Regions
  ⍉
  ×
  /+
)

TooSmallRegions ← (
  RegionsSizes
  MinSpace
  ⊟
  ⍉
  ≡/<
)

BigEnoughRegions ← (
  RegionsSizes
  ≡Region~Quantities Regions
  /+⍉×9
  ⊟
  ⍉
  ≡/>
)

Part₁ ← (
  ¬TooSmallRegions
  BigEnoughRegions
  ↥
  /+
)

&p $"Part 1: _" Part₁
