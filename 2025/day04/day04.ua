Input ← &fras "input.txt"
# Input ← "..@@.@@@@.\r\n@@@.@.@.@@\r\n@@@@@.@.@@\r\n@.@@@@..@.\r\n@@.@@@@.@@\r\n.@@@@@@@.@\r\n.@.@.@.@@@\r\n@.@@@.@@@@\r\n.@@@@@@@@.\r\n@.@.@@@.@."

Map ← ⊜(=@@) ⊸(¬∊"\r\n") Input

Directions ← ⊂A₂C₂

WrappingNeighbors ← ↻Directions
Neighbors         ← ⬚0↻Directions
IsOneToThree      ← ×⊃(≥0)(<4)

RollsToRemove ← (
  ⊸Neighbors
  /+
  IsOneToThree
  ×
)

Part₁ ← (
  /+ ♭ RollsToRemove Map
)

Part₂ ← (
  Map
  ⊸⍥(>⊸RollsToRemove)∞
  >
  /+ ♭
)

&p $"Part 1: _" Part₁
&p $"Part 2: _" Part₂
