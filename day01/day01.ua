# Experimental!

Input ← (
  $ L68
  $ L30
  $ R48
  $ L5
  $ R60
  $ L55
  $ L1
  $ L99
  $ R14
  $ L82
)

Input ← &fras "input"

SplitNewLines ← ⊜□ ⊸(¬∊"\r\n")

Parse ← × ⊃(⨬(¯1|1) =@R⊡0|⋕ ↘₁)

Data ← ⊂50 ≡(Parse°□) SplitNewLines Input

CountZeroes ← /+ =0 ◿100 \+

Part₁ ← CountZeroes Data
Part₂ ← CountZeroes ▽ ⊃(⌵|±) Data

&p $"Part 1: _" Part₁
&p $"Part 2: _" Part₂

┌─╴test
  ⍤⤙≍ ¯12 Parse "L12"
  ⍤⤙≍ 12 Parse "R12"
└─╴
