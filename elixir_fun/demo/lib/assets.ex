defmodule Demo.Assets do
  use Scenic.Assets.Static,
    otp_app: :demo,
    alias: [
      parrot: "images/cyanoramphus_zealandicus_1849.jpg"
    ]

end
