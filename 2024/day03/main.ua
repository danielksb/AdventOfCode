Input ← (
  $ xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
)

Input ← (
  $ xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
)

Input ← &fras "input.txt"

EvalInstructs ← ⊜(⍣(⊙◌ × ∩⋕ °$"(_,_)_")0) ¬ ⊸⦷"mul"

Part₁ ← (
  Input
  EvalInstructs
  /+
)
&p $"Part 1: _" Part₁

Part₂ ← (
  Input
  ⊜□ ¬ ⊸⦷"do"                # partition by starting with "do"
  ▽ ⊸(¬ ≡(⍣(≍"n't" ↙₃ °□)0)) # remove all items starting with "don't"
  ≡(/+ ◇EvalInstructs)       # evaluate all instructions in all parts
  /+
)

&p $"Part 2: _" Part₂
