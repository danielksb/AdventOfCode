# Experimental!

Input₁ ← (
  $ 1abc2
  $ pqr3stu8vwx
  $ a1b2c3d4e5f
  $ treb7uchet
)

Input₂ ← (
  $ two1nine
  $ eightwothree
  $ abcone2threexyz
  $ xtwone3four
  $ 4nineeightseven2
  $ zoneight234
  $ 7pqrstsixteen
)
Input ← &fras "input.txt"

Digits ← {"zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"}
Solve₁ ← ⌝⊥10 ⊟ ⊃⊣⊢ ▽ ⊸≤9 -@0

# xxbbcc ? xx aa aabbcc
ReplaceStr ← ⍜⊜∘≡⋅∘ ⊃(⊸⦷◌)(⊙⋅◌)

Part₁ ← /+ ⊜Solve₁ ⊸≠@\n

# Extract words from input row as array of [index digit]
Words ← (
  ≡⌟(⌕°□) Digits
  ⇌⍉⊚
)
# Extract numbers from input row as array of [index digit]
Nums ← ⊟⊃⊚▽ ⊸≤9 -@0

Solve₂ ← (
  ⊃Words Nums
  ⊂ ∩⍉
  ⍆
  ⊂∩⊣⊃⊣⊢
  ⌝⊥10
)

Part₂ ← /+ ⊜Solve₂ ⊸≠@\n

&p $"Part 1: _ / Part 2: _" ⊃Part₁ Part₂ Input
