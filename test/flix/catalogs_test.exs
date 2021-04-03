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

  describe "reviews" do
    alias Flix.Catalogs.Review

    @valid_attrs %{comment: "some comment", name: "some name", stars: 42}
    @update_attrs %{comment: "some updated comment", name: "some updated name", stars: 43}
    @invalid_attrs %{comment: nil, name: nil, stars: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalogs.create_review()

      review
    end

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Catalogs.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Catalogs.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = Catalogs.create_review(@valid_attrs)
      assert review.comment == "some comment"
      assert review.name == "some name"
      assert review.stars == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalogs.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, %Review{} = review} = Catalogs.update_review(review, @update_attrs)
      assert review.comment == "some updated comment"
      assert review.name == "some updated name"
      assert review.stars == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalogs.update_review(review, @invalid_attrs)
      assert review == Catalogs.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Catalogs.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Catalogs.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Catalogs.change_review(review)
    end
  end

  describe "genres" do
    alias Flix.Catalogs.Genre

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def genre_fixture(attrs \\ %{}) do
      {:ok, genre} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalogs.create_genre()

      genre
    end

    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Catalogs.list_genres() == [genre]
    end

    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Catalogs.get_genre!(genre.id) == genre
    end

    test "create_genre/1 with valid data creates a genre" do
      assert {:ok, %Genre{} = genre} = Catalogs.create_genre(@valid_attrs)
      assert genre.name == "some name"
    end

    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalogs.create_genre(@invalid_attrs)
    end

    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{} = genre} = Catalogs.update_genre(genre, @update_attrs)
      assert genre.name == "some updated name"
    end

    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalogs.update_genre(genre, @invalid_attrs)
      assert genre == Catalogs.get_genre!(genre.id)
    end

    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Catalogs.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Catalogs.get_genre!(genre.id) end
    end

    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Catalogs.change_genre(genre)
    end
  end
end
