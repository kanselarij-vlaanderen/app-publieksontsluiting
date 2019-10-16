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
  get "/notifications/*path" do
    Proxy.forward conn, path, "http://cache/notifications/"
  end
  get "/mandatees/*path" do
    Proxy.forward conn, path, "http://cache/mandatees/"
  end
  get "/people/*path" do
    Proxy.forward conn, path, "http://cache/people/"
  end
  get "/themes/*path" do
    Proxy.forward conn, path, "http://cache/themes/"
  end
  get "/meetings/*path" do
    Proxy.forward conn, path, "http://cache/meetings/"
  end
  get "/newsletter-infos/*path" do
    Proxy.forward conn, path, "http://cache/newsletter-infos/"
  end
  get "/document-versions/*path" do
    Proxy.forward conn, path, "http://cache/document-versions/"
  end
  get "/files/*path" do
    Proxy.forward conn, path, "http://file/files/"
  end
  get "/news-items/search/*path" do
    Proxy.forward conn, path, "http://search/news-items/search/"
  end
  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
