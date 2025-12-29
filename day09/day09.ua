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

Part₁ ← ⊡¯1 ⍆ ≡(Area) ⧅<2 Data

&p $"Part 1: _" Part₁
