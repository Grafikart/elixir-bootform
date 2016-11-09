defmodule BootformTest do
  use ExUnit.Case, async: true
  doctest Bootform

  setup do 
    conn = Phoenix.ConnTest.build_conn()
    form = Phoenix.HTML.FormData.to_form(conn, [as: "hello"])
    {:ok, [form: form]}
  end


  test "the truth", %{form: form} do
    input = Bootform.input(form, :email)
      |> Phoenix.HTML.Safe.to_iodata
      |> IO.iodata_to_binary
    expect = """
    <div class="form-group">
      <input id="hello_email" name="hello[email]" type="text">
    </div>
    """ |> String.replace("\n", "") |> String.replace("  ", "")
    assert input == expect
  end
end
