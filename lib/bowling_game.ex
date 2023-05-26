defmodule BowlingGame do
  @moduledoc """
  BowlingGame keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def calculate_score(game) do
    game.frames
    |> Enum.with_index
    |> Enum.reduce(0, fn {frame, index}, acc ->
      acc + calculate_score_for_frame(index, frame, game, acc)
    end)
  end

  def calculate_score_for_frame(index, frame, game, acc) do
    is_strike = hd(frame.pins_per_roll) == 10
    is_spare = Enum.at(frame.pins_per_roll, 0) + Enum.at(frame.pins_per_roll, 1, 0) == 10

    cond do
      is_strike -> 10 + bonus_strike(index, game.frames)
      is_spare -> 10 + bonus_spare(index, game.frames)
      true -> hd(frame.pins_per_roll) + hd(tl(frame.pins_per_roll))
    end
  end

  def bonus_strike(frame_index, frames) do
    { first_roll, second_roll } = find_next_rolls(frame_index, frames)
    (first_roll || 0) + (second_roll || 0)
  end

  def bonus_spare(frame_index, frames) do
    next_frame = Enum.at(frames, frame_index + 1, %BowlingGame.Frame {
      pins_per_roll: [0]
    })

    hd(next_frame.pins_per_roll)
  end

  def find_next_rolls(frame_index, frames) do
    is_frame_the_last = frame_index >= length(frames) - 1

    if is_frame_the_last, do: { nil, nil }, else: find_next_rolls_from_frame(frame_index + 1, frames)
  end

  def find_next_rolls_from_frame(frame_index, frames) do
    frame = Enum.at(frames, frame_index)

    first_roll = get_first_roll_of_frame(frame_index, frames)
    first_roll_is_strike = first_roll == 10

    second_roll = if first_roll_is_strike, do: get_first_roll_of_frame(frame_index + 1, frames), else: Enum.at(frame.pins_per_roll, 1)

    {first_roll, second_roll}
  end

  def get_first_roll_of_frame(frame_index, frames) do
    is_frame_the_last = frame_index >= length(frames) - 1

    if is_frame_the_last, do: nil, else: hd(Enum.at(frames, frame_index).pins_per_roll)
  end

  def find_next_frame(frame_index, frames) do
    if frame_index >= length(frames) - 1, do: nil, else: Enum.at(frames, frame_index + 1)
  end
end
