import 'package:cook_idea_ai/data/datasources/fridge_ai_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final fridgeServiceProvider = Provider((ref) => FridgeAIService());

class RecipeNotifier extends Notifier<AsyncValue<String?>> {
  @override
  AsyncValue<String?> build() => const AsyncData(null); // Initial idle state

  Future<void> scanFridge() async {
    state = const AsyncLoading(); // UI will show a spinner

    try {
      final picker = ImagePicker();
      // Compress the image to save bandwidth and speed up the AI
      final photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        imageQuality: 80,
      );

      if (photo == null) {
        state = const AsyncData(null); // User canceled the camera
        return;
      }

      final service = ref.read(fridgeServiceProvider);
      final result = await service.getRecipesFromImage(photo);

      state = AsyncData(result); // UI will show the recipes!
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // UI will show an error message
    }
  }
}
