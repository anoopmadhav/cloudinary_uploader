defmodule CloudinaryUploader.Preparator do
  @moduledoc false

  alias CloudinaryUploader.ParseError

  @allowed_keys ~w(
    file
    resource_type
    public_id
  )a

  @resource_types ~w(
    image
    video
    auto
  )a

  @default_resource_type :image

  @typep file :: string
  @typep public_id :: string
  @typep resource_type :: :image | :video | :auto

  @type options :: %{
          optional(:file) => file,
          optional(:public_id) => public_id,
          optional(:resource_type) => resource_type
        }

  @spec prepare(String.t(), options) :: Map.t() | ParseError.t()
  def prepare(url, options) do
    options
    |> Map.merge(%{file: url})
    |> validate_map()
    |> prepare_request_body()
  end

  defp validate_map(map) do
    Enum.each(map, fn{key, value} -> validate(key, value) end)
    map
  end

  defp validate(key, value) do
    if Enum.member?(@allowed_keys, key) do
      process_value(key, value)
    else
      raise ParseError, message: "#{key} is not a valid option"
    end
  end

  defp process_value(:file, value) do
    unless(Regex.match?(~r/^http/, value), do: raise(ParseError, message: "not a valid URL"))
  end

  defp process_value(:resource_type, value) when is_binary(value) do
    process_value(:resource_type, String.to_atom(value))
  end

  defp process_value(:resource_type, value) do
    unless(Enum.member?(@resource_types, value), do: raise(ParseError, message: "#{Atom.to_string(value)} not a valid resource_type"))
  end

  defp process_value(:public_id, value) do
    unless(is_binary(value), do: raise(ParseError, message: "not a valid public_id"))
  end

  defp prepare_request_body(map) do
    map = if is_nil(Map.get(map, :resource_type)) do 
      Map.put(map, :resource_type, @default_resource_type)
    else
      map
    end
    if(is_nil(Application.get_env(:cloudinary_uploader, :api_key)), do: raise(ParseError, message: "cloudinary api_key is not set in application variables"))
    Map.merge(map, 
      %{
      api_key: to_string(Application.get_env(:cloudinary_uploader, :api_key)),
      timestamp: :os.system_time(:second)
      }
    )
  end
end

defmodule CloudinaryUploader.ParseError do
  @type t :: %__MODULE__{message: String.t()}

  defexception message: nil

  def message(%{message: nil}) do
    "ParseError"
  end

  def message(%{message: message}) do
    message
  end 
end
