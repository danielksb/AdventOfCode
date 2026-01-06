# Experimental!

Input ← (
  $ 7 6 4 2 1
  $ 1 2 7 8 9
  $ 9 7 6 2 1
  $ 1 3 2 4 5
  $ 8 6 4 4 1
  $ 1 3 6 7 9
)

Input ← &fras "input.txt"

Parse ← ⊜(□ ⊜⋕ ⊸≠@ ) ⊸(¬∊"\r\n")

AllIncOrAllDec                 ← (∨ ⊃(≍ ⊸(⇌ ⇡ ⧻))(≍ ⊸(⇡ ⧻)) ⍏)
AllIncAtLeastOneDecAtMostThree ← (/× × ⊃(≥1|≤3) ⌵ ≡/- ⧈∘2)

Part₁ ← (
  Input
  Parse
  ≡(× ⊃(AllIncAtLeastOneDecAtMostThree)(AllIncOrAllDec) °□)
  /+
)

&p $"Part 1: _" Part₁

Candidates ← ≡⌟(⍜↻↘₁) ⊸(⇡ ⧻)

IsValid ← × ⊃(AllIncAtLeastOneDecAtMostThree)(AllIncOrAllDec)

Part₂ ← (
  Input
  Parse
  ≡(
    ⊸IsValid °□
    ⨬(/∨ ≡IsValid Candidates|1)
  )
  /+
)

&p $"Part 2: _" Part₂
