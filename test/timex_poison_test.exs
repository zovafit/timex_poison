defmodule TimexPoisonTest do
  use ExUnit.Case
  doctest TimexPoison

  defmodule TestStruct do
    use TimexPoison, keys: [:timestamp]
    defstruct [:name, :timestamp, :another_timestamp]
  end


  test "timestamp fields are parsed into Timex.DateTime structs" do
    {:ok, decoded} = Poison.decode(~s({"name": "foo", "timestamp" : "2016-07-27T08:50:08.681Z"}), as: %TestStruct{})
    assert Protocol.assert_impl!(Poison.Decoder, TestStruct)
    assert %TestStruct{timestamp: %Timex.DateTime{}} = decoded
  end
end
