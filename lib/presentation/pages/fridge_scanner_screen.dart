import 'package:cook_idea_ai/presentation/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeProvider = NotifierProvider<RecipeNotifier, AsyncValue<String?>>(
  RecipeNotifier.new,
);

class FridgeScannerScreen extends ConsumerWidget {
  const FridgeScannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeState = ref.watch(recipeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Fridge Chef"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // Handle the different states elegantly
                child: recipeState.when(
                  loading: () => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text("Analyzing ingredients... cooking up ideas!"),
                      ],
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Text(
                      "Oops! Something went wrong:\n$error",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  data: (recipes) => recipes == null
                      ? const Center(
                          child: Text(
                            "Tap the camera button to scan your fridge!",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SelectableText(
                            recipes,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button to trigger the camera
      floatingActionButton: FloatingActionButton.extended(
        onPressed: recipeState.isLoading
            ? null // Disable button while loading
            : () => ref.read(recipeProvider.notifier).scanFridge(),
        icon: const Icon(Icons.camera_alt),
        label: const Text("Scan Fridge"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
