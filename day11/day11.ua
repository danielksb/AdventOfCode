Input₁ ← (
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

Input₂ ← (
  $ svr: aaa bbb
  $ aaa: fft
  $ fft: ccc
  $ bbb: tty
  $ tty: ccc
  $ ccc: ddd eee
  $ ddd: hub
  $ hub: fff
  $ eee: dac
  $ dac: fff
  $ fff: ggg hhh
  $ ggg: out
  $ hhh: out
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

Data ← (
  SplitNewLines
  ⊃≡(Key°□) ≡(Value°□)
  map
)

Map ← Data Input

Paths ← (
  path(0 °□ ˜⬚[]get Map)(≍)
  ⊙◌
  ⧻
)

Part₁ ← Paths "you" "out"

&p $"Part 1: _" Part₁

Paths₂ ← |2 (
  ◡≍
  # ⨬(⨬(0|(/+≡⌟(Paths₂) (°□ ˜get Map))) ⊸(˜has Map)|1)
  ⨬(⍣(memo(/+≡⌟Paths₂) (°□ ˜get Map))0|1)
)

CombinedPaths ← (
  ⧈(∘) 2
  ≡(Paths°⊟)
  /×
)

Part₂ ← (
  CombinedPaths ["svr" "fft" "dac" "out"] # 307608674109300
  CombinedPaths ["svr" "dac" "fft" "out"] # 0
  +
)

&p $"Part 2: _" Part₂
