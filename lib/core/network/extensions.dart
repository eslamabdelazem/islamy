import 'dart:io';

import 'package:dio/dio.dart';
import 'backend_configuation.dart';
import 'network_request.dart';

extension NetworkRequestExtension on NetworkRequest {
  bool get _canBeConvertedToFormData =>
      hasBodyAndProgress() && body != null && body!.entries.isNotEmpty;

  bool hasBodyAndProgress() =>
      method == RequestMethod.post ||
      method == RequestMethod.put ||
      method == RequestMethod.patch ||
      method == RequestMethod.delete;

  String asString() {
    return method.toString().split('.').last.toUpperCase();
  }

  Future<void> prepareRequestData() async {
    if (_canBeConvertedToFormData) {
      final entries = body!.entries.toList();
      for (var i = 0; i < entries.length; i++) {
        final value = entries[i].value;
        if (value is File) {
          isFormData = true;
          body![entries[i].key] = value.toMultiPart();
        } else if (value is List<File>) {
          isFormData = true;
          body![entries[i].key] = value.toMultiPart();
        }
      }
    }
  }
}

extension MultiPartFileConverter on File {
  MultipartFile toMultiPart() {
    return MultipartFile.fromFileSync(path, contentType: BackendConfiguation.type.isPhp ? getTypeOfFile() : null);
  }
}

extension MultiPartFileListConverter on List<File> {
  List<MultipartFile> toMultiPart() {
    final List<MultipartFile> multipartFiles = [];
    for (final file in this) {
      multipartFiles.add(file.toMultiPart());
    }
    return multipartFiles;
  }
}

extension MediaTypeHelper on File {
  DioMediaType getTypeOfFile() {
    final type = path.split('.').last;
    switch (type) {
      case 'jpg':
      case 'jpeg':
        return DioMediaType('image', 'jpeg');
      case 'png':
        return DioMediaType('image', 'png');
      case 'gif':
        return DioMediaType('image', 'gif');
      case 'bmp':
        return DioMediaType('image', 'bmp');
      case 'webp':
        return DioMediaType('image', 'webp');
      case 'svg':
        return DioMediaType('image', 'svg+xml');
      case 'pdf':
        return DioMediaType('application', 'pdf');
      case 'zip':
        return DioMediaType('application', 'zip');
      case 'rar':
        return DioMediaType('application', 'x-rar-compressed');
      case 'tar':
        return DioMediaType('application', 'x-tar');
      case 'gz':
        return DioMediaType('application', 'x-gzip');
      case 'bz2':
        return DioMediaType('application', 'x-bzip2');
      case '7z':
        return DioMediaType('application', 'x-7z-compressed');
      case 'doc':
        return DioMediaType('application', 'msword');
      case 'docx':
        return DioMediaType('application',
            'vnd.openxmlformats-officedocument.wordprocessingml.document');
      case 'xls':
        return DioMediaType('application', 'vnd.ms-excel');
      case 'xlsx':
        return DioMediaType('application',
            'vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      case 'ppt':
        return DioMediaType('application', 'vnd.ms-powerpoint');
      case 'pptx':
        return DioMediaType('application',
            'vnd.openxmlformats-officedocument.presentationml.presentation');
      case 'txt':
        return DioMediaType('text', 'plain');
      case 'rtf':
        return DioMediaType('application', 'rtf');
      case 'csv':
        return DioMediaType('text', 'csv');
      case 'html':
        return DioMediaType('text', 'html');
      case 'xml':
        return DioMediaType('text', 'xml');
      case 'json':
        return DioMediaType('application', 'json');
      case 'mp3':
        return DioMediaType('audio', 'mpeg');
      case 'wav':
        return DioMediaType('audio', 'wav');
      case 'wma':
        return DioMediaType('audio', 'x-ms-wma');
      case 'mp4':
        return DioMediaType('video', 'mp4');
      case 'mkv':
        return DioMediaType('video', 'x-matroska');
      case 'avi':
        return DioMediaType('video', 'x-msvideo');
      case 'flv':
        return DioMediaType('video', 'x-flv');
      case 'mov':
        return DioMediaType('video', 'quicktime');
      case 'wmv':
        return DioMediaType('video', 'x-ms-wmv');
      case 'webm':
        return DioMediaType('video', 'webm');
      default:
        return DioMediaType('application', 'octet-stream');
    }
  }
}


