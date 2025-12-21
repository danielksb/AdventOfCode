Input ← &fras "input.txt"
# Input ← &fras "test.txt"
# Input ← "123 328  51 64 \r\n 45 64  387 23 \r\n  6 98  215 314\r\n*   +   *   +  "

SplitNewLines ← ⊜∘ ⊸(¬∊"\r\n")
ParseRow      ← ⊜⋕ ⊸≠@ 
SeperateOps   ← ⊃(⊡¯1)(↘¯1)
ParseOps      ← (⊜∘ ⊸≠@ )
OpsToInt      ← ⨬(0|1)≠@+ # "+ *" -> [0 1]
ApplyOps      ← ⨬(/+|/×) °⊂

Part₁ ← (
  SplitNewLines Input
  ♭ OpsToInt ParseOps SeperateOps
  ⊙(≡(ParseRow))
  ⊂
  ⍉
  ≡(ApplyOps)
  /+
)

&p $"Part 1: _" Part₁

RemoveWhitespaces ← ▽⊸≠@ 
RemoveNaN         ← ▽⊸≠NaN

Part₂ ← (
  SplitNewLines Input
  ♭ OpsToInt ParseOps°□ SeperateOps
  :
  ⍉
  # trim whitespaces and parse to number
  # fields with whitespaces only become 0
  ≡(⍣(⋕/(⍚⊂))0 ≡(□ ▽⊸≠@ ))
  # partition at zeroes fill up with NaN
  ⬚NaN⊜∘ ⊸≠0
  ⍉
  :
  ⊂
  ⍉
  ≡(ApplyOps RemoveNaN)
  /+
)

&p $"Part 2: _" Part₂

┌─╴test
  ⍤⤙≍ 33210 ApplyOps [1 123 45 6]
  ⍤⤙≍ 490 ApplyOps [0 328 64 98]
└─╴
