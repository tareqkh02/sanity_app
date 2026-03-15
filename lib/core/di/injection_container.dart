import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safe_chat/features/auth/data/datasources/auth_remote_datasours.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository_impl.dart';
import 'package:safe_chat/features/auth/presentation/logic/cubit/user_auth_cubit.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;

Future<void> init() async {

  
  sl.registerLazySingleton(() => http.Client());
sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDatasoursImp(firebaseAuth: sl()),
  );


   sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => UserAuthCubit(userRepository: sl()));
}
