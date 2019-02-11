defmodule CloudinaryUploader.Uploader do
  @moduledoc false

  @cloudinary_headers [
    {"Content-Type", "application/json"}
  ]

  @base_url "https://api.cloudinary.com/v1_1/"

  alias CloudinaryUploader.{ParseError, UploadError}
  alias CloudinaryUploader.Response

  def upload(body) do
    body
    |> sign()
    |> (&(Map.merge(%{signature: &1}, body))).()
    |> call()
    |> parse_response()
    |> (&struct(%Response{}, &1)).()
  end

  defp sign(map) do
    if(is_nil(Application.get_env(:cloudinary_uploader, :api_secret)), do: raise(ParseError, message: "cloudinary api_secret is not set in application variables"))
    map
    |> Map.drop([:api_key, :file, :resource_type])
    |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
    |> Enum.sort()
    |> Enum.join("&")
    |> Kernel.<>("#{Application.get_env(:cloudinary_uploader, :api_secret)}")
    |> sha()
  end

  defp sha(query) do
    :sha
    |> :crypto.hash(query)
    |> Base.encode16()
    |> String.downcase()
  end

  defp call(opts) do
    if(is_nil(Application.get_env(:cloudinary_uploader, :cloud_name)), do: raise(ParseError, message: "cloudinary cloud_name is not set in application variables"))
    url = "#{@base_url}#{Application.get_env(:cloudinary_uploader, :cloud_name)}/#{Map.get(opts, :resource_type)}/upload"
    HTTPoison.request!(:post, url, Poison.encode!(opts), @cloudinary_headers)
  end

  defp parse_response(response) do
    %HTTPoison.Response{body: response, status_code: status_code} = response
    if(status_code == 200) do
      response
      |> Poison.decode!()
      |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
    else
      raise(UploadError, message: Poison.decode!(response)["error"]["message"], status_code: status_code)
    end
  end

end

defmodule CloudinaryUploader.UploadError do
  @type t :: %__MODULE__{status_code: Integer.t(), message: String.t()}

  defexception message: nil, status_code: nil

  def message(%{message: nil, status_code: status_code}) do
    "upload returned status_code #{status_code}"
  end

  def message(%{message: message, status_code: status_code}) do
    "upload returned status_code #{status_code} with error message #{message}"
  end 
end