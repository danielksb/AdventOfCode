Input ← (
  $ aaa: you hhh
  $ you: bbb ccc
  $ bbb: ddd eee
  $ ccc: ddd eee fff
  $ ddd: ggg
  $ eee: out
  $ fff: out
  $ ggg: out
  $ hhh: ccc fff iii
  $ iii: out
)

Input ← &fras "input.txt"

SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")
SplitSpace    ← ⊜∘ ⊸≠@ 

Key   ← ↙₃
Value ← □SplitSpace↘₅

# "aaa: you hhh eee"
Parse ← (
  ⊜□ ⊸≠@:
  °⊂
  ⊙(⍚SplitSpace ⊡0)
  ⊂
)

Part₁ ← (
  Input
  SplitNewLines
  ⊃≡(Key°□) ≡(Value°□)
  map

  path(0°□get)(≍"out") "you"
  ⊙◌
  ⧻
)

&p $"Part 1: _" Part₁
