Input ← (
  $ 3   4
  $ 4   3
  $ 2   5
  $ 1   3
  $ 3   9
  $ 3   3
)

Parse ← ⊜(⊜⋕ ⊸≠@ ) ⊸(¬∊"\r\n")

Input ← &fras "input.txt"

Part₁ ← (
  Input
  Parse
  ⍜⍉≡⍆
  ≡(⌵/-)
  /+
)

&p $"Part 1: _" Part₁

Part₂ ← (
  Input
  Parse
  ⍜⍉(⍜°⊟(⟜(≡⌟(/+⌕))))
  ≡/×
  /+
)

&p $"Part 2: _" Part₂
