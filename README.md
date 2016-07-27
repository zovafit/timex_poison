# TimexPoison

Easily parse timestamps using Timex as they are decoded from json by Poison.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `timex_poison` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:timex_poison, "~> 0.1.0"}]
    end
    ```

  2. Ensure `timex_poison` is started before your application:

    ```elixir
    def application do
      [applications: [:timex_poison]]
    end
    ```

## Usage

```elixir
defmodule MyGreatStruct do
  use TimexPoison keys: [:created_at]
  defstruct [:name, :created_at]
end

iex> Poison.decode! ~s({"name": "Great", "created_at": "2016-07-27T08:50:08.681Z"}), as: %MyGreatStruct{}
%MyGreatStruct{name: "Great", created_at: #<DateTime(2016-07-27T08:50:08Z)>} 
```
