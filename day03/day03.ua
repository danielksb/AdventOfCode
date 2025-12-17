# Experimental!
Input ← &fras "day03/input.txt"
# Input     ← "987654321111111\r\n818181911112111"
TokenMask ← ¬∊"\r\n"
Joltage   ← ≡≡(⋕) ⊜∘ ⊸TokenMask

# Converts array of digits to a number
# [1 2 3] -> 123
DigitsToNum ← /+×⇌⊸(≡(˜ⁿ10)⇡⧻)

AllCombinations ← ˜≡(□˜↘ °□) ⊙□ ↘¯1⇡⊸⧻

# Returns max voltage for a head of list
# [3 4 5 2] -> [35]
SingleMaxJoltage ← DigitsToNum⊂ ⊃(↙1)(⊣⍆↘1)

MaxJoltage ← ≡(SingleMaxJoltage °□)

Part₁ ← /+ ≡(⊣⍆ ≡MaxJoltage AllCombinations) Joltage Input

Part₁
