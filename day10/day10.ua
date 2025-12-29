Input ← (
  $ [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
  $ [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
  $ [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
)
Input ← &fras "input.txt"

SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")

ParseIndicatorLights ← ⌕ @# °$"[_]"

ParseButtons ← (
  ≡(□ ⊜⋕ ⊸≠@, °$"(_)")
)

ParseJoltage ← ⊜⋕ ⊸≠@, °$"{_}"

# machineConfig -> indicators buttons
ParseMachine₁ ← (
  ⊜(□) ⊸≠@ 
  ↘₋₁
  °⊂
  ⊓(◇ParseIndicatorLights|ParseButtons)
)

ParseMachine₂ ← (
  ⊜(□) ⊸≠@ 
  ↘₁
  °⊂
  # ⊓(ParseButtons|ParseJoltage)
)

ParseMachine₂ ← (
  ⊜(□) ⊸≠@ 
  ↘₁
  ⊃(ParseJoltage°□⊡0↙₋₁)(ParseButtons ↘₋₁)
)

# indicator buttons -> next indicators
# 
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
ApplyButtons₁ ← ≡(˜⍜⊏¬⊙°□)¤

# ApplyButtons₂ ← ≡(˜⍜⊏(+1)⊙°□)¤
ApplyButtons₂ ← ?⊃(+1≤)((≡(˜⍜⊏(+1)⊙°□)¤)⊙⋅∘)

# indicator buttons -> shortest paths
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
FindMinSteps₁ ← path(ApplyButtons₁⊙⋅∘)(≍) ⊸×0

# TODO: this will not work, too many paths, lin alg solver needed
FindMinSteps₂ ← path(?ApplyButtons₂)(≍) ⊸×0

Part₁ ← (
  Input
  SplitNewLines
  ≡(-1 ⧻ ⊢ FindMinSteps₁ ParseMachine₁ °□)
  /+
)

&p $"Part 1: _" Part₁

Part₂ ← (
  Input
  SplitNewLines
  ≡(-1 ⧻ ⊢ ? FindMinSteps₂ ? ParseMachine₂ °□)
  /+
)

# &p $"Part 2: _" Part₂
