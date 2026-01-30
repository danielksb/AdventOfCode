Input ← (
  $ 190: 10 19
  $ 3267: 81 40 27
  $ 83: 17 5
  $ 156: 15 6
  $ 7290: 6 8 6 15
  $ 161011: 16 10 13
  $ 192: 17 8 14
  $ 21037: 9 7 18 13
  $ 292: 11 6 16 20
)
Input        ← &fras "input.txt"
Parse        ← ⊜(⊟∩□⊓⋕(⊜⋕ ⊸≠@ ) °$"_:_") ⊸≠@\n
Ops          ← ⬚0⊥₂ ⇡ ˜ⁿ2 -1 ⧻
Ops₂         ← ▽⊸(≡(/↥=2)) ⬚0⊥₃ ⇡ ˜ⁿ3 -1 ⧻
ApplyAllOps  ← ≡⌟(∧⨬×+ ⊙⊃↘₁⊢) ⊸Ops
Join         ← +×⊙⊸(˜ⁿ10⧻⊥10)
ApplyAllOps₂ ← ≡⌟(∧⨬(×|+|˜Join) ⊙⊃↘₁⊢) ⊸Ops₂
Valid        ← /↥∊⊙ApplyAllOps
Valid₂       ← /↥∊⊙ApplyAllOps₂
Part₁ ← (
  Parse Input
  /+≡(⨬0∘⤚Valid ∩°□°⊟)
)
SumUp ← /+≡(°□⊢)▽
Part₂ ← (
  Parse Input
  ⊃(SumUp|SumUp wait ⊸≡(poolValid₂ ∩°□°⊟) ▽¬) ⊸≡(Valid ∩°□°⊟)
  +
)
