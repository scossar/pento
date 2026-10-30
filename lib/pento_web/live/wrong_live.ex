defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts("PentoWeb.WrongLive mount function called")

    target =
      if connected?(socket) do
        Enum.random(1..10)
      else
        nil
      end

    {:ok,
     assign(
       socket,
       score: 0,
       message: "Make a guess:",
       target: target,
       reset: false
     )}
  end

  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
      <h2>
        {@message}
        <%= if @reset do %>
          <.link
            class="btn btn-secondary"
            patch={~p"/guess"}
          >Reset</.link>
        <% end %>
      </h2>
      <br />
      <h2>
        <%= for n <- 1..10 do %>
          <.link
            class="btn btn-secondary"
            phx-click="guess"
            phx-value-number={n}
          >{n}</.link>
        <% end %>
      </h2>
    </main>
    """
  end

  def handle_params(_params, _uri, socket) do
    {
      :noreply,
      assign(
        socket,
        message: "Make a guess:",
        score: 0,
        target: Enum.random(1..10),
        reset: false
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    %{target: target} = socket.assigns

    case target == String.to_integer(guess) do
      true ->
        message = "Your guess: #{guess}. Correct!"

        {
          :noreply,
          assign(
            socket,
            message: message,
            score: socket.assigns.score,
            reset: true
          )
        }

      _ ->
        message = "Your guess: #{guess}. Wrong. Guess again."
        score = socket.assigns.score - 1

        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score
          )
        }
    end
  end
end
