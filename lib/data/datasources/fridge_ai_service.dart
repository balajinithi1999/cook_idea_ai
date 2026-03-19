import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class FridgeAIService {
  // We use gemini-1.5-flash as it is optimized for fast multimodal (image+text) tasks
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: const String.fromEnvironment('GEMINI_KEY'),
  );

  Future<String> getRecipesFromImage(XFile image) async {
    final bytes = await image.readAsBytes();

    final prompt = TextPart(
      "You are an expert chef. Look at this photo of a fridge or pantry. "
      "Identify the visible ingredients. Assuming I also have basic staples "
      "(salt, pepper, oil, water), suggest 3 simple, delicious recipes I can make. "
      "Format the output clearly with bold titles, ingredients needed, and brief steps.",
    );
    final imagePart = DataPart('image/jpeg', bytes);

    final response = await model.generateContent([
      Content.multi([prompt, imagePart]),
    ]);

    return response.text ??
        "I couldn't come up with any recipes. Try a clearer photo!";
  }
}
