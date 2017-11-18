defmodule ProjectService.AggregateState do
  alias ProjectService.{ProjectCreated, NoteAdded}

  defstruct  [projects: Map.new(), notes: Map.new() ]

  def has_title?(%{projects: projects}, title) do
    projects
    |> Map.has_key?(title)
  end

  def contain_notes?(state, title) do
    state.notes
    |> Map.has_key?(title)
  end

  def add_project(state=%{projects: projects}, event=%ProjectCreated{title: title}) do
    %{ state|
       projects: projects
                 |> Map.put(title, event) }
  end

  def add_note(state, event=%NoteAdded{project_title: title}) do
    state
    |> add_note(event, contain_notes?(state, title))
  end

  def add_note(state=%{notes: notes}, event=%NoteAdded{project_title: title}, _contains_note=true) do
    %{state|
      notes: notes
             |> Map.update!(title, fn curr_notes -> [event | curr_notes] end) }
  end

  def add_note(state=%{notes: notes}, event=%NoteAdded{project_title: title}, _contains_note) do
    %{state|
      notes: notes
             |> Map.put(title, [event]) }
  end

end
