defmodule Flix.CatalogsTest do
  use Flix.DataCase

  alias Flix.Catalogs

  describe "movies" do
    alias Flix.Catalogs.Movie

    @valid_attrs %{description: "some description", director: "some director", duration: "some duration", rating: "some rating", released_on: ~D[2010-04-17], slug: "some slug", title: "some title", total_gross: "120.5"}
    @update_attrs %{description: "some updated description", director: "some updated director", duration: "some updated duration", rating: "some updated rating", released_on: ~D[2011-05-18], slug: "some updated slug", title: "some updated title", total_gross: "456.7"}
    @invalid_attrs %{description: nil, director: nil, duration: nil, rating: nil, released_on: nil, slug: nil, title: nil, total_gross: nil}

    def movie_fixture(attrs \\ %{}) do
      {:ok, movie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalogs.create_movie()

      movie
    end

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Catalogs.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Catalogs.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      assert {:ok, %Movie{} = movie} = Catalogs.create_movie(@valid_attrs)
      assert movie.description == "some description"
      assert movie.director == "some director"
      assert movie.duration == "some duration"
      assert movie.rating == "some rating"
      assert movie.released_on == ~D[2010-04-17]
      assert movie.slug == "some slug"
      assert movie.title == "some title"
      assert movie.total_gross == Decimal.new("120.5")
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalogs.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{} = movie} = Catalogs.update_movie(movie, @update_attrs)
      assert movie.description == "some updated description"
      assert movie.director == "some updated director"
      assert movie.duration == "some updated duration"
      assert movie.rating == "some updated rating"
      assert movie.released_on == ~D[2011-05-18]
      assert movie.slug == "some updated slug"
      assert movie.title == "some updated title"
      assert movie.total_gross == Decimal.new("456.7")
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalogs.update_movie(movie, @invalid_attrs)
      assert movie == Catalogs.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Catalogs.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Catalogs.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Catalogs.change_movie(movie)
    end
  end
end
