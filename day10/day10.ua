Input ← (
  $ [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
  $ [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
  $ [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
)
Input ← &fras "input.txt"
MachineConfig ← (
  $ [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
)

SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")

ParseIndicatorLights ← ⌕ @# °$"[_]"

ParseButtons ← (
  ≡(□ ⊜⋕ ⊸≠@, °$"(_)")
)

# machineConfig -> indicators buttons
ParseMachine₁ ← (
  ⊜(□) ⊸≠@ 
  ↘₋₁
  °⊂
  ⊓(◇ParseIndicatorLights|ParseButtons)
)

# indicator buttons -> next indicators
# 
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
ApplyButtons ← ≡(˜⍜⊏¬⊙°□)¤

# indicator buttons -> shortest paths
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
FindMinSteps ← path(ApplyButtons⊙⋅∘)(≍) ⊸×0

Part₁ ← (
  Input
  SplitNewLines
  ≡(-1 ⧻ ⊢ FindMinSteps ParseMachine₁ °□)
  /+
)

&p $"Part 1: _" Part₁
