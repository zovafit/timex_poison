# TimexPoison

Easily parse timestamps using Timex as they are decoded from json by Poison.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `timex_poison` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:timex_poison, "~> 0.1.1"}]
    end
    ```

  2. Ensure `timex_poison` is started before your application:

    ```elixir
    def application do
      [applications: [:timex_poison]]
    end
    ```

## Usage


### Basic Usage

By default, timestamps will be parsed using Timex's `{ISOz}` formatter.

```elixir
defmodule MyGreatStruct do
  use TimexPoison keys: [:created_at]
  defstruct [:name, :created_at]
end

iex> Poison.decode! ~s({"name": "Great", "created_at": "2016-07-27T08:50:08.681Z"}), as: %MyGreatStruct{}
%MyGreatStruct{name: "Great", created_at: #<DateTime(2016-07-27T08:50:08Z)>} 
```

### Formatter Selection

Alternatively you can specify your own formatter:

```elixir
defmodule WithDateFormat do
  use TimexPoison, keys: [:timestamp], format: "{RFC1123}"
  defstruct [:timestamp]
end

iex> Poison.decode(~s({"timestamp" : "Tue, 05 Mar 2013 23:25:19 +0200"}), as: %WithDateFormat{})
```
