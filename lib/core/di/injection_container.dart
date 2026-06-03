import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safe_chat/core/network/api_client.dart';
import 'package:safe_chat/core/network/network_info.dart';
import 'package:safe_chat/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safe_chat/features/auth/data/repositories/user_repository_impl.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_cubit.dart';
import 'package:safe_chat/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:safe_chat/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:safe_chat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:safe_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:safe_chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:safe_chat/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:safe_chat/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:safe_chat/features/profile/domain/repositories/profile_repository.dart';
import 'package:safe_chat/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: InternetConnectionChecker.instance),
  );

  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(() => UserAuthCubit(userRepository: sl()));

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerFactory(() => ChatCubit(chatRepository: sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(() => ProfileCubit(profileRepository: sl()));
}
