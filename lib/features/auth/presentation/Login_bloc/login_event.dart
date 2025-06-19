import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {

}
final class LoginSubmittedEvent extends LoginEvent{
final String username;
final String password;
LoginSubmittedEvent({
  required this.username,
  required this.password
});
@override
List<Object?> get props=>[username,password];
}