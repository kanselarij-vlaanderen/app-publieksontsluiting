defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end
  match "/vlaamse-regering/beslissingenvlaamseregering/mandatees/*path" do
    Proxy.forward conn, path, "http://resource/mandatees/"
  end
  match "/vlaamse-regering/beslissingenvlaamseregering/people/*path" do
    Proxy.forward conn, path, "http://resource/people/"
  end
  match "/vlaamse-regering/beslissingenvlaamseregering/themes/*path" do
    Proxy.forward conn, path, "http://resource/themes/"
  end
  match "/vlaamse-regering/beslissingenvlaamseregering/meetings/*path" do
    Proxy.forward conn, path, "http://resource/meetings/"
  end
  match "/vlaamse-regering/beslissingenvlaamseregering/news-items/search/*path" do
    Proxy.forward conn, path, "http://mu-search/news-items/search/"
  end
  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
