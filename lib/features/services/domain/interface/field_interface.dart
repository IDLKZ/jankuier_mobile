import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/field/field_entity.dart';
import '../../data/entities/field/field_gallery_entity.dart';
import '../../data/entities/field/field_party_entity.dart';
import '../../data/entities/field/field_schedule_record_entity.dart';
import '../parameters/all_field_gallery_parameter.dart';
import '../parameters/all_field_parameter.dart';
import '../parameters/all_field_party_parameter.dart';
import '../parameters/field_party_schedule_preview_parameter.dart';
import '../parameters/paginate_field_parameter.dart';
import '../parameters/paginate_field_party_parameter.dart';

abstract class FieldInterface {
  //Field
  ResultFuture<Pagination<FieldEntity>> paginateField(
      PaginateFieldParameter parameter);

  ResultFuture<List<FieldEntity>> allField(AllFieldParameter parameter);

  ResultFuture<FieldEntity> getField(int fieldId);

  //Field Party
  ResultFuture<Pagination<FieldPartyEntity>> paginateFieldParty(
      PaginateFieldPartyParameter parameter);

  ResultFuture<List<FieldPartyEntity>> allFieldParty(
      AllFieldPartyParameter parameter);

  ResultFuture<FieldPartyEntity> getFieldParty(int fieldPartyId);

  //Field Gallery
  ResultFuture<List<FieldGalleryEntity>> allFieldGallery(
      AllFieldGalleryFilter parameter);

  //Get Field Shedule Preview
  ResultFuture<ScheduleGeneratorResponseEntity> getFieldPartySchedulePreview(
      FieldPartySchedulePreviewParameter parameter);
}