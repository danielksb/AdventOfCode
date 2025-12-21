# Experimental!
Input ← &fras "input.txt"
# Input ← &fras "test.txt"
# Input ← ".......|.......\r\n.......^......."

# space is zero, carets are ones, initial beam is also 1
Data ← ⊜(≠@.) ⊸(¬∊"\r\n") Input

# progress a beam if space is empty
# splitPos currentBeams -> nextBeam
Progress ← (
  ¬
  ×
)

# progress a beam if space has splitter
# splitPos currentBeams -> nextBeam
Split ← (
  ×
  ⊃(⬚0↻1|⬚0↻¯1)
  ∨
)

CountSplits ← (
  ×
  /+
)

# splitPos currentBeams numSplits   -> currentBeams numSplits
# 0
# [0 1 0 0 0 1 0 0 0 1 0 1 0 0 0]
# [0 0 0 0 0 1 0 1 0 1 0 1 0 0 0]
# -> [0 1 0 0 1 0 1 0 1 0 1 0 1 0 0] 3
Step ← (
  ⊃(CountSplits|Split|Progress)
  ⊙∨
  :
  ⊙+
)

Part₁ ← ◌∧Step °˜⊂ Data 0

&p $"Part 1: _" Part₁

┌─╴test
  ⍤⤙≍ [1 0 1] Split [0 1 0] [0 1 0]
  ⍤⤙≍ [0 0 0] Split [0 1 0] [0 0 0]
  ⍤⤙≍ [0 0 0] Split [0 0 0] [0 1 0]
  ⍤⤙≍ [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1] Split [0 1 0 1 0 1 0 1 0 1 0 0 0 1 0] [0 1 0 1 0 1 0 1 0 1 0 0 0 1 0]
  ⍤⤙≍ [0 1 0] Progress 0_0_0 0_1_0 # progress
  ⍤⤙≍ [0 0 0] Progress 0_1_0 0_1_0 # beam get split, so no progress
  ⍤⤙≍ [0 0 0 0 1 0 0 0 1 0 1 1 0 0 0] Progress [0 1 0 1 0 1 0 1 0 1 0 0 0 1 0] [0 1 0 1 1 1 0 1 1 0 1 1 0 1 0]
  #   ⍤⤙≍ {[0 1 0] 1} {Step [0 0 0] [0 1 0] 0} # step without split
  #   ⍤⤙≍ {[1 0 1] 0} {Step [0 1 0] [0 1 0] 0} # step with split
└─╴
