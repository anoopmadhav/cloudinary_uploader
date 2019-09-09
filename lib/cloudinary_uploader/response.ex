defmodule CloudinaryUploader.Response do
  @moduledoc false

  @type t :: %__MODULE__{
          audio: map | nil,
          bit_rate: non_neg_integer | nil,
          bytes: non_neg_integer | nil,
          created_at: String.t() | nil,
          duration: float | nil,
          etag: String.t() | nil,
          format: String.t() | nil,
          frame_rate: float | nil,
          height: non_neg_integer | nil,
          is_audio: true | false | nil,
          original_filename: String.t() | nil,
          pages: non_neg_integer | nil,
          placeholder: true | false | nil,
          public_id: String.t() | nil,
          resource_type: String.t() | nil,
          rotation: non_neg_integer | nil,
          secure_url: String.t() | nil,
          signature: String.t() | nil,
          tags: [String.t()] | [] | nil,
          type: String.t() | nil,
          url: String.t() | nil,
          version: String.t() | nil,
          video: map | nil,
          width: non_neg_integer | nil
        }

  defstruct audio: nil,
            bit_rate: nil,
            bytes: nil,
            created_at: nil,
            duration: nil,
            etag: nil,
            format: nil,
            frame_rate: nil,
            height: nil,
            is_audio: nil,
            original_filename: nil,
            pages: nil,
            placeholder: nil,
            public_id: nil,
            resource_type: nil,
            rotation: nil,
            secure_url: nil,
            signature: nil,
            tags: nil,
            type: nil,
            url: nil,
            version: nil,
            video: nil,
            width: nil
end
