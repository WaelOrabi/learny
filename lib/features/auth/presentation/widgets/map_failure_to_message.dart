import '../../../../core/error/failure.dart';
import '../../../../core/strings/failures.dart';

List<String> mapFailureToMessage(Failure failure) {
  if (failure is WrongDataFailure) {
    print(failure.messages);
    return failure.messages;
  } else if (failure is ServerFailure) {
    print(SERVER_FAILURE_MESSAGE);
    return [SERVER_FAILURE_MESSAGE];
  } else if (failure is OffLineFailure) {
    return [OFFLINE_FAILURE_MESSAGE];
  } else if(failure is EmptyCashFailure) {
    return [EMPTY_CACH_FAILURE_MESSAGE];
  }
  else{
    return ["Unexpected error, Please try again later."];
  }
}