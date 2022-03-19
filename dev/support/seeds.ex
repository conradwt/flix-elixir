defmodule Flix.Seeds do
  import Ecto.Query

  alias Flix.Accounts
  alias Flix.Accounts.User
  alias Flix.Accounts.UserToken
  alias Flix.Catalogs
  alias Flix.Catalogs.Genre
  alias Flix.Repo

  def run do
    # reset database

    reset()

    # create users

    create_users()

    # create genres

    create_genres()

    # create movies

    create_movies()
  end

  defp reset() do
    Flix.Repo.delete_all("movies")
    Flix.Repo.delete_all("genres")
    Flix.Repo.delete_all("users")
  end

  defp create_users() do
    user_data = [
      %{
          name: "Conrad Taylor",
          username: "conradwt",
          email: "conradwt@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Chief",
          username: "chief",
          email: "chief@example",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Cyborg",
          username: "cyborg",
          email: "cyborg@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Crazy Jane",
          username: "jane",
          email: "jane@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Larry Trainor",
          username: "larryt",
          email: "larryt@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Rita Farr",
          username: "ritaf",
          email: "ritaf@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Cliff Steele",
          username: "cliffs",
          email: "cliffs@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      },
      %{
          name: "Negative Man",
          username: "negativem",
          email: "negativem@example.com",
          password: "1qaz2wsx3edc",
          password_confirmation: "1qaz2wsx3edc"
      }
    ]

    Enum.each(user_data, fn data ->
      {:ok, user} = Accounts.register_user(data)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:user, User.confirm_changeset(user))
      |> Ecto.Multi.delete_all(:tokens, UserToken.user_and_contexts_query(user, ["confirm"]))
    end)
  end

  defp create_genres() do
    genre_data = ["Action", "Adventure", "Comedy", "Drama", "Sci-Fi"]

    Enum.each(genre_data, fn data ->
      Catalogs.create_genre!(%{name: data})
    end)
  end

  defp get_genres() do
    query =
      from(g in Genre,
        where: g.name in ["Action", "Adventure", "Sci-Fi"],
        order_by: g.name,
        select: g.id)

    Repo.all(query)
  end

  defp create_movies() do
    movie_data = [
      %{
        description:
        "After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.",
        director: "Anthony Russo",
        duration: "181 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/avengers-end-game.png"
        },
        rating: "PG-13",
        released_on: "2019-04-26",
        title: "My Avengers: Endgame",
        total_gross: 1_223_641_414
      },
      %{
        description:
        "Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.",
        director: "Anna Boden",
        duration: "124 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/captain-marvel.png"
        },
        rating: "PG-13",
        released_on: "2019-03-08",
        title: "Captain Marvel",
        total_gross: 1_110_662_849
      },
      %{
        description:
        "T'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country's past.",
        director: "Ryan Coogler",
        duration: "134 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/black-panther.png"
        },
        rating: "PG-13",
        released_on: "2018-02-16",
        title: "Black Panther",
        total_gross: 1_346_913_161
      },
      %{
        description:
        "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.",
        director: "Anthony Russo",
        duration: "149 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/avengers-infinity-war.png"
        },
        rating: "PG-13",
        released_on: "2018-04-27",
        title: "Avengers: Infinity War",
        total_gross: 2_048_359_754
      },
      %{
        description:
        "Reckless test pilot Hal Jordan is granted an alien ring that bestows him with otherworldly powers that inducts him into an intergalactic police force, the Green Lantern Corps.",
        director: "Martin Campbell",
        duration: "114 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/green-lantern.png"
        },
        rating: "PG-13",
        released_on: "2011-06-17",
        title: "Green Lantern",
        total_gross: 219_851_172
      },
      %{
        description:
        "Four young outsiders teleport to an alternate and dangerous universe which alters their physical form in shocking ways. The four must learn to harness their new abilities and work together to save Earth from a former friend turned enemy.",
        director: "Josh Trank",
        duration: "100 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/fantastic-four.png"
        },
        rating: "PG-13",
        released_on: "2015-08-07",
        title: "Fantastic Four",
        total_gross: 168_257_860
      },
      %{
        description:
        "When wealthy industrialist Tony Stark is forced to build an armored suit after a life-threatening incident, he ultimately decides to use its technology to fight against evil.",
        director: "Jon Favreau",
        duration: "126 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/ironman.png"
        },
        rating: "PG-13",
        released_on: "2008-05-02",
        title: "Iron Man",
        total_gross: 585_366_247
      },
      %{
        description:
        "An alien orphan is sent from his dying planet to Earth, where he grows up to become his adoptive home's first and greatest super-hero.",
        director: "Richard Donner",
        duration: "143 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/superman.png"
        },
        rating: "PG",
        released_on: "1978-12-15",
        title: "Superman",
        total_gross: 300_451_603
      },
      %{
        description:
        "When bitten by a genetically modified spider, a nerdy, shy, and awkward high school student gains spider-like abilities that he eventually must use to fight evil as a superhero after tragedy
        befalls his family.",
        director: "Sam Raimi",
        duration: "121 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/spiderman.png"
        },
        rating: "PG-13",
        released_on: "2002-05-03",
        title: "Spider-Man",
        total_gross: 825_025_036
      },
      %{
        description:
        "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.",
        director: "Tim Burton",
        duration: "126 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/batman.png"
        },
        rating: "PG-13",
        released_on: "1989-06-23",
        title: "Batman",
        total_gross: 411_348_924
      },
      %{
        description:
        "Patience Philips seems destined to spend her life apologizing for taking up space. Despite her artistic ability she has a more than respectable career as a graphic designer.",
        director: "Jean-Christophe 'Pitof' Comar",
        duration: "101 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/catwoman.png"
        },
        rating: "PG-13",
        released_on: "2004-07-23",
        title: "Catwoman",
        total_gross: 82_102_379
      },
      %{
        description:
        "When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.",
        director: "Patty Jenkins",
        duration: "141 min",
        genres: get_genres(),
        main_image: %Plug.Upload{
          content_type: "image/png",
          filename: "avengers-end-game.png",
          path: "#{File.cwd!()}/assets/static/images/wonder-woman.png"
        },
        rating: "PG-13",
        released_on: "2017-06-02",
        title: "Wonder Woman",
        total_gross: 821_847_012
      }
    ]

    Enum.each(movie_data, fn data ->
      Catalogs.create_movie(data)
    end)
  end
end
