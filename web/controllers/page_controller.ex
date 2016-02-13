defmodule Hydchat.PageController do
  use Hydchat.Web, :controller

  def index(conn, _params) do
    qry = from m in Hydchat.Message,
    order_by: [:inserted_at]
    messages = Hydchat.Repo.all(qry)
    render conn, "index.html", messages: messages
  end
end
