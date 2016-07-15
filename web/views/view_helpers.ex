defmodule ChatUp.ViewHelpers do

  def mtl_label(form, field) do
    Phoenix.HTML.Form.label(form, field, class: is_active(form, field))
  end

  def is_active(form, field) do
    if (Phoenix.HTML.Form.field_value(form, field)) do
      "active"
    end
  end

  def svg_icon(name) do
    "material/#{name}.svg"
    |> read_svg_file()
    |> wrap_svg("material")
    |> safety_string()
  end

  defp safety_string(html) do
    {:safe, html}
  end

  defp wrap_svg(svg_contents, cat) do
    "<i class='#{cat}-svg'>#{svg_contents}</i>"
  end

  defp read_svg_file(icon_path) do
    file_path = Path.join("priv/static/svg/", icon_path)

    case File.read(file_path) do
      {:ok, result} ->
        result
      {:error, _} ->
        "could not read file"
    end
  end
end
