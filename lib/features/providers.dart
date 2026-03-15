
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/core/di/injection_container.dart';
import 'package:safe_chat/features/auth/presentation/logic/cubit/user_auth_cubit.dart';
import 'package:safe_chat/features/auth/provider.dart';


List<BlocProvider> appProviders = [
BlocProvider<UserAuthCubit>(create: (_) => sl<UserAuthCubit>()),
];