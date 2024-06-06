import 'package:exam_app/core/config/routes/named_routes.dart';
import 'package:exam_app/features/exam/domain/usecases/check_order_use_case.dart';
import 'package:exam_app/features/exam/domain/usecases/get_random_numbers_use_case.dart';
import 'package:exam_app/features/exam/presentation/cubit/exam_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../features/exam/presentation/pages/home_page.dart';
import '../../../features/exam/presentation/pages/random_numbers_page.dart';

class AppRoutes {
  static GoRouter router =
      GoRouter(debugLogDiagnostics: kDebugMode ? true : false, routes: [
    GoRoute(
      name: NamedRoutes.home,
      path: NamedRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: NamedRoutes.randomNumbers,
      path: NamedRoutes.randomNumbers,
      builder: (context, state) {
        final quantity = state.extra as int;
        return BlocProvider<ExamCubit>(
          create: (context) => ExamCubit(
              getRandomNumbersUseCase: getIt<GetRandomNumbersUseCase>(),
              checkOrderUseCase: getIt<CheckOrderUseCase>())
            ..fetchRandomNumbers(quantity),
          child: RandomNumbersPage(quantity: quantity),
        );
      },
    ),
  ]);
}
