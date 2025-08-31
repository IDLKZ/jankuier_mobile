import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../data/entities/field/field_gallery_entity.dart';
import '../../parameters/all_field_gallery_parameter.dart';

class AllFieldGalleryCase
    extends UseCaseWithParams<List<FieldGalleryEntity>, AllFieldGalleryFilter> {
  final FieldInterface _fieldInterface;
  const AllFieldGalleryCase(this._fieldInterface);

  @override
  ResultFuture<List<FieldGalleryEntity>> call(AllFieldGalleryFilter params) {
    return _fieldInterface.allFieldGallery(params);
  }
}