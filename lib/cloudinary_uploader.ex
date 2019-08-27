defmodule CloudinaryUploader do
  @readme_path [__DIR__, "..", "README.md"] |> Path.join() |> Path.expand()
  @moduledoc @readme_path |> File.read!() |> String.trim()

  alias CloudinaryUploader.{Preparator, ParseError}
  alias CloudinaryUploader.{Response}
  alias CloudinaryUploader.{Uploader, UploadError}

  @doc """
  Upload a image to cloudinary.

  ## Examples

    iex> CloudinaryUploader.upload("https://www.gstatic.com/webp/gallery/1.jpg")
    {:ok, %CloudinaryUploader.Response{}}

  """
  @spec upload(String.t(), Preparator.options()) ::
          {:ok, Response.t()}
          | {:error, ParseError.t()}
          | {:error, UploadError.t()}
  def upload(url, options \\ %{}) do
    {:ok, upload!(url, options)}
  rescue
    exception in [ParseError, UploadError] ->
      {:error, exception}
  end

  @doc """
  Upload a image to cloudinary, raises an exception on error.

  ## Examples

    iex> CloudinaryUploader.upload("https://www.gstatic.com/webp/gallery/1.jpg")
    {:ok, %CloudinaryUploader.Response{}}

  """
  @spec upload!(String.t(), Preparator.options()) :: Response.t() | no_return
  def upload!(url, options \\ %{})

  def upload!(url, options) when is_list(options) do
    upload!(url, Map.new(options))
  end

  def upload!(url, options) do
    url
    |> Preparator.prepare(options)
    |> Uploader.upload()
  end
end
