import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';

import 'package:online_exam_app_v/features/results/presentation/screens/result_screen_details.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/cubit/results_view_mode.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_events.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_states.dart';
import 'package:online_exam_app_v/features/results/presentation/widgets/result_card_widget.dart';

class ResultsListScreen extends StatefulWidget {
  static const routeName = "results-list";

  const ResultsListScreen({super.key});

  @override
  State<ResultsListScreen> createState() => _ResultsListScreenState();
}

class _ResultsListScreenState extends State<ResultsListScreen> {
  late final ResultsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt.get<ResultsViewModel>();
    _viewModel.doEvent(LoadResultsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultsViewModel>(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text("Results")),
        body: BlocBuilder<ResultsViewModel, ResultsStates>(
          builder: (context, state) {
            final isLoading = state.resultsState.isLoading;
            final error = state.resultsState.errorMessage;
            final results = state.resultsState.data ?? [];

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (error != null) {
              return Center(child: Text(error));
            }

            if (results.isEmpty) {
              return const Center(child: Text("No Results Found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];

                return ResultCardWidget(
                  result: result,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ResultsDetailsScreen.routeName,
                      arguments: result,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
