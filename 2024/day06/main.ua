# Experimental!

Input ← (
  $ ....#.....
  $ .........#
  $ ..........
  $ ..#.......
  $ .......#..
  $ ..........
  $ .#..^.....
  $ ........#.
  $ #.........
  $ ......#...
)
Input ← &fras "input.txt"

Board ← ⊜∘ ⊸(¬∊"\r\n") Input

# Returns a list of coordinates for a given symbol
# Coords ? Symbol Board
FindCoords ← ▽⊃(♭˜⌕)(♭₂⇡△)

StartPos ← ˜FindCoords @^

# did the guard left the board?
# Bool ? GuardPos Board
GuardLeftBoard ← (
  ↥⊃(/↥<0|/↥˜>⊙⧻)
)

# MarkedBoard ? Pos Board
MarkVisited ← ⍜⊡⋅@X
# MarkedBoard ? Pos Board
MarkGuard ← ⍜⊡⋅@^

# Generate next board state
# NewBoard ? Board
AdvanceGuard ← (
  ⊸StartPos
  ⊸(=0⧻) # check if start pos of guard can be found
  ⨬(⊡0
    ⟜MarkVisited
    -1_0 # get next pos
    ◡GuardLeftBoard
    ⨬(=@# ◡⊡                           # get next tile
      ⨬(MarkGuard|(⇌⍉) MarkGuard +1_0) # set back guard and rotate on collision
    | ⋅∘
    )
  | ⋅∘
  )
)

Part₁ ← (
  ⍢(AdvanceGuard) (>0 ⧻ StartPos) Board
  /+♭⌕ @X
)

Part₁
