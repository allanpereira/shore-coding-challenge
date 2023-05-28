defmodule BowlingGame.ScoreCalculationTest do

  use ExUnit.Case, async: true

  def create_frame(rolls) do
    %BowlingGame.Frame {
      pins_per_roll: rolls
    }
  end

  def create_game_with_frames(frames) do
    %BowlingGame.Game {
      frames: frames
    }
  end

  test "calculate score for a perfect game" do
    game = create_game_with_frames([
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 10, 10])
    ])

    score = BowlingGame.calculate_score(game)

    assert score == 300
  end

  test "calculate score when every frame is a spare" do
    game = create_game_with_frames([
      create_frame([5, 5]),
      create_frame([3, 7]),
      create_frame([6, 4]),
      create_frame([2, 8]),
      create_frame([1, 9]),
      create_frame([8, 2]),
      create_frame([5, 5]),
      create_frame([4, 6]),
      create_frame([7, 3]),
      create_frame([9, 1, 5])
    ])

    score = BowlingGame.calculate_score(game)

    assert score == 150
  end

  test "calculate score for a game with mixed cases" do
    game = create_game_with_frames([
      create_frame([6, 2]),
      create_frame([7, 2]),
      create_frame([3, 4]),
      create_frame([8, 2]),
      create_frame([9, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([10, 0]),
      create_frame([6, 3]),
      create_frame([8, 0, 0])
    ])

    score = BowlingGame.calculate_score(game)

    assert score == 144
  end

  test "calculate score when every roll misses the pins" do
    frames = for _i <- 1..10, do: create_frame([0, 0])

    game = create_game_with_frames(frames)
    score = BowlingGame.calculate_score(game)

    assert score == 0
  end
end
