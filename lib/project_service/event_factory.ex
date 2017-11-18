defmodule ProjectService.EventFactory do
  alias ProjectService.{ProjectCreated, NoteAdded}

  def add_project_event(title), do: %ProjectCreated{
    id: UUID.uuid1(),
    title: title,
    stamp: System.system_time()
  }

  def add_note_event(text, project_title, url), do: %NoteAdded{
    id: UUID.uuid1(),
    stamp: System.system_time(),
    project_title: project_title,
    text: text,
    url: url
  }

end
