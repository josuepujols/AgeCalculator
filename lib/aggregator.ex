defmodule Aggregator do
  use GenServer

  #client
  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def convert_to_string(pid, listTasks) do
    listTasks |> Task.async_stream(fn item ->
      Process.sleep(:rand.uniform(5000))
      GenServer.cast(pid, {:add, item})
    end, max_concurrency: length(listTasks)) |> Enum.each(fn item -> IO.inspect(item) end)
  end

  def return_list(pid) do
    GenServer.call(pid, :return)
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  #server
  def handle_cast({:add, item}, list) do
    updated_list = list ++ [to_string(item)]
    {:noreply, updated_list}
  end

  def handle_call(:return, _from, list) do
    {:reply, list, list}
  end

  def init(list) do
    {:ok, list}
  end
end
