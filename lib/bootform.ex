defmodule Bootform do

    alias Phoenix.HTML.Form
    alias Phoenix.HTML.Tag

  @doc """
  Render text input using bootstrap tags

  ```
    <div class="form-group">
        <label for="exampleInputEmail1">Email address</label>
        <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" autocomplete="off">
    </div>
    ```
  """  
  @spec input(Phoenix.HTML.Form.t, Atom.t, List.t) :: String.t
  def input(form, field, opts \\ []) do
    input = Form.text_input(form, field, opts)    
    Tag.content_tag(:div, input, class: "form-group")
    end

end
