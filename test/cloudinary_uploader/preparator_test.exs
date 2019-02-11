defmodule CloudinaryUploader.PreparatorTest do
  use ExUnit.Case, async: true

  import CloudinaryUploader.Preparator
  alias CloudinaryUploader.ParseError

  test "invalid url" do
    assert_raise ParseError, fn ->
      prepare("not a url", %{})
     end
  end

  test "invalid option" do
    assert_raise ParseError, fn ->
      prepare("https://www.gstatic.com/webp/gallery/1.jpg", %{invalid_option: "value"})
     end
  end

  test "invalid resource type atom" do
    assert_raise ParseError, fn ->
      prepare("https://www.gstatic.com/webp/gallery/1.jpg", %{resource_type: :invalid_resource_type})
     end
  end

  test "invalid resource type string" do
    assert_raise ParseError, fn ->
      prepare("https://www.gstatic.com/webp/gallery/1.jpg", %{resource_type: "invalid_resource_type"})
     end
  end

  test "invalid public id" do
    assert_raise ParseError, fn ->
      prepare("https://www.gstatic.com/webp/gallery/1.jpg", %{public_id: :invalid_public_id_type})
     end
  end

end