import 'package:khazna/features/transactions/domain/repositories/image_picker_repository.dart';

class PickerAndCropImageUseCase {
  final ImagePickerRepository repository;
  PickerAndCropImageUseCase(this.repository);

  Future<String?> call() async {
    return await repository.pickerAndCropImage();
  }
}