defimpl Phoenix.Param, for: Flix.Catalogs.Movie do
  def to_param(%{slug: slug}) do
    "#{slug}"
  end
end
