# Bootform

![](https://travis-ci.org/Grafikart/elixir-bootform.svg)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `bootform` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:bootform, "~> 0.1.0"}]
    end
    ```

  2. Ensure `bootform` is started before your application:

    ```elixir
    def application do
      [applications: [:bootform]]
    end
    ```


```
%Phoenix.HTML.Form{
    data: %Blogmvc.Comment{
        __meta__: #Ecto.Schema.Metadata<:built, "comments">,
        content: nil,
        created: nil,
        id: nil,
        mail: nil,
        post: #Ecto.Association.NotLoaded<association :post is not loaded>,
        post_id: nil,
        username: "John doe"
    },
    errors: [],
    hidden: [],
    id: "comment",
    impl: Phoenix.HTML.FormData.Ecto.Changeset,
    index: nil, name: "comment",
    options: [method: "post"],
    params: %{},
    source: #Ecto.Changeset<
        action: nil,
        changes: %{},
        errors: [mail: {"can't be blank", []}, content: {"can't be blank", []}],
        data: #Blogmvc.Comment<>, valid?: false
    >
}
```
