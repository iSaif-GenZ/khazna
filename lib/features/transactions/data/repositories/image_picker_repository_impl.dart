import 'package:khazna/features/transactions/data/datasources/image_picker_local_data_source.dart';
import 'package:khazna/features/transactions/domain/repositories/image_picker_repository.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePickerLocalDataSource localDataSource;
  ImagePickerRepositoryImpl(this.localDataSource);

  @override
  Future<String?> pickerAndCropImage() async {
    return await localDataSource.pickerAndCropImage();
  }
}
