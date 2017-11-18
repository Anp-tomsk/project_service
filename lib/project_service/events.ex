defmodule ProjectService.ProjectCreated do
  @enforce_keys [:id, :stamp, :title]
  defstruct [
    id: nil,
    stamp: nil,
    title: nil
  ]
end

defmodule ProjectService.NoteAdded do
  @enforce_keys  [:id, :stamp, :project_title, :text, :url]
  defstruct [
    id: nil,
    stamp: nil,
    project_title: nil,
    text: nil,
    url: nil,
  ]
end
