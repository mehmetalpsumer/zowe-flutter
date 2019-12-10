import 'dart:convert';

DataSetContent dataSetContentFromJson(String str) => DataSetContent.fromJson(json.decode(str));
String dataSetContentToJson(DataSetContent data) => json.encode(data.toJson());

class DataSetContent {
  String records;

  DataSetContent({
    this.records,
  });

  factory DataSetContent.fromJson(Map<String, dynamic> json) => DataSetContent(
    records: json["records"],
  );

  Map<String, dynamic> toJson() => {
    "records": records,
  };
}
