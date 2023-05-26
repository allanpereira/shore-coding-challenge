defmodule BowlingGame.Game do
  defstruct frames: []
end

defmodule BowlingGame.Frame do
  defstruct rolls: []
end

defmodule BowlingGame.Roll do
  defstruct pins: 0
end
