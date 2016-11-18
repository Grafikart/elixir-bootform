defmodule BootformTest do
  use ExUnit.Case, async: true
  doctest Bootform

  setup do
    conn = Phoenix.ConnTest.build_conn()
    form = Phoenix.HTML.FormData.to_form(conn, [as: "hello"])
    {:ok, [form: form]}
  end

  test ".input", %{form: form} do
    expect = """
    <div class="form-group">
        <label for="helloEmail">Your email</label>
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
    </div>
    """
    Bootform.input(form, :email, "Your email") |> similar(expect)
  end

  test ".input support no label", %{form: form} do
    expect = """
    <div class="form-group">
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
    </div>
    """
    Bootform.input(form, :email) |> similar(expect)
    Bootform.input(form, :email, class: "form-control") |> similar(expect)
  end

  test ".input without label", %{form: form} do
    expect = """
    <div class="form-group">
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
    </div>
    """
    Bootform.input(form, :email) |> similar(expect)
  end

  test ".input specify input type", %{form: form} do
    expect = """
    <div class="form-group">
        <label for="helloEmail">Your email</label>
        <input class="form-control" id="helloEmail" name="hello[email]" required="required" type="email">
    </div>
    """
    Bootform.input(form, :email, "Your email", type: :email, required: true)
      |> similar(expect)
  end

  test ".input with options", %{form: form} do
    expect = """
    <div class="form-group">
        <label for="helloEmail">Your email</label>
        <select class="form-control" id="helloEmail" name="hello[email]">
          <option value="1">a</option>
          <option value="3">b</option>
        </select>
    </div>
    """
    Bootform.input(form, :email, "Your email", options: [a: 1, b: 3]) |> similar(expect)
  end

  test ".textarea" do
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{email: "demo@demo.fr"},
      errors: []
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

  test "display errors correctly" do
    expect = """
    <div class="form-group has-danger">
        <label for="helloEmail">Your email</label>
        <input class="form-control" id="helloEmail" name="hello[email]" type="text">
        <div class="form-control-feedback">can&#39;t be blank</div>
    </div>
    """
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{},
      errors: [email: {"can't be blank", []}]
    })
    Bootform.input(form, :email, "Your email") |> similar(expect)
  end

  test ".submit" do
    expect = """
    <div class="form-group">
      <button class="btn btn-primary" type="submit">Submit</button>
    </div>
    """
    Bootform.submit("Submit") |> similar(expect)
  end

  test ".checkbox" do
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{cgu: true}
    })
    expect = """
    <div class="form-check">
        <label class="form-check-label">
          <input name="hello[cgu]" type="hidden" value="false">
          <input checked="checked" class="form-check-input" id="helloCgu" name="hello[cgu]" type="checkbox" value="true">
          Check me out
        </label>
      </div>
    """
    Bootform.checkbox(form, :cgu, "Check me out")
      |> similar(expect)
  end

  test ".checkbox with errors" do
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{cgu: true},
      errors: [cgu: {"Confirm CGU pls", []}]
    })
    expect = """
    <div class="form-check has-danger">
        <label class="form-check-label">
          <input name="hello[cgu]" type="hidden" value="false">
          <input checked="checked" class="form-check-input" id="helloCgu" name="hello[cgu]" type="checkbox" value="true">
          Check me out
        </label>
      </div>
    """
    Bootform.checkbox(form, :cgu, "Check me out")
      |> similar(expect)
  end

  test "display errors correctly with params" do
    expect = """
    <div class="form-group has-danger">
        <label for="helloUsername">Your username</label>
        <input class="form-control" id="helloUsername" name="hello[username]" type="text">
        <div class="form-control-feedback">should be at least 4 character(s)</div>
    </div>
    """
    form = Phoenix.HTML.Form.__struct__(%{
      name: "hello",
      data: %{},
      errors: [username: {"should be at least %{count} character(s)", [count: 4]}]
    })
    Bootform.input(form, :username, "Your username") |> similar(expect)
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
