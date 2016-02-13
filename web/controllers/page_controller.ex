defmodule Hydchat.PageController do
  use Hydchat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
