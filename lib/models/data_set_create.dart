import 'dart:convert';

DataSetCreate dataSetCreateFromJson(String str) =>
    DataSetCreate.fromJson(json.decode(str));

String dataSetCreateToJson(DataSetCreate data) => json.encode(data.toJson());

class DataSetCreate {
  String allocationUnit;
  int averageBlock;
  int blockSize;
  String dataSetOrganization;
  int deviceType;
  int directoryBlocks;
  String name;
  int primary;
  String recordFormat;
  int recordLength;
  int secondary;
  String volumeSerial;

  DataSetCreate({
    this.allocationUnit,
    this.averageBlock,
    this.blockSize,
    this.dataSetOrganization,
    this.deviceType,
    this.directoryBlocks,
    this.name,
    this.primary,
    this.recordFormat,
    this.recordLength,
    this.secondary,
    this.volumeSerial,
  });

  factory DataSetCreate.fromJson(Map<String, dynamic> json) => DataSetCreate(
        allocationUnit: json["allocationUnit"],
        averageBlock: json["averageBlock"],
        blockSize: json["blockSize"],
        dataSetOrganization: json["dataSetOrganization"],
        deviceType: json["deviceType"],
        directoryBlocks: json["directoryBlocks"],
        name: json["name"],
        primary: json["primary"],
        recordFormat: json["recordFormat"],
        recordLength: json["recordLength"],
        secondary: json["secondary"],
        volumeSerial: json["volumeSerial"],
      );

  Map<String, dynamic> toJson() => {
        "allocationUnit": allocationUnit,
        "averageBlock": averageBlock,
        "blockSize": blockSize,
        "dataSetOrganization": dataSetOrganization,
        "deviceType": deviceType,
        "directoryBlocks": directoryBlocks,
        "name": name,
        "primary": primary,
        "recordFormat": recordFormat,
        "recordLength": recordLength,
        "secondary": secondary,
        "volumeSerial": volumeSerial,
      };
}
