class User {
  String username;
  String token;

  User({this.username, this.token});

  User.initial()
      : username = '',
        token = '';
}
