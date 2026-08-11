
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/domain/usecases/picker_and_crop_image_use_case.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final PickerAndCropImageUseCase pickerAndCropImageUseCase;
  ImagePickerCubit(this.pickerAndCropImageUseCase) : super(ImagePickerInitial());

  Future<void> pickAndCrop() async {
    emit(ImagePickerLoading());
    try {
      final String? path = await pickerAndCropImageUseCase();
      if (path != null) {
        emit(ImagePickerSuccess(path));
      } else {
        emit(ImagePickerInitial());
      }
    } catch (e) {
      emit(ImagePickerFailure(e.toString()));
    }
  }

  void reset() {
    emit(ImagePickerInitial());
  }
}