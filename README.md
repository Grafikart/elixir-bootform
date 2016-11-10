# Bootform

[![](https://travis-ci.org/Grafikart/elixir-bootform.svg)](https://travis-ci.org/Grafikart/elixir-bootform)
[![Hex.pm Version](http://img.shields.io/hexpm/v/bootform.svg)](https://hex.pm/packages/bootform)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `bootform` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:bootform, "~> 0.1"}]
    end
    ```

  2. Enjoy Bootform

    ```elixir
      <%= form_for @comment, post_path(@conn, :index), fn f -> %>
        <%= input f, :mail, false, type: :email, placeholder: "Your email" %>
        <%= input f, :username, false, placeholder: "Your username" %>
        <%= textarea f, :content, false, placeholder: "Your comment" %>
        <%= Bootform.submit "Envoyer" %>
      <% end %>
    ```