defmodule FlixWeb.FanView do
  use FlixWeb, :view

  alias Flix.Accounts.User

  def profile_image(user, size \\ 100) do
    url = "https://www.gravatar.com/avatar/#{User.gravatar_id(user)}?s=#{size}&d=robohash"

    img_tag(url,
      alt: user.name,
      class: "rounded-circle z-depth-2",
      "data-holder-rendered": "true"
    )
  end
end
