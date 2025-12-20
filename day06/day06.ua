Input ← &fras "input.txt"
# Input ← "123 328  51 64\r\n45 64  387 23\r\n6 98  215 314\r\n*   +   *   + "

SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")
ParseRow      ← ⊜⋕ ⊸≠@ 
SeperateOps   ← ⊃(⊡¯1)(↘¯1)
ParseOps      ← (⊜∘ ⊸≠@ )
OpsToInt      ← ⨬(0|1)≠@+ # "+ *" -> [0 1]
ApplyOps      ← ⨬(/+|/×) °⊂

Part₁ ← (
  SplitNewLines Input
  SeperateOps
  ⊙(≡(ParseRow°□))
  ♭ OpsToInt ParseOps°□
  ⊂
  ⍉
  ≡(ApplyOps)
  /+
)

&p $"Part 1: _" Part₁
┌─╴test
  ⍤⤙≍ 33210 ApplyOps [1 123 45 6]
  ⍤⤙≍ 490 ApplyOps [0 328 64 98]
└─╴
