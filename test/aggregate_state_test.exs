defmodule AggregateStateTest do
  use ExUnit.Case
  alias ProjectService.{AggregateState, ProjectCreated, EventFactory}

  test "update aggregate state add project" do
    evt = %ProjectCreated{id: 1, title: "Elixir project", stamp: 1}
    state = %AggregateState{}
            |> AggregateState.add_project(evt)

    assert %{"Elixir project" => ^evt} = state.projects
  end

  test "project titles already contains title project" do
    evt = %ProjectCreated{id: 1, title: "Elixir project", stamp: 1}
    state = %AggregateState{}
            |> AggregateState.add_project(evt)

    assert true == AggregateState.has_title?(state, "Elixir project")
  end

  test "add note aggregate has project notes added" do
    evt = %ProjectCreated{id: 1, title: "Elixir project", stamp: 1}
    note = EventFactory.add_note_event("Elixir map", "Elixir project", "https://hexdocs.pm/elixir/Map.html")

    state = %AggregateState{}
            |> AggregateState.add_project(evt)
            |> AggregateState.add_note(note)

    assert %{"Elixir project" => [^note]} = state.notes
  end

  test "add two notes both notes are added" do
    evt = %ProjectCreated{id: 1, title: "Elixir project", stamp: 1}
    note = EventFactory.add_note_event("Elixir map", "Elixir project", "https://hexdocs.pm/elixir/Map.html")
    another_note = EventFactory.add_note_event("Elixir Record", "Elixir project", "https://hexdocs.pm/elixir/Record.html#content")

    state = %AggregateState{}
            |> AggregateState.add_project(evt)
            |> AggregateState.add_note(note)
            |> AggregateState.add_note(another_note)

    assert %{"Elixir project" => [^another_note, ^note]} = state.notes
  end

end
