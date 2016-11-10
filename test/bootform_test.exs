defmodule BootformTest do
  use ExUnit.Case, async: true
  doctest Bootform

  setup do
    conn = Phoenix.ConnTest.build_conn()
    form = Phoenix.HTML.FormData.to_form(conn, [as: "hello"])
    {:ok, [form: form]}
  end

  test "generate input", %{form: form} do
    input = Bootform.input(form, :email, "Your email")
      |> Phoenix.HTML.Safe.to_iodata
      |> IO.iodata_to_binary
    expect = """
    <div class="form-group">
        <label for="helloEmail">Your email</label>
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
    </div>
    """
    assert cleaned(input) == cleaned(expect)
  end

  test "textarea" do
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{email: "demo@demo.fr"}
    })
    {:safe, input} = Bootform.textarea(form, :email, "Your email")
    expect = """
    <div class="form-group">
        <label for="helloEmail">Your email</label>
        <textarea class="form-control" id="helloEmail" name="hello[email]">
          demo@demo.fr
        </textarea>
    </div>
    """
    assert cleaned(input) == cleaned(expect)
  end

  test "errors" do
    expect = """
    <div class="form-group has-error">
        <label for="helloEmail">Your email</label>
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
        <span class="help-block">can&#39;t be blank</span>
    </div>
    """
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{},
      source: %{errors: [email: {"can't be blank", []}]}
    })
    Bootform.input(form, :email, "Your email") |> similar(expect)
  end

  test ".submit" do
    expect = """
    <button class="btn btn-primary" type="submit">Submit</button>
    """
    Bootform.submit("Submit") |> similar(expect)
  end

  defp cleaned(string) when is_binary(string) do
    string |> String.replace("\n", "") |> String.replace("  ", "")
  end

  defp cleaned({:safe, string}) do
    cleaned(string)
  end

  defp cleaned(string) do
    cleaned(IO.iodata_to_binary(string))
  end

  defp similar(a, b) do
    assert cleaned(a) == cleaned(b)
  end

end