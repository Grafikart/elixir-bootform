defmodule Bootform.Errors do

  @doc """
    Determine if the specified field has an error

    ## Examples

    iex> form = Phoenix.HTML.Form.__struct__(%{
    ...>   errors: [email: {"can't be blank", []}]
    ...> })
    ...> Bootform.Errors.has_error?(form, :email)
    true

    iex> form = Phoenix.HTML.Form.__struct__(%{
    ...>   errors: [email: {"can't be blank", []}]
    ...> })
    ...> Bootform.Errors.has_error?(form, :username)
    false
  """
  @spec has_error?(Phoenix.HTML.Form.t, Atom.t) :: BooleanExpr.t
  def has_error?(%Phoenix.HTML.Form{errors: errors}, field) do
    Keyword.has_key?(errors, field)
  end

  def has_error?(_form, _field) do
    false
  end

  @doc """
    Return the error for the selected field

    ## Examples

    iex> form = Phoenix.HTML.Form.__struct__(%{
    ...>   errors: [email: {"can't be blank", []}]
    ...> })
    ...> Bootform.Errors.get_error(form, :email)
    "can't be blank"

    iex> form = Phoenix.HTML.Form.__struct__(%{
    ...>   errors: [email: {"can't be blank", []}]
    ...> })
    ...> Bootform.Errors.get_error(form, :username)
    nil
  """
  def get_error(form, field) do
    case has_error?(form, field) do
      true -> form.errors[field] |> elem(0)
      _ -> nil
    end
  end

end