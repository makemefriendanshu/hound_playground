defmodule HoundPlayground.ChatView do
  use HoundPlayground.Web, :view
  
  def render("scripts.html", _assigns) do
    ~s{<script>require("web/static/js/socket")</script>} |> raw
  end
end
