defmodule FlixWeb.MovieControllerTest do
  use FlixWeb.ConnCase

  alias Flix.Catalogs

  @create_attrs %{description: "some description", director: "some director", duration: "some duration", rating: "some rating", released_on: ~D[2010-04-17], slug: "some slug", title: "some title", total_gross: "120.5"}
  @update_attrs %{description: "some updated description", director: "some updated director", duration: "some updated duration", rating: "some updated rating", released_on: ~D[2011-05-18], slug: "some updated slug", title: "some updated title", total_gross: "456.7"}
  @invalid_attrs %{description: nil, director: nil, duration: nil, rating: nil, released_on: nil, slug: nil, title: nil, total_gross: nil}

  def fixture(:movie) do
    {:ok, movie} = Catalogs.create_movie(@create_attrs)
    movie
  end

  describe "index" do
    test "lists all movies", %{conn: conn} do
      conn = get(conn, Routes.movie_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Movies"
    end
  end

  describe "new movie" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.movie_path(conn, :new))
      assert html_response(conn, 200) =~ "New Movie"
    end
  end

  describe "create movie" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.movie_path(conn, :create), movie: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.movie_path(conn, :show, id)

      conn = get(conn, Routes.movie_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Movie"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.movie_path(conn, :create), movie: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Movie"
    end
  end

  describe "edit movie" do
    setup [:create_movie]

    test "renders form for editing chosen movie", %{conn: conn, movie: movie} do
      conn = get(conn, Routes.movie_path(conn, :edit, movie))
      assert html_response(conn, 200) =~ "Edit Movie"
    end
  end

  describe "update movie" do
    setup [:create_movie]

    test "redirects when data is valid", %{conn: conn, movie: movie} do
      conn = put(conn, Routes.movie_path(conn, :update, movie), movie: @update_attrs)
      assert redirected_to(conn) == Routes.movie_path(conn, :show, movie)

      conn = get(conn, Routes.movie_path(conn, :show, movie))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, movie: movie} do
      conn = put(conn, Routes.movie_path(conn, :update, movie), movie: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Movie"
    end
  end

  describe "delete movie" do
    setup [:create_movie]

    test "deletes chosen movie", %{conn: conn, movie: movie} do
      conn = delete(conn, Routes.movie_path(conn, :delete, movie))
      assert redirected_to(conn) == Routes.movie_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.movie_path(conn, :show, movie))
      end
    end
  end

  defp create_movie(_) do
    movie = fixture(:movie)
    %{movie: movie}
  end
end
