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
              return _EmptyState(
                icon: Icons.error_outline_rounded,
                iconColor: Theme.of(context).colorScheme.error,
                title: "Something went wrong",
                subtitle: error,
              );
            }

            if (results.isEmpty) {
              return _EmptyState(
                icon: Icons.fact_check_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                title: "No Results Yet",
                subtitle:
                    "Once you complete an exam, your results will show up here.",
              );
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

/// A centered, friendly placeholder used for both the "no results" and
/// "error" states, so an empty results list doesn't just show a single
/// line of plain text in the middle of the screen.
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44, color: iconColor),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
