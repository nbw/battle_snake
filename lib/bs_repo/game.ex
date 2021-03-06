defmodule BsRepo.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bs_repo_game" do
    field(:delay, :integer, default: 300)
    field(:game_mode, :string, default: "multiplayer")
    field(:height, :integer, default: 20)
    field(:max_food, :integer, default: 1)
    field(:recv_timeout, :integer, default: 200)
    field(:snakes, {:array, :string})
    field(:width, :integer, default: 20)

    timestamps()
  end

  @required [:delay, :game_mode, :height, :max_food, :recv_timeout, :width]

  @permitted [:delay, :game_mode, :height, :max_food, :recv_timeout, :width]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @permitted)
    |> validate_inclusion(:game_mode, ["singleplayer", "multiplayer"])
    |> validate_number(:delay, greater_than_or_equal_to: 0)
    |> validate_number(:height, greater_than_or_equal_to: 2)
    |> validate_number(:max_food, greater_than_or_equal_to: 0)
    |> validate_number(:recv_timeout, greater_than_or_equal_to: 0)
    |> validate_number(:width, greater_than_or_equal_to: 2)
    |> validate_required(@required)
  end
end
