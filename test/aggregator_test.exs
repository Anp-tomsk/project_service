defmodule AggregatorTest do
  use ExUnit.Case
  alias ProjectService.{Aggregator, EventFactory}

  test "create project event no title aggregated" do
    event = EventFactory.add_project_event("Elixir")
    Aggregator.start_link(:user1)
    |> Aggregator.aggregate(event)
    |> fn result -> assert :ok = result end.()
  end

  test "create project event with same title should end with error" do
    event = EventFactory.add_project_event("Elixir")
    Aggregator.start_link(:user1)
    |> Aggregator.aggregate(event)

    :user1
    |> Aggregator.aggregate(event)
    |> fn result -> assert {:error, _reason} = result end.()
  end

  test "add note event no add to existing project" do
    event = EventFactory.add_project_event("Elixir")
    note =     EventFactory.add_note_event("Some note", "Elixir", "http://example.com")

    Aggregator.start_link(:user1)
    |> Aggregator.aggregate(event)

    :user1
    |> Aggregator.aggregate(note)
    |> fn result -> assert :ok = result end.()
  end

  test "add note event no project for given title error" do
    note = EventFactory.add_note_event("Some note", "Elixir", "http://example.com")

    Aggregator.start_link(:user1)
    |> Aggregator.aggregate(note)
    |> fn result -> assert {:error, _reason} = result end.()
  end
end
