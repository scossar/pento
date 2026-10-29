defmodule Pento.GuessStore do
  use Agent

  def start_link(target) do
    Agent.start_link(fn -> target end, name: __MODULE__)
  end

  def get_target do
    Agent.get(__MODULE__, & &1)
  end

  def new_target(new_target) do
    Agent.update(__MODULE__, fn _current_target -> new_target end)
  end
end
