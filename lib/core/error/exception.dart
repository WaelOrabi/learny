// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmptyCashException implements Exception {}

class WrongDataException implements Exception {
  List<String> messages;
  WrongDataException({
    required this.messages,
  });
}

class ServerException implements Exception {}

class OffLineException implements Exception {}
class EmptyCacheException implements Exception {}
