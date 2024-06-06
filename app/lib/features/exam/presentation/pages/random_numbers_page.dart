import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../cubit/exam_cubit.dart';
import '../cubit/exam_state.dart';

class RandomNumbersPage extends StatelessWidget {
  final int quantity;

  const RandomNumbersPage({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (context, state) {
            if (state is ExamLoaded && state.isInOrder != null) {
              final isInOrder = state.isInOrder!;
              Fluttertoast.showToast(
                msg: isInOrder
                    ? 'Os números estão em ordem!'
                    : 'Os números não estão em ordem!',
                backgroundColor: isInOrder ? Colors.green : Colors.red,
                textColor: Colors.white,
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (ExamLoading):
                return const Center(child: CircularProgressIndicator());
              case const (ExamLoaded):
                final loadedState = state as ExamLoaded;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          context
                              .read<ExamCubit>()
                              .reorderNumbers(oldIndex, newIndex);
                        },
                        children: [
                          for (int index = 0;
                              index < loadedState.numbers.length;
                              index++)
                            ListTile(
                              key: Key('$index'),
                              title:
                                  Text(loadedState.numbers[index].toString()),
                            ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ExamCubit>()
                            .verifyOrder(loadedState.numbers);
                      },
                      child: const Text('Checar ordem'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Solicitar novos números'),
                    ),
                  ],
                );
              case const (ExamError):
                final errorState = state as ExamError;
                return Center(
                    child: Text(
                  errorState.message,
                  textAlign: TextAlign.center,
                ));
              default:
                return const Center(
                    child: Text('Ocorreu um erro ao acesar a tela.'));
            }
          },
        ),
      ),
    );
  }
}
