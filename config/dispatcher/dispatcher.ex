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
  get "/mandatees/*path" do
    Proxy.forward conn, path, "http://cache/mandatees/"
  end
  get "/mandates/*path" do
    Proxy.forward conn, path, "http://cache/mandates/"
  end
  get "/people/*path" do
    Proxy.forward conn, path, "http://cache/people/"
  end
  get "/government-functions/*path" do
    Proxy.forward conn, path, "http://cache/government-functions/"
  end
  get "/government-bodies/*path" do
    Proxy.forward conn, path, "http://cache/government-bodies/"
  end
  get "/government-units/*path" do
    Proxy.forward conn, path, "http://cache/government-units/"
  end
  get "/versions/*path" do
    Proxy.forward conn, path, "http://cache/versions/"
  end
  get "/agenda-items/*path" do
    Proxy.forward conn, path, "http://cache/agenda-items/"
  end
  get "/agendas/*path" do
    Proxy.forward conn, path, "http://cache/agendas/"
  end
  get "/meetings/*path" do
    Proxy.forward conn, path, "http://cache/meetings/"
  end
  get "/concepts/*path" do
    Proxy.forward conn, path, "http://cache/concepts/"
  end
  get "/concept-schemes/*path" do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end
  get "/news-item-infos/*path" do
    Proxy.forward conn, path, "http://cache/news-item-infos/"
  end
  get "/attachments/*path" do
    Proxy.forward conn, path, "http://cache/attachments/"
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
