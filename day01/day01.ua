Input ← &fras "input"
# Input      ← "R12\r\nL2"
TokenMask  ← ¬∊"\r\n"
Operations ← ⊜□ ⊸TokenMask

# Extract the turn direction from an operation
# e.g. "R12" -> -1, "L2" -> 1
Direction ← -(≠@R)⟜(=@R)⊡0

# Extract rotation steps from an operation
# e.g. "R12" -> 12, "L2" -> 2
Rotation ← ⋕↘1

Directions ← ≡(Direction°□) Operations Input
Rotations  ← ≡(Rotation°□) Operations Input

# Expand the directions and rotations into step-by-step movements
Expand ← □⍥(⊂):[]

# Unboxes expanded values into a flat array
Flatten ← ⇌ ˜∧(⊂°□)[]

&p "ZeroesPart 1: " /+ =0 ◿100 \+ ⊂50 ×Rotations Directions

&p "ZeroesPart 2: " /+ =0 ◿100 \+ ⊂50 Flatten ≡/Expand ⍉ ⊟Rotations Directions
