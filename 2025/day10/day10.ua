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

# apply each button once ignoring overshoot
# RemainingJoltages ? Buttons RemainingJoltage
ApplyButtons₂ ← (
  ≡⌟(◇⍜⊏(-1))   # apply each buttons once
  ▽ ¬⊸(/↥ <0 ⍉) # keep only states not overshooting
)

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

# &p $"Part 1: _" Part₁

# {3 1_3 2 2_3 0_2 0_1}
# [3 5 0 7]

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

# check if joltage
# MinPressCount RemainingJoltage ? PressCounts RemainingJoltages
ReturnTarget ← (
  ⊙⊸(≡(/↧=0)) # get index of target joltage
  ⍣(
    ⊢⍆˜▽      # get min button preses
    ⊙(⍥0 ⊣ △) # return zero remaining joltage
  )(⋅⊙∘)
)

# Finds all button presses necessary to reach even joltage
# PressCounts EvenRemainingJoltages ? RemainingJoltage Buttons
FindEvenJoltages ← memo(
  ¬⊸(∨ ⊃(/↧ ¬ ◿2)(/↧(=0))) # 
  ⨬([0] [∘]|(
      ⊙ButtonCombos
      ˜≡⌟(◇⊃(ApplyEachButton|⧻))
      ⊸≡(×⊃(/↧ ¬ ◿2)(/↧(≥0)))
      ⊃(▽ ⊙⋅∘)(▽ ⊙⊙◌)
      ⨬([∞] ¤⍥(0)⊣△ ◌|⊙∘)⊸(≠0⧻) # if no paths were found, return infinity
    )
  )
)

# PressCounts NewRemainingJoltage ? RemainingJoltage Buttons
FindMinSteps₂ ← |2.2 (
  ¬⊸(/↧=0) # did we already found the target?
  ⨬(0 ∘    # early abort returning 0 steps
  | (
      ⊸FindEvenJoltages
      + ⊙≡⌟(×2 FindMinSteps₂ ÷2)
      ⊃(⊡ ⊙⊙◌|⊡ ⊙⋅∘) ⊸(⊢⍏)
    )
  )
)

Part₂ ← (
  Input
  SplitNewLines
  wait≡(
    ParseMachine₂ °□
    pool(⊙◌ FindMinSteps₂)
  )
  ⊸/+
)

# &p $"Part 2: _" Part₂

# Input
# SplitNewLines
# ⊡8
# ParseMachine₂ °□
# FindMinSteps₂
