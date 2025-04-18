defmodule HeadsUpWeb.TipsHTML do
  use HeadsUpWeb, :html

  embed_templates "tips_html/*"

  def detail(assigns) do
    ~H"""
      <div class="tips">
        <h1>Tip Detail for tip id: {@tip.id}</h1>
        <p>{@tip.text}</p>
      </div>
    """
  end
end
