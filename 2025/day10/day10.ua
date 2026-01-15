# Experimental!
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
  ⊃(ParseJoltage°□⊡0↙₋₁)(ParseButtons ↘₋₁)
)

# indicator buttons -> next indicators
#
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
ApplyButtons₁ ← ≡(˜⍜⊏¬⊙°□)¤

# indicator buttons -> shortest paths
# {0_2_3_4 2_3 0_4 0_1_2 1_2_3_4}
# [0 0 0 1 0]
FindMinSteps₁ ← path(ApplyButtons₁⊙⋅∘)(≍) ⊸×0

Part₁ ← (
  Input
  SplitNewLines
  ≡(-1 ⧻ ⊢ FindMinSteps₁ ParseMachine₁ °□)
  /+
)

&p $"Part 1: _" Part₁

# Gives all combinations of 0 or 1 presses for given buttons.
#
# BoxedArrayOfButtons ? Buttons
ButtonCombos ← memo(
  ⊸(⬚0≡(⊥2) ⇡ ˜ⁿ2 ⧻) # all combinations of 0,1 for num of buttons
  ≡⌟(□▽)
  ↘₁ # remove no button presses
)

# RemainingJoltage ? Buttons RemainingJoltage
ApplyEachButton ← (
  ∧(◇⍜⊏(-1))
)

# Finds all button presses necessary to reach even joltage
# PressCounts EvenRemainingJoltages ? RemainingJoltage Buttons
FindEvenJoltages ← memo(
  ⤚(
    ⊙ButtonCombos
    ˜≡⌟(◇⊃(ApplyEachButton|⧻))
    ⊸≡(×⊃(/↧ ¬ ◿2)(/↧(≥0)))
    ⊃(▽ ⊙⋅∘)(▽ ⊙⊙◌)
  )             # PressCounts EvenRemainingJoltages OriginalJoltage ? OriginalJoltage Buttons
  ◡(⋅⋅(/↧ ¬◿2)) # if original joltage is already even
  ⨬(⊙⊙◌|⊂0 ⊙˜⊂) # then add the joltage to the results
)

# PressCount ? RemainingJoltage Buttons
FindMinSteps₂ ← |2 (
  ¬⊸(/↧=0) # did we already found the target?
  ⨬(0      # early abort returning 0 steps
  | (
      ⊸FindEvenJoltages # PressCounts RemainingJoltages Buttons ? RemainingJoltage Buttons
      ⊸(≠0⧻)            # check if paths were found
      ⨬(∞               # no paths, return infinite press counts
      | (
          ⊙⊙¤ # we need to fix the buttons to prevent iterating over it
          ≡(+ ⊙(×2 FindMinSteps₂ ÷2))
          ⊢⍆
          # ≡(□ ⊂ ⊙(×2 FindMinSteps₂ ÷2)) # debug
        )
      )
    )
  )
)

Part₂ ← (
  Input
  SplitNewLines
  wait≡(
    ParseMachine₂ °□
    poolFindMinSteps₂
  )
  /+
)

&p $"Part 2: _" Part₂
