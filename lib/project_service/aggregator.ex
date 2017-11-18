defmodule ProjectService.Aggregator do
  alias ProjectService.{AggregateState, ProjectCreated, NoteAdded}

  def start_link(id) do
    {:ok, pid} = Agent.start_link(fn -> %AggregateState{} end, name: id)
    pid
  end

  def aggregate(id, event=%ProjectCreated{title: title}) do
    id
    |> aggregate(event, Agent.get(id, fn state ->
        state
        |> AggregateState.has_title?(title)
    end))
  end

  def aggregate(id, event=%NoteAdded{project_title: title}) do
    id
    |> aggregate(event, Agent.get(id, fn state ->
        state
        |> AggregateState.has_title?(title)
    end))
  end

  def aggregate(id, event=%ProjectCreated{}, _has_title=false) do
    id
    |> Agent.cast(fn state ->
        state
        |> AggregateState.add_project(event)
    end)
  end

  def aggregate(id, event=%NoteAdded{}, _has_title=true) do
    id
    |> Agent.cast(fn state ->
        state
        |> AggregateState.add_note(event)
    end)
  end

  def aggregate(_id, _event=%ProjectCreated{}, _has_title) do
    {:error, "Project with this title already exist"}
  end

  def aggregate(_id, _event=%NoteAdded{}, _has_title) do
    {:error, "Cannot add note for given project"}
  end

end
