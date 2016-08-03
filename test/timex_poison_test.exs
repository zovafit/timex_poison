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
    assert %TestStruct{timestamp: %DateTime{}} = decoded
  end

  test "gracefully handles unparseable dates returning nil" do
    {:ok, decoded} = Poison.decode(~s({"timestamp": "not a timestamp"}), as: %TestStruct{})
    assert %TestStruct{timestamp: nil} = decoded
  end

  defmodule WithDateFormat do
    use TimexPoison, keys: [:timestamp], format: "{RFC1123}"
    defstruct [:timestamp]
  end

  test "accepts a default format for dates" do
    {:ok, decoded} = Poison.decode(~s({"timestamp" : "Tue, 05 Mar 2013 23:25:19 +0200"}), as: %WithDateFormat{})
    assert %WithDateFormat{timestamp: %DateTime{}} = decoded
  end

  @tag :skip
  test "individual formatters for keys"
end
