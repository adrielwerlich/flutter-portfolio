class Movie {
  final int id;
  final String title;
  final String image;
  final String display;
  final double imdb;
  final String gendres;
  final String desc;

  Movie({
    required this.id,
    required this.title,
    required this.image,
    required this.display,
    required this.imdb,
    required this.gendres,
    required this.desc,
  });

  List<Movie> get movieData => [
        Movie(
            id: 1,
            title: "Alien: Covenant",
            image: "assets/images/alient_covenant.jpg",
            display: "3D",
            imdb: 6.5,
            gendres: "Mystery, Sci-fi",
            desc:
                "Bound for a remote planet on the far side of the galaxy, members (Katherine Waterston, Billy Crudup) of the colony ship Covenant discover what they think to be an uncharted paradise."),
        Movie(
            id: 2,
            title: "Blade Runner 2049",
            image: "assets/images/blade_runner.jpg",
            display: "3D",
            imdb: 8,
            gendres: "Mystery, Sci-fi",
            desc:
                "Officer K (Ryan Gosling), a new blade runner for the Los Angeles Police Department, unearths a long-buried secret that has the potential to plunge what's left of society into chaos."),
        Movie(
            id: 3,
            title: "Aladdin",
            image: "assets/images/aladdin.jpg",
            display: "3D",
            imdb: 7.4,
            gendres: "Fantasy, Romance",
            desc:
                "Aladdin is a lovable street urchin who meets Princess Jasmine, the beautiful daughter of the sultan of Agrabah. While visiting her exotic palace, Aladdin stumbles upon a magic oil lamp."),
        Movie(
            id: 4,
            title: "Avengers: Endgame",
            image: "assets/images/avengers_endgame.jpg",
            display: "3D",
            imdb: 8.7,
            gendres: "Fantasy, Sci-fi",
            desc:
                "Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle."),
        Movie(
            id: 5,
            title: "John Wick: Parabellum",
            image: "assets/images/john_wick.jpg",
            display: "3D",
            imdb: 8,
            gendres: "Thriller, Mystery",
            desc:
                "After gunning down a member of the High Table -- the shadowy international assassin's guild -- legendary hit man John Wick finds himself stripped of the organization's protective services."),
      ];
}
