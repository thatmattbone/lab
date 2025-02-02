defmodule HeadsUpWeb.TipsController do
  use HeadsUpWeb, :controller

  alias HeadsUp.Tips

  def index(conn, _params) do
    render(conn, :index, tips: Tips.list_tips())
  end

  def detail(conn, %{"tip_id" => tip_id}=_params) do
    tip = Tips.lookup_tip(tip_id)
    render(conn, :detail, tip: tip)
  end
end
