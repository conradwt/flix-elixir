defmodule FlixWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  import_types(FlixWeb.GraphQL.Types.Custom.UUID4)

  import_types(FlixWeb.GraphQL.Types.{
    Genre,
    Movie,
    Review,
    Session,
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

  import_types(FlixWeb.GraphQL.Schemas.Mutations.{
    Accounts
  })

  mutation do
    import_fields(:user_mutations)
  end
end
