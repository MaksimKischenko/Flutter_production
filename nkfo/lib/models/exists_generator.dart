import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/data/data.dart';

// ignore: avoid_classes_with_only_static_members
class ExistsGenerator {
  static String name(Job job) {
    if (job.jobStatus == 2) {
      return 'Выполнено';
    } else if (job.jobStatus == 1) {
      return 'Выполняется';
    } else if (job.jobStatus == 0) {
      return 'Ошибка';
    }
    return 'Неизвестно';
  }

  static Color? color(Job job) {
    if (job.jobStatus == -2) {
      return Colors.black;
    } else if (job.jobStatus == -1) {
      return Colors.grey;
    } else if (job.jobStatus == 0) {
      return Colors.red;
    } else if (job.jobStatus == 1) {
      return Colors.blue;
    } else if (job.jobStatus == 2) {
      return Colors.green;
    }
    return null;
  }

  static Color? colorJobPart(JobPart jobPart) {
    if (jobPart.jobPartStatus == -2) {
      return Colors.black;
    } else if (jobPart.jobPartStatus == -1) {
      return Colors.grey;
    } else if (jobPart.jobPartStatus == 0) {
      return Colors.red;
    } else if (jobPart.jobPartStatus == 1) {
      return Colors.blue;
    } else if (jobPart.jobPartStatus == 2) {
      return Colors.green;
    }
    return null;
  }

  static String nameJobPart(JobPart jobPart) {
    if (jobPart.jobPartStatus == 2) {
      return 'Выполнено';
    } else if (jobPart.jobPartStatus == 1) {
      return 'Выполняется';
    } else if (jobPart.jobPartStatus == 0) {
      return 'Ошибка';
    }
    return 'Неизвестно';
  }
}
