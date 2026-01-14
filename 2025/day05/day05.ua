# Experimental!

Input ← &fras "input.txt"
# Input ← "3-5\r\n10-14\r\n16-20\r\n12-18\r\n\r\n1\r\n5\r\n8\r\n11\r\n17\r\n32"

# "a\r\nb" -> ["a"|"b"]
SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")

# input -> "ranges" "ids"
SplitInput ← °$"_\r\n\r\n_"

# "3-5" -> [3 5]
ParseRange ← ⊜⋕ ⊸≠@-

# range array -> result
# [3 5] [2 3 7] -> [0 1 0]
InRange ← ×⊓⌟≥≤°⊂

#  ranges ids
Data ← (
  ∩SplitNewLines SplitInput Input
  ⊓(≡(ParseRange °□)|⋕)
)

Part₁ ← (
  Data
  ⊸⊞InRange
  /∨
  ♭
  ▽
  ⧻
)

RangeLength ← (-⊙) °⊟

Part₂ ← (
  Data
  ⊙◌
  ⍆
  ≡(+0_1)
  ⍜♭\↥
  ≡RangeLength
  /+
)

&p $"Part 01: _" Part₁
&p $"Part 02: _" Part₂

┌─╴test
  ⍤⤙≍ [0 1 0] (InRange [3 5] [2 3 7])
  ⍤⤙≍ [3 5] ParseRange "3-5"
  ⍤⤙≍ 3 RangeLength [3 6]
  ⍤⤙≍ 0 RangeLength [5 5]
└─╴
