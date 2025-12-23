Input ← (
  $ 7,1
  $ 11,1
  $ 11,7
  $ 9,7
  $ 9,5
  $ 2,5
  $ 2,3
  $ 7,3
)
Input ← &fras "input.txt"
Data  ← ⊜(⊜⋕ ⊸(≠@,)) ⊸(¬∊"\r\n") Input

Area ← /×+1⌵/-

↙₋₁ ⍆ ≡(Area) ⧅<2 Data
