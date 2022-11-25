defmodule Aggregator do
  use GenServer

  # client
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: :aggregator)
  end

  def convert_to_string(pid, list_tasks) do
    list_tasks
    |> Task.async_stream(
      fn item ->
        GenServer.cast(pid, {:add, item})
      end,
      max_concurrency: length(list_tasks),
      on_timeout: :kill_task
    ) |> Enum.into([])
  end

  def return_list(pid) do
    GenServer.call(pid, :return)
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  # server
  def handle_cast({:add, item}, list) do
    ramdon_number = :rand.uniform(5000)
    Process.sleep(ramdon_number)
    IO.puts("Item:  #{item}, Ramdom Number: #{ramdon_number}" )
    updated_list = [to_string(item) | list]
    {:noreply, updated_list}
  end

  def handle_call(:return, _from, list) do
    {:reply, list, list}
  end

  def init(list) do
    {:ok, list}
  end
end
