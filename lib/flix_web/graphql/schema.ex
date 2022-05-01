defmodule FlixWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(FlixWeb.GraphQL.Types.{
    Genre,
    Movie,
    Review,
    User
  })

  import_types(FlixWeb.GraphQL.Schemas.Queries.{
    Movie,
    User
  })

  query do
    import_fields(:movie_queries)
    import_fields(:user_queries)
  end
end
