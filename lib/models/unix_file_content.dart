import 'dart:convert';

UnixFileContent unixFileContentFromJson(String str) => UnixFileContent.fromJson(json.decode(str));
String unixFileContentToJson(UnixFileContent data) => json.encode(data.toJson());

class UnixFileContent {
  String content;

  UnixFileContent({
    this.content,
  });

  factory UnixFileContent.fromJson(Map<String, dynamic> json) => UnixFileContent(
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
  };
}
