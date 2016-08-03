defmodule TimexPoison do
  defmacro __using__(opts) do
    keys = Keyword.get(opts, :keys, [])
    format = Keyword.get(opts, :format, "{ISO:Extended:Z}")
    quote do
      @keys unquote(keys)
      @format unquote(format)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def __timestamp_keys__ do
        @keys
      end

      def __timestamp_format__ do
        @format
      end

      defimpl Poison.Decoder, for: __MODULE__ do
        def decode(value, _options) do
          TimexPoison.decode_timestamps @for.__timestamp_keys__, value, @for.__timestamp_format__
        end
      end
    end
  end

  def decode_timestamps(keys, into, format) do
    keys
    |> Enum.reduce(into, fn field, acc ->
      Map.update(acc, field, nil, &(TimexPoison.parse_datetime(&1, format)))
    end)
  end

  def parse_datetime(datetime, format) do
    case Timex.parse(datetime, format) do
      {:ok, value} -> value
      {:error, error} -> nil
    end
  end
end
