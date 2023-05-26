defmodule BowlingGame.ScoreCalculationTest do

  use ExUnit.Case, async: true

  def createFrame(rolls) do
    %BowlingGame.Frame {
      rolls: Enum.map(rolls, fn pins -> %BowlingGame.Roll { pins: pins } end)
    }
  end

  test "calculate score for a perfect game" do
    frames = for _i <- 1..12, do: createFrame([10])

    %BowlingGame.Game {
      frames: frames
    }
  end

  test "calculate score when every frame is a spare" do
    frames = Enum.chunk_every([5, 5, 3, 7, 6, 4, 2, 8, 1, 9, 8, 2, 5, 5, 4, 6, 7, 3, 9, 1, 5], 2)
      |> Enum.map(fn pins -> createFrame(pins) end)

    %BowlingGame.Game {
      frames: frames
    }
  end

  test "calculate score for a game with mixed cases" do
    frames = Enum.chunk_every([6, 2, 7, 2, 3, 4, 8, 2, 9, 0, 10, 10, 10, 6, 3], 2) ++ [8, 0, 7]

    %BowlingGame.Game {
      frames: frames
    }
  end

  test "calculate score when every roll misses the pins" do
    frames = for _i <- 1..10, do: createFrame([0, 0])

    %BowlingGame.Game {
      frames: frames
    }
  end
end
