defmodule Bootform do

  alias Phoenix.HTML.Form
  alias Phoenix.HTML.Tag
  alias Bootform.AttributeHelper

  @wrapper_class "form-group"
  @input_class "form-control"

  @doc """
  Render text input using bootstrap tags

  ```
  <div class="form-group">
   <label for="exampleInputEmail1">Email address</label>
   <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" autocomplete="off">
  </div>
  ```
  """  
  @spec input(Phoenix.HTML.Form.t, Atom.t, String.t, List.t) :: String.t
  def input(form, field, label \\ false, opts \\ []) do
    id = AttributeHelper.id(form, field)
    input = Form.text_input(form, field, opts ++ [id: id, class: @input_class])
    wrap(form, field, label, input, [])
  end

  @doc """
  Render textarea input using bootstrap tags
  ```
  """
  @spec textarea(Phoenix.HTML.Form.t, Atom.t, String.t, List.t) :: String.t
  def textarea(form, field, label \\ false, opts \\ []) do
    id = AttributeHelper.id(form, field)
    input = Form.textarea(form, field, opts ++ [id: id, class: "form-control"])
    wrap(form, field, label, input, [])
  end

  @doc """
    Render a submitr button
  """
  @spec submit(String.t) :: String.t
  def submit(label) do
    Tag.content_tag :button, label, type: "submit", class: "btn btn-primary"
  end

  defp wrap(%Phoenix.HTML.Form{source: %{errors: errors}} = form, field, label, content, opts) do
    form = %{form | source: nil}
    {opts, help} = if Keyword.has_key?(errors, field) do
      {
        opts ++ [class: "has-error"],
        Tag.content_tag(:span, elem(errors[field], 0), class: "help-block")
      }
    end
    wrap(form, field, label, [content] ++ help, opts)
  end

  defp wrap(form, field, label, content, opts) do
    id = AttributeHelper.id(form, field)
    label_tag = Tag.content_tag :label, label, for: id
    opts = if Keyword.has_key?(opts, :class) do
      Keyword.put(opts, :class, @wrapper_class <> " " <> opts[:class])
    else
      Keyword.put(opts, :class, @wrapper_class)
    end
    Tag.content_tag(:div, [label_tag] ++ content, opts)
  end
end
