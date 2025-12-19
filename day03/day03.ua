# Experimental!
Input ← &fras "input.txt"
# Input     ← "987654321111111\r\n818181911112111"
TokenMask ← ¬∊"\r\n"
Joltage   ← ≡≡(⋕) ⊜∘ ⊸TokenMask

# Converts array of digits to a number
# [1 2 3] -> 123
DigitsToNum ← /+×⇌⊸(≡(˜ⁿ10)⇡⧻)

AllCombinations ← ˜≡(□˜↘ °□) ⊙□ ↘¯1⇡⊸⧻

# Returns max voltage for a head of list
# [3 4 5 2] -> [35]
SingleMaxJoltage ← SplitInput⊂ ⊃(↙1)(⊣⍆↘1)

MaxJoltage ← ≡(SingleMaxJoltage °□)

Part₁ ← /+ ≡(⊣⍆ ≡MaxJoltage AllCombinations) Joltage Input

# Part₁

# bank n -> index of highest value
CutIndex ← (⊢⍖ ↙ +1 - ⊸⊙⧻:)

# index bank -> bank[index] bank[index:]
SplitBank ← ⊃(⊡|↘+1)

# bank n -> result bank[index:] n
JoltageCandidate ← (
  ◡(CutIndex)
  SplitBank
)

# init_results bank n -> results++ bank[index:] n-1
CollectCandidates ← (
  ⊂⊙JoltageCandidate
  ⊙⊙(-1)
)

# init_results bank n ->  result bank[index:] 0
# example stack:
# 2
# [8 1 8 1 8 1 9 1 1 1 1 2 1 1 1]
# []
MaxJoltageN ← (
  ⍢(CollectCandidates|⋅⋅(>₀))
)

RecursionPart₂ ← /+ ≡(SplitInput ⊙◌⊙◌ MaxJoltageN [] ⊙12) Joltage Input

Window ← ×0⇡

# bank window -> result
MaxJoltageByWindow ← ⊢∧(
  ⊸⊙(↘1
     ×10
     ˜⊂0
  )
  +
  ↥
)

WindowPart₂ ← /+ ≡(˜MaxJoltageByWindow Window 12) Joltage Input

&p WindowPart₂
