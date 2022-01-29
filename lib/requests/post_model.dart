class Post {
  late final bool _state;
  late final String? _eror;
  late final String? _fio;
  late final String? _body;

  bool get state => _state;
  String get eror => _eror!;
  String get fio => _fio!;
  String get body => _body!;

  Post.fromJson(Map<String, dynamic> json)
      : _state = json["Successfully"],
        _eror = json['Error'],
        _fio = json['Name'],
        _body = json['QR'];
}
