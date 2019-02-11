
# CloudinaryUploader

CloudinaryUploader is an Elixir library that can upload image, audio and video urls to Cloudinary.

## Installation

The package can be installed by adding `cloudinary_uploader` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cloudinary_uploader, "~> 0.1.0"}
  ]
end
```
Then, update your dependencies:

```sh-session
$ mix deps.get
```

## Configaration

To use CloudinaryUploader you have to configure `API_KEY` `API_SECRET` and  `CLOUD_NAME` in your `config.exs`. You can find account-specific configuration credentials in the dashboard of our Cloudinary Management Console.

```elixir
config :cloudinary_uploader,
  api_key: "my_api_key",
  api_secret: "my_api_secret",
  cloud_name: "my_cloud_name"
```

## Usage

### Image Upload

The `upload` method uploads an image to the cloud. `upload!` also uploads a image to cloudinary but raises an exception on error.

```elixir
iex> CloudinaryUploader.upload("https://www.gstatic.com/webp/gallery/1.jpg")
{:ok,
 %CloudinaryUploader.Response{audio: nil, bit_rate: nil, bytes: 44891,
  created_at: "2019-02-11T10:47:27Z", duration: nil,
  etag: "d4a63031f57bdcafb86ca02100fdd6d2", format: "jpg", frame_rate: nil,
  height: 368, is_audio: nil, original_filename: "1", pages: nil,
  placeholder: false, public_id: "bg871jkepmqgu7wka2zy", resource_type: "image",
  rotation: nil,
  secure_url: "https://res.cloudinary.com/cloudname/image/upload/v1549882047/bg871jkepmqgu7wka2zy.jpg",
  signature: "924a2e045f2266fdd3d65b4f20be324a18f7c0a9", tags: [],
  type: "upload",
  url: "http://res.cloudinary.com/cloudname/image/upload/v1549882047/bg871jkepmqgu7wka2zy.jpg",
  version: 1549882047, video: nil, width: 550}}

```

### Audio and Video Upload

Audio and Video files can be uploaded with the same `upload` function by sending resource_type as video in the parameters. If resource_type is not specified image resource_type will be taken as default.

```elixir
iex> CloudinaryUploader.upload("https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4", resource_type: :video)
{:ok,
 %CloudinaryUploader.Response{audio: %{"bit_rate" => "384828",
    "channel_layout" => "5.1", "channels" => 6, "codec" => "aac",
    "frequency" => 48000}, bit_rate: 1589963, bytes: 1055736,
  created_at: "2019-02-11T10:53:55Z", duration: 5.312,
  etag: "d55bddf8d62910879ed9f605522149a8", format: "mp4", frame_rate: 25.0,
  height: 720, is_audio: false, original_filename: "big_buck_bunny_720p_1mb",
  pages: 0, placeholder: false, public_id: "oevkmoic6js7fjgupfai",
  resource_type: "video", rotation: 0,
  secure_url: "https://res.cloudinary.com/cloudname/video/upload/v1549882435/oevkmoic6js7fjgupfai.mp4",
  signature: "97b2ec29b03a47325d48d4e772e790dfba688511", tags: [],
  type: "upload",
  url: "http://res.cloudinary.com/cloudname/video/upload/v1549882435/oevkmoic6js7fjgupfai.mp4",
  version: 1549882435,
  video: %{"bit_rate" => "1205959", "codec" => "h264", "dar" => "16:9",
    "level" => 31, "pix_format" => "yuv420p", "profile" => "Main"},
  width: 1280}}
```

### Upload files with `public_id`

An additional parameter `public_id`(String) should be sent for customised accessibility of the uploaded asset. If `public_id` was not set, Cloudinary generates a random `public_id`.
Although the public_id parameter can be specified, the overwrite parameter is always set to 'false' for unsigned uploads to prevent overwriting existing files.


```elixir
iex> CloudinaryUploader.upload("https://www.gstatic.com/webp/gallery/1.jpg", public_id: "specific_folder/file_name")
{:ok,
 %CloudinaryUploader.Response{audio: nil, bit_rate: nil, bytes: 44891,
  created_at: "2019-02-11T11:08:11Z", duration: nil,
  etag: "d4a63031f57bdcafb86ca02100fdd6d2", format: "jpg", frame_rate: nil,
  height: 368, is_audio: nil, original_filename: "1", pages: nil,
  placeholder: false, public_id: "specific_folder/file_name",
  resource_type: "image", rotation: nil,
  secure_url: "https://res.cloudinary.com/cloudname/image/upload/v1549883291/specific_folder/file_name.jpg",
  signature: "d4ecfdc70fb50dd4ea6c33f7845cc11c2f3954f2", tags: [],
  type: "upload",
  url: "http://res.cloudinary.com/cloudname/image/upload/v1549883291/specific_folder/file_name.jpg",
  version: 1549883291, video: nil, width: 550}}
```
## Documentation

Documentation be found at [https://hexdocs.pm/cloudinary_uploader](https://hexdocs.pm/cloudinary_uploader).

## License
Released under the MIT license.

