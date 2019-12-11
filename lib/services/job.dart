import 'dart:async';
import 'dart:convert';

import 'package:zowe_flutter/models/job.dart';
import 'package:zowe_flutter/models/job_file.dart';
import 'package:zowe_flutter/models/job_file_content.dart';
import 'package:zowe_flutter/models/job_step.dart';
import 'package:zowe_flutter/services/services.dart';

class JobService {
  /// List of jobs.
  Future<List<Job>> getJobs() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return jsonBody.map((Map model) => Job.fromJson(model));
  }

  /// Get details of a job
  Future<Job> getJob(String jobName, String jobId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}/$jobName/$jobId';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return Job.fromJson(jsonBody);
  }

  /// Cancel a job and purge it.
  Future<bool> purgeJob(String jobName, String jobId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}/$jobName/$jobId';
    var response = await ApiService.ioClient.delete(url, headers: headers);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  /// Get output file names for a job
  Future<List<JobFile>> getJobFiles(String jobName, String jobId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}/$jobName/$jobId/files';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return jsonBody.map((Map model) => JobFile.fromJson(model));
  }

  /// Get output file content
  Future<JobFileContent> getJobFileContent(String jobName, String jobId, String fileId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}/$jobName/$jobId/files/$fileId/content';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return JobFileContent.fromJson(jsonBody);
  }

  /// Get step name and executed program for each job step
  Future<List<JobStep>> getJobSteps(String jobName, String jobId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.JOB_ENDPOINT}/$jobName/$jobId/steps';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return jsonBody.map((Map model) => JobStep.fromJson(model));
  }

  /// Submit a job from a data set
  Future<Job> submitJobDataSet(String dataSetName) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    var data = {
      'file': dataSetName
    };
    String dataJson = json.encode(data);

    final url = '${ApiService.JOB_ENDPOINT}/datasets';
    var response = await ApiService.ioClient.post(url, headers: headers, body: dataJson);
    
    bool success = response.statusCode == 200 || response.statusCode == 201;

    if (success) {
      return Job.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  /// Submit a job from a string
  Future<Job> submitJobString(String jcl) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    var data = {
      'jcl': jcl
    };
    String dataJson = json.encode(data);

    final url = '${ApiService.JOB_ENDPOINT}/string';
    var response = await ApiService.ioClient.post(url, headers: headers, body: dataJson);
    bool success = response.statusCode == 200 || response.statusCode == 201;

    if (success) {
      return Job.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
