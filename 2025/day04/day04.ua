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
  Map
  RollsToRemove
  /⊂
  /+
)

Part₂ ← (
  Map
  ⊸⍥(>⊸RollsToRemove)∞
  >
  /⊂
  /+
)

Part₂
