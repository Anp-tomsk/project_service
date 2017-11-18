defmodule ProjectService do
  alias ProjectService.{EventFactory, Aggregator}

  def register_user(id) do
    Aggregator.start_link(id)
  end

  def add_project(user_id, title) do
    event = EventFactory.add_project_event(title)
    Aggregator.aggregate(user_id, event)
  end

  def add_note(user_id, text, project_title, url) do
    event = EventFactory.add_note_event(text, project_title, url)
    Aggregator.aggregate(user_id, event)
  end
end
