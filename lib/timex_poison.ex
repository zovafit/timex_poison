defmodule TimexPoison do
  defmacro __using__(opts) do
    keys = Keyword.get(opts, :keys, [])
    quote do
      @keys unquote(keys)
      @before_compile unquote(__MODULE__)
    end

  end

  defmacro __before_compile__(_env) do
    quote do
      def __timestamp_keys__ do
        @keys
      end
      defimpl Poison.Decoder, for: __MODULE__ do
        def decode(value, _options) do
          @for.__timestamp_keys__
          |> Enum.reduce(value, fn field, acc -> Map.update(acc, field, nil, &TimexPoison.parse_datetime/1) end)
        end
      end
    end
  end
  def parse_datetime(datetime) do
    case Timex.parse(datetime, "{ISOz}") do
      {:ok, value} -> value
      {:error, error} -> IO.inspect(error)
    end
  end
end
