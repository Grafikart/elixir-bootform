defmodule Bootform do
  @moduledoc ~S"""
    Bootform is inspired by simple_form from rails and allow an easier way to render form
    using bootstrap 4 semantic.

      input form, :email, "Your email", type: :email

    will render 

      <div class="form-group has-danger">
          <label for="helloEmail">Your email</label>
          <input class="form-control" id="helloEmail" name="hello[email]" type="text">
          <div class="form-control-feedback">can&#39;t be blank</div>
      </div>
  """

  alias Phoenix.HTML.Form
  alias Phoenix.HTML.Tag
  alias Bootform.AttributeHelper
  alias Bootform.Errors

  @wrapper_class "form-group"
  @wrapper_checkbox_class "form-check"
  @error_class "has-danger"
  @input_class "form-control"

  @doc """
  Render text input using bootstrap tags

  ## Examples

  You can use it this way

    input form, :email, "Your email", type: :email

  You can ommit label and options

    input form, :email

  """
  @spec input(Phoenix.HTML.Form.t, Atom.t, String.t, List.t) :: String.t
  def input(form, field, label \\ false, opts \\ []) do
    id = AttributeHelper.id(form, field)
    wrap(form, field, label, []) do
      type = Keyword.get(opts, :type)
      opts = Keyword.delete(opts, :type)
      case type do
        :email -> Form.email_input(form, field, opts ++ [id: id, class: @input_class])
        :textarea -> Form.textarea(form, field, opts ++ [id: id, class: "form-control"])
        _ -> Form.text_input(form, field, opts ++ [id: id, class: @input_class])
      end

    end
  end

  @doc """
  Render textarea input using bootstrap tags
  """
  @spec textarea(Phoenix.HTML.Form.t, Atom.t, String.t, List.t) :: String.t
  def textarea(form, field, label \\ false, opts \\ []) do
    input(form, field, label, opts ++ [type: :textarea])
  end

  @doc """
  Render a checkbox with label
  """
  @spec checkbox(Phoenix.HTML.Form.t, Atom.t, String.t, List.t) :: String.t
  def checkbox(form, field, label \\ false, opts \\ []) do
    class = case Errors.has_error?(form, field) do
      true -> @wrapper_checkbox_class <> " " <> @error_class
      _ -> @wrapper_checkbox_class
    end
    Tag.content_tag(:div, class: class) do
      Tag.content_tag(:label, class: "form-check-label") do
        [
          Form.checkbox(form, field, opts ++ [
            class: "form-check-input",
            id: AttributeHelper.id(form, field)
          ]),
          label
        ]
      end
    end
  end

  @doc """
    Render a submit button
  """
  @spec submit(String.t) :: String.t
  def submit(label) do
    Tag.content_tag :div, class: @wrapper_class do
      Tag.content_tag :button, label, type: "submit", class: "btn btn-primary"
    end

  end

  defp wrap(form, field, label, opts, do: block) do
    id = AttributeHelper.id(form, field)
    {opts, help} = if Errors.has_error?(form, field) do
      {
        opts ++ [class: @wrapper_class <> " " <> @error_class],
        Tag.content_tag(:div, Errors.get_error(form, field), class: "form-control-feedback")
      }
    else
      {
        Keyword.put_new(opts, :class, @wrapper_class),
        ""
      }
    end
    Tag.content_tag(:div, opts) do
      [
        if label !== false do Tag.content_tag(:label, label, for: id) else "" end,
        block,
        help
      ]
    end
  end

end
