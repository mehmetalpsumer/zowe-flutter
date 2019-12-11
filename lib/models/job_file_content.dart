import 'dart:convert';

JobFileContent jobFileContentFromJson(String str) =>
    JobFileContent.fromJson(json.decode(str));
String jobFileContentToJson(JobFileContent data) => json.encode(data.toJson());

class JobFileContent {
  String content;

  JobFileContent({
    this.content,
  });

  factory JobFileContent.fromJson(Map<String, dynamic> json) => JobFileContent(
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}
