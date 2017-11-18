defmodule ProjectService.Application do
  use Application
  alias ProjectService.Aggregator

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Aggregator, [])
    ]

    options = [
      name: ProjectService.Supervisor,
      strategy: :simple_one_for_one
    ]

    Supervisor.start_link(children, options)
  end

end
