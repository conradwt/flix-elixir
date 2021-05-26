defmodule FlixWeb.Graphql.Schema do
  use Absinthe.Schema

  import_types(FlixWeb.Graphql.Types.{
    Genre,
    Movie,
    Review,
    User
  })

  import_types(FlixWeb.Graphql.Schemas.Queries.{
    Movie,
    User
  })

  query do
    import_fields :movie_queries
    import_fields :user_queries
  end
end
