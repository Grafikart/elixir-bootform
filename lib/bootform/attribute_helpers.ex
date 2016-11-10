defmodule Bootform.AttributeHelper do

   @spec id(Phoenix.HTML.Form.t, Atom.t) :: String.t
   def id(%Phoenix.HTML.Form{name: name}, field) do
     name <> String.capitalize(Atom.to_string(field))
   end

end