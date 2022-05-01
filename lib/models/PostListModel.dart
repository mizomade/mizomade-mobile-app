class PostListModel {
  int count;
  String next;
  Null previous;
  List<Results> results;

  PostListModel({this.count, this.next, this.previous, this.results});

  PostListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  String title;
  String author;
  String slug;
  String coverimage;
  String date;
  String authorphoto;

  Results(
      {this.id,
        this.title,
        this.author,
        this.slug,
        this.coverimage,
        this.date,
        this.authorphoto});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    slug = json['slug'];
    coverimage = json['coverimage'];
    date = json['date'];
    authorphoto = json['authorphoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['slug'] = this.slug;
    data['coverimage'] = this.coverimage;
    data['date'] = this.date;
    data['authorphoto'] = this.authorphoto;
    return data;
  }
}
