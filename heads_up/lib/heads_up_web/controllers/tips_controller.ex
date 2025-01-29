defmodule HeadsUpWeb.TipsController do
  use HeadsUpWeb, :controller

  alias HeadsUp.Tips

  def index(conn, _params) do
    render(conn, :index, tips: Tips.list_tips())
  end
end
