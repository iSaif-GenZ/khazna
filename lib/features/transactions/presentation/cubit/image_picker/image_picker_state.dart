abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}
class ImagePickerLoading extends ImagePickerState {}
class ImagePickerSuccess extends ImagePickerState {
  final String imagePath;
  ImagePickerSuccess(this.imagePath);
}
class ImagePickerFailure extends ImagePickerState {
  final String message;
  ImagePickerFailure(this.message);
}