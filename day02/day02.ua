Input ← $ 11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124

Input ← &fras "input.txt"

Parse ← ⊜(⊜⋕ ⊸≠@-) ⊸≠@,

Range ← ⊂+⇡◡-

Invalid₁ ← (
  °⋕
  ⊸⧻
  ⊸◿2
  ⨬(≍⊃(↙|↙ ¯)÷2|0)
)

# are all elements in array equal
AllEqual ← /× ≡(≍°⊟) ⧈∘2

# num -> array of divisors
Div ← ▽⤚(=0◿)⊸⇡
# num -> array of shapes to check for validity
Shapes ← ≡⌟(˜⊂⟜(⌊÷)) ⊸Div

Invalid₂ ← ⨬(/↥ ≡⌟(AllEqual ↯) Shapes|0)⊸=1 ⊸⧻ °⋕

┌─╴test
  ⍤⤙≍ 0 Invalid₁ 1
  ⍤⤙≍ 1 Invalid₁ 11
  ⍤⤙≍ 0 Invalid₁ 111
  ⍤⤙≍ 1 Invalid₁ 22
  ⍤⤙≍ 1 Invalid₁ 123123
  ⍤⤙≍ 0 Invalid₁ 123124
  ⍤⤙≍ [11 12 13 14 15] Range 11 15
  ⍤⤙≍ [1 2 5] Div 10
  ⍤⤙≍ [1 2 3 4 6] Div 12
  ⍤⤙≍ [] Div 1
  ⍤⤙≍ [1] Div 2
  ⍤⤙≍ [4_1 2_2] Shapes 4
  ⍤⤙≍ [2_1] Shapes 2
  ⍤⤙≍ 1 Invalid₂ 123123
  ⍤⤙≍ 0 Invalid₂ 123133
  ⍤⤙≍ 1 Invalid₂ 123123123
  ⍤⤙≍ 1 Invalid₂ 1212121212
  ⍤⤙≍ 1 Invalid₂ 1111111
  ⍤⤙≍ 0 Invalid₂ 9
  ⍤⤙≍ 0 Invalid₂ 10
  ⍤⤙≍ 1 Invalid₂ 11
└─╴

Part₁ ← /+ ≡(/+ ≡(×⊸Invalid₁) Range°⊟) Parse Input
&p $"Part 1: _" Part₁

Part₂ ← /+ ≡(/+ ≡(×⊸Invalid₂) Range°⊟) Parse Input
&p $"Part 2: _" Part₂
