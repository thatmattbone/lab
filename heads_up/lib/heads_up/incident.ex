defmodule HeadsUp.Incident do
  defstruct [:id, :name, :description, :priority, :status, :image_path]

  def list_incidents do
    [
      %__MODULE__{  # syntax to separate the construction of this struct from this module's name.
        id: 1,
        name: "Lost Dog",
        description: "A friendly dog is wandering around the neighborhood. 🐶",
        priority: 2,
        status: :pending,
        image_path: "/images/lost-dog.jpg"
      },
      %HeadsUp.Incident{
        id: 2,
        name: "Flat Tire",
        description: "Our beloved ice cream truck has a flat tire! 🛞",
        priority: 1,
        status: :resolved,
        image_path: "/images/flat-tire.jpg"
      },
      %HeadsUp.Incident{
        id: 3,
        name: "Bear In The Trash",
        description: "A curious bear is digging through the trash! 🐻",
        priority: 1,
        status: :canceled,
        image_path: "/images/bear-in-trash.jpg"
      }
    ]
  end
end
