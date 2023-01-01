class Model {
  Model(this.user);
  String user;
}

class User {
  User(this.name);
  String name;
}

class Artist {
  Artist(this.name);
  String name;
}

class Song {
  Song(this.artist, this.title);
  String title;
  Artist artist;
}

enum MusicGenre { house, funk, hiphop }

class PlaylistKind {
  final String? curatedBy;
  final Artist? basedOnArtist;
  final List<Song>? genres;

  PlaylistKind(this.curatedBy, this.basedOnArtist, this.genres);
}

var fooFighters = Artist('Foo Fighters');
var playlist1 = PlaylistKind('This is Foo Fighters', fooFighters, [
  Song(fooFighters, 'Breakout'),
  Song(fooFighters, 'Learn To Fly'),
]);
var playlist2 = PlaylistKind('Deep Focus', fooFighters, [
  Song(fooFighters, 'Breakout'),
  Song(fooFighters, 'Learn To Fly'),
]);
