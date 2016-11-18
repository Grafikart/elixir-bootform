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

    iex> form = Phoenix.HTML.Form.__struct__(%{
    ...>   errors: [email: {"should be at least %{count} character(s)", [count: 4]}]
    ...> })
    ...> Bootform.Errors.get_error(form, :email)
    "should be at least 4 character(s)"
  """
  def get_error(form, field) do
    case has_error?(form, field) do
      true -> 
        msg = form.errors[field] |> elem(0)
        opts = form.errors[field] |> elem(1)
        Enum.reduce(opts, msg, fn {key, value}, _acc ->
         String.replace(msg, "%{#{key}}", to_string(value))
        end)
      _ -> nil
    end
  end

end