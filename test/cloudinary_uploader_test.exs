defmodule CloudinaryUploaderTest do
  use ExUnit.Case

  import CloudinaryUploader
  alias CloudinaryUploader.UploadError

  test "Resource not found" do
    assert_raise UploadError, fn ->
      upload!("https://www.someinvalidurl/gallery/1.jpg")
    end
  end

  test "Image Upload" do
    assert {:ok, %CloudinaryUploader.Response{}} =
             upload("https://www.gstatic.com/webp/gallery/1.jpg")
  end

  test "Video Upload" do
    assert {:ok, %CloudinaryUploader.Response{}} =
             upload("https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
               resource_type: :video
             )
  end

  test "Audio Upload" do
    assert {:ok, %CloudinaryUploader.Response{}} =
             upload("https://sample-videos.com/audio/mp3/crowd-cheering.mp3",
               resource_type: :video
             )
  end

  test "Image Upload with public id" do
    assert {:ok, %CloudinaryUploader.Response{}} =
             upload("https://www.gstatic.com/webp/gallery/2.jpg", public_id: "sample_image")
  end

  test "Video Upload with public id" do
    assert {:ok, %CloudinaryUploader.Response{}} =
             upload("https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
               resource_type: :video,
               public_id: "sample_video"
             )
  end
end
