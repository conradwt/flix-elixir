# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Flix.Repo.insert!(%Flix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# delete movie records in movies table.
Flix.Repo.delete_all("movies")

alias Flix.Catalogs

movie_data = [
  %{
    title: "Avengers: Endgame",
    description:
      "After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to undo Thanos' actions and restore order to the universe.",
    released_on: "2019-04-26",
    rating: "PG-13",
    total_gross: 1_223_641_414,
    director: "Anthony Russo",
    duration: "181 min",
    main_image: "avengers-end-game.png"
  },
  %{
    title: "Captain Marvel",
    description:
      "Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.",
    released_on: "2019-03-08",
    rating: "PG-13",
    total_gross: 1_110_662_849,
    director: "Anna Boden",
    duration: "124 min",
    main_image: "captain-marvel.png"
  },
  %{
    title: "Black Panther",
    description:
      "T'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country's past.",
    released_on: "2018-02-16",
    rating: "PG-13",
    total_gross: 1_346_913_161,
    director: "Ryan Coogler",
    duration: "134 min",
    main_image: "black-panther.png"
  },
  %{
    title: "Avengers: Infinity War",
    description:
      "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.",
    released_on: "2018-04-27",
    rating: "PG-13",
    total_gross: 2_048_359_754,
    director: "Anthony Russo",
    duration: "149 min",
    main_image: "avengers-infinity-war.png"
  },
  %{
    title: "Green Lantern",
    description:
      "Reckless test pilot Hal Jordan is granted an alien ring that bestows him with otherworldly powers that inducts him into an intergalactic police force, the Green Lantern Corps.",
    released_on: "2011-06-17",
    rating: "PG-13",
    total_gross: 219_851_172,
    director: "Martin Campbell",
    duration: "114 min",
    main_image: "green-lantern.png"
  },
  %{
    title: "Fantastic Four",
    description:
      "Four young outsiders teleport to an alternate and dangerous universe which alters their physical form in shocking ways. The four must learn to harness their new abilities and work together to save Earth from a former friend turned enemy.",
    released_on: "2015-08-07",
    rating: "PG-13",
    total_gross: 168_257_860,
    director: "Josh Trank",
    duration: "100 min",
    main_image: "fantastic-four.png"
  },
  %{
    title: "Iron Man",
    description:
      "When wealthy industrialist Tony Stark is forced to build an armored suit after a life-threatening incident, he ultimately decides to use its technology to fight against evil.",
    released_on: "2008-05-02",
    rating: "PG-13",
    total_gross: 585_366_247,
    director: "Jon Favreau",
    duration: "126 min",
    main_image: "ironman.png"
  },
  %{
    title: "Superman",
    description:
      "An alien orphan is sent from his dying planet to Earth, where he grows up to become his adoptive home's first and greatest super-hero.",
    released_on: "1978-12-15",
    rating: "PG",
    total_gross: 300_451_603,
    director: "Richard Donner",
    duration: "143 min",
    main_image: "superman.png"
  },
  %{
    title: "Spider-Man",
    description:
      "When bitten by a genetically modified spider, a nerdy, shy, and awkward high school student gains spider-like abilities that he eventually must use to fight evil as a superhero after tragedy
  befalls his family.",
    released_on: "2002-05-03",
    rating: "PG-13",
    total_gross: 825_025_036,
    director: "Sam Raimi",
    duration: "121 min",
    main_image: "spiderman.png"
  },
  %{
    title: "Batman",
    description:
      "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.",
    released_on: "1989-06-23",
    rating: "PG-13",
    total_gross: 411_348_924,
    director: "Tim Burton",
    duration: "126 min",
    main_image: "batman.png"
  },
  %{
    title: "Catwoman",
    description:
      "Patience Philips seems destined to spend her life apologizing for taking up space. Despite her artistic ability she has a more than respectable career as a graphic designer.",
    released_on: "2004-07-23",
    rating: "PG-13",
    total_gross: 82_102_379,
    director: "Jean-Christophe 'Pitof' Comar",
    duration: "101 min",
    main_image: "catwoman.png"
  },
  %{
    title: "Wonder Woman",
    description:
      "When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.",
    released_on: "2017-06-02",
    rating: "PG-13",
    total_gross: 821_847_012,
    director: "Patty Jenkins",
    duration: "141 min",
    main_image: "wonder-woman.png"
  }
]

Enum.each(movie_data, fn data ->
  Catalogs.create_movie!(data)
end)

# [
# ['Avengers: Endgame', 'avengers-end-game.png'],
# ['Captain Marvel', 'captain-marvel.png'],
# ['Black Panther', 'black-panther.png'],
# ['Avengers: Infinity War', 'avengers-infinity-war.png'],
# ['Green Lantern', 'green-lantern.png'],
# ['Fantastic Four', 'fantastic-four.png'],
# ['Iron Man', 'ironman.png'],
# ['Superman', 'superman.png'],
# ['Spider-Man', 'spiderman.png'],
# ['Batman', 'batman.png'],
# ['Catwoman', 'catwoman.png'],
# ['Wonder Woman', 'wonder-woman.png']
# ].each do |movie_title, file_name|
# movie = Movie.find_by!(title: movie_title)
# file = File.open(Rails.root.join("app/assets/images/#{file_name}"))
# movie.main_image.attach(io: file, filename: file_name)
# end

#
# or short solution
#

# movie_titles_and_filenames = Movie.pluck(:title, :slug).map do | title, slug |
#   [title, "#{slug}.png"]
# end

# movie_titles_and_filenames.each do |title, file_name|
#   movie = Movie.find_by(title: title)
#   file = File.open(Rails.root.join("app/assets/images/#{file_name}"))
#   movie.main_image.attach(io: file filename: file_name)
