import 'package:equatable/equatable.dart';

class TicketonSeatEntity extends Equatable {
  final int? id;
  final int? level;
  final dynamic row; // String or int
  final dynamic num; // String or int
  final dynamic x; // String or int
  final dynamic y; // String or int
  final dynamic w; // String or int
  final dynamic h; // String or int
  final int? rot;
  final String? type;
  final int? sale;
  final int? status;
  final int? count;
  final int? busy;

  const TicketonSeatEntity({
    this.id,
    this.level,
    this.row,
    this.num,
    this.x,
    this.y,
    this.w,
    this.h,
    this.rot,
    this.type,
    this.sale,
    this.status,
    this.count,
    this.busy,
  });

  factory TicketonSeatEntity.fromJson(Map<String, dynamic> json) {
    return TicketonSeatEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      level: json['level'] is int ? json['level'] : int.tryParse(json['level']?.toString() ?? ''),
      row: json['row'],
      num: json['num'],
      x: json['x'],
      y: json['y'],
      w: json['w'],
      h: json['h'],
      rot: json['rot'] is int ? json['rot'] : int.tryParse(json['rot']?.toString() ?? ''),
      type: json['type'],
      sale: json['sale'] is int ? json['sale'] : int.tryParse(json['sale']?.toString() ?? ''),
      status: json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? ''),
      count: json['count'] is int ? json['count'] : int.tryParse(json['count']?.toString() ?? ''),
      busy: json['busy'] is int ? json['busy'] : int.tryParse(json['busy']?.toString() ?? ''),
    );
  }

  @override
  List<Object?> get props =>
      [id, level, row, num, x, y, w, h, rot, type, sale, status, count, busy];
}

class TicketonObjectEntity extends Equatable {
  final int? id;
  final int? level;
  final String? name;
  final dynamic type; // String or bool
  final int? x;
  final int? y;
  final int? w;
  final int? h;
  final String? color;
  final dynamic map; // Dict or String
  final String? svg;
  final String? svgText;
  final String? svgTextAttrs;

  const TicketonObjectEntity({
    this.id,
    this.level,
    this.name,
    this.type,
    this.x,
    this.y,
    this.w,
    this.h,
    this.color,
    this.map,
    this.svg,
    this.svgText,
    this.svgTextAttrs,
  });

  factory TicketonObjectEntity.fromJson(Map<String, dynamic> json) {
    return TicketonObjectEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      level: json['level'] is int ? json['level'] : int.tryParse(json['level']?.toString() ?? ''),
      name: json['name'],
      type: json['type'],
      x: json['x'] is int ? json['x'] : int.tryParse(json['x']?.toString() ?? ''),
      y: json['y'] is int ? json['y'] : int.tryParse(json['y']?.toString() ?? ''),
      w: json['w'] is int ? json['w'] : int.tryParse(json['w']?.toString() ?? ''),
      h: json['h'] is int ? json['h'] : int.tryParse(json['h']?.toString() ?? ''),
      color: json['color'],
      map: json['map'],
      svg: json['svg'],
      svgText: json['svg_text'],
      svgTextAttrs: json['svg_text_attrs'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        level,
        name,
        type,
        x,
        y,
        w,
        h,
        color,
        map,
        svg,
        svgText,
        svgTextAttrs
      ];
}

class TicketonHallLevelEntity extends Equatable {
  final int? id;
  final String? name;
  final int? width;
  final int? height;
  final int? unboundSeats;
  final int? lazyLoading;
  final int? sizeRatio;
  final dynamic map; // Dict or String
  final String? svg;
  final String? svgText;
  final String? svgTextAttrs;
  final String? color;
  final List<TicketonSeatEntity>? seats;
  final List<TicketonObjectEntity>? objects;
  final dynamic types; // List<Dict>, List<String>, String, or Dict
  final int? seatsCount;
  final int? seatsFree;
  final int? displayNum;

  const TicketonHallLevelEntity({
    this.id,
    this.name,
    this.width,
    this.height,
    this.unboundSeats,
    this.lazyLoading,
    this.sizeRatio,
    this.map,
    this.svg,
    this.svgText,
    this.svgTextAttrs,
    this.color,
    this.seats,
    this.objects,
    this.types,
    this.seatsCount,
    this.seatsFree,
    this.displayNum,
  });

  factory TicketonHallLevelEntity.fromJson(Map<String, dynamic> json) {
    return TicketonHallLevelEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      name: json['name'],
      width: json['width'] is int ? json['width'] : int.tryParse(json['width']?.toString() ?? ''),
      height: json['height'] is int ? json['height'] : int.tryParse(json['height']?.toString() ?? ''),
      unboundSeats: json['unbound_seats'] is int ? json['unbound_seats'] : int.tryParse(json['unbound_seats']?.toString() ?? ''),
      lazyLoading: json['lazy_loading'] is int ? json['lazy_loading'] : int.tryParse(json['lazy_loading']?.toString() ?? ''),
      sizeRatio: json['size_ratio'] is int ? json['size_ratio'] : int.tryParse(json['size_ratio']?.toString() ?? ''),
      map: json['map'],
      svg: json['svg'],
      svgText: json['svg_text'],
      svgTextAttrs: json['svg_text_attrs'],
      color: json['color'],
      seats: json['seats'] != null
          ? List<TicketonSeatEntity>.from(
              json['seats'].map((x) => TicketonSeatEntity.fromJson(x)))
          : null,
      objects: json['objects'] != null
          ? List<TicketonObjectEntity>.from(
              json['objects'].map((x) => TicketonObjectEntity.fromJson(x)))
          : null,
      types: json['types'],
      seatsCount: json['seats_count'] is int ? json['seats_count'] : int.tryParse(json['seats_count']?.toString() ?? ''),
      seatsFree: json['seats_free'] is int ? json['seats_free'] : int.tryParse(json['seats_free']?.toString() ?? ''),
      displayNum: json['display_num'] is int ? json['display_num'] : int.tryParse(json['display_num']?.toString() ?? ''),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        width,
        height,
        unboundSeats,
        lazyLoading,
        sizeRatio,
        map,
        svg,
        svgText,
        svgTextAttrs,
        color,
        seats,
        objects,
        types,
        seatsCount,
        seatsFree,
        displayNum
      ];
}

class TicketonHallEntity extends Equatable {
  final int? id;
  final int? place;
  final String? name;
  final Map<String, TicketonHallLevelEntity>? levels;

  const TicketonHallEntity({
    this.id,
    this.place,
    this.name,
    this.levels,
  });

  factory TicketonHallEntity.fromJson(Map<String, dynamic> json) {
    Map<String, TicketonHallLevelEntity>? levels;
    if (json['levels'] != null) {
      levels = {};
      json['levels'].forEach((key, value) {
        levels![key] = TicketonHallLevelEntity.fromJson(value);
      });
    }

    return TicketonHallEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      place: json['place'] is int ? json['place'] : int.tryParse(json['place']?.toString() ?? ''),
      name: json['name'],
      levels: levels,
    );
  }

  @override
  List<Object?> get props => [id, place, name, levels];
}

class TicketonCityEntity extends Equatable {
  final int? id;
  final String? name;

  const TicketonCityEntity({
    this.id,
    this.name,
  });

  factory TicketonCityEntity.fromJson(Map<String, dynamic> json) {
    return TicketonCityEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class TicketonPlaceEntity extends Equatable {
  final int? id;
  final int? cityId;
  final int? kinokzId;
  final String? name;
  final String? namefull;
  final String? address;
  final String? remark;
  final String? description;
  final String? driver;

  const TicketonPlaceEntity({
    this.id,
    this.cityId,
    this.kinokzId,
    this.name,
    this.namefull,
    this.address,
    this.remark,
    this.description,
    this.driver,
  });

  factory TicketonPlaceEntity.fromJson(Map<String, dynamic> json) {
    return TicketonPlaceEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      cityId: json['city_id'] is int ? json['city_id'] : int.tryParse(json['city_id']?.toString() ?? ''),
      kinokzId: json['kinokz_id'] is int ? json['kinokz_id'] : int.tryParse(json['kinokz_id']?.toString() ?? ''),
      name: json['name'],
      namefull: json['namefull'],
      address: json['address'],
      remark: json['remark'],
      description: json['description'],
      driver: json['driver'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        cityId,
        kinokzId,
        name,
        namefull,
        address,
        remark,
        description,
        driver
      ];
}

class TicketonEventEntity extends Equatable {
  final int? id;
  final int? duration;
  final int? kinokzId;
  final String? fcsk;
  final String? type;
  final String? name;
  final String? genre;
  final String? nameRu;
  final String? remark;

  const TicketonEventEntity({
    this.id,
    this.duration,
    this.kinokzId,
    this.fcsk,
    this.type,
    this.name,
    this.genre,
    this.nameRu,
    this.remark,
  });

  factory TicketonEventEntity.fromJson(Map<String, dynamic> json) {
    return TicketonEventEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      duration: json['duration'] is int ? json['duration'] : int.tryParse(json['duration']?.toString() ?? ''),
      kinokzId: json['kinokz_id'] is int ? json['kinokz_id'] : int.tryParse(json['kinokz_id']?.toString() ?? ''),
      fcsk: json['fcsk'],
      type: json['type'],
      name: json['name'],
      genre: json['genre'],
      nameRu: json['nameRu'],
      remark: json['remark'],
    );
  }

  @override
  List<Object?> get props =>
      [id, duration, kinokzId, fcsk, type, name, genre, nameRu, remark];
}

class TicketonShowDataEntity extends Equatable {
  final int? id;
  final int? place;
  final int? hall;
  final int? showcase;
  final int? event;
  final String? sale;
  final int? ts;
  final String? dt;
  final String? isCanceled;
  final int? canceledTs;
  final int? saleFromTs;
  final int? maxSelection;
  final int? ticketsToOneHands;
  final String? name;
  final String? isNativeWidget;
  final String? sessionFormat;
  final String? sessionId;
  final String? label;
  final String? lang;
  final String? format;

  const TicketonShowDataEntity({
    this.id,
    this.place,
    this.hall,
    this.showcase,
    this.event,
    this.sale,
    this.ts,
    this.dt,
    this.isCanceled,
    this.canceledTs,
    this.saleFromTs,
    this.maxSelection,
    this.ticketsToOneHands,
    this.name,
    this.isNativeWidget,
    this.sessionFormat,
    this.sessionId,
    this.label,
    this.lang,
    this.format,
  });

  factory TicketonShowDataEntity.fromJson(Map<String, dynamic> json) {
    return TicketonShowDataEntity(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      place: json['place'] is int ? json['place'] : int.tryParse(json['place']?.toString() ?? ''),
      hall: json['hall'] is int ? json['hall'] : int.tryParse(json['hall']?.toString() ?? ''),
      showcase: json['showcase'] is int ? json['showcase'] : int.tryParse(json['showcase']?.toString() ?? ''),
      event: json['event'] is int ? json['event'] : int.tryParse(json['event']?.toString() ?? ''),
      sale: json['sale'],
      ts: json['ts'] is int ? json['ts'] : int.tryParse(json['ts']?.toString() ?? ''),
      dt: json['dt'],
      isCanceled: json['is_canceled'],
      canceledTs: json['canceled_ts'] is int ? json['canceled_ts'] : int.tryParse(json['canceled_ts']?.toString() ?? ''),
      saleFromTs: json['sale_from_ts'] is int ? json['sale_from_ts'] : int.tryParse(json['sale_from_ts']?.toString() ?? ''),
      maxSelection: json['max_selection'] is int ? json['max_selection'] : int.tryParse(json['max_selection']?.toString() ?? ''),
      ticketsToOneHands: json['tickets_to_one_hands'] is int ? json['tickets_to_one_hands'] : int.tryParse(json['tickets_to_one_hands']?.toString() ?? ''),
      name: json['name'],
      isNativeWidget: json['is_native_widget'],
      sessionFormat: json['session_format'],
      sessionId: json['session_id'],
      label: json['label'],
      lang: json['lang'],
      format: json['format'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        place,
        hall,
        showcase,
        event,
        sale,
        ts,
        dt,
        isCanceled,
        canceledTs,
        saleFromTs,
        maxSelection,
        ticketsToOneHands,
        name,
        isNativeWidget,
        sessionFormat,
        sessionId,
        label,
        lang,
        format
      ];
}

class TicketonPriceEntity extends Equatable {
  final String? type;
  final double? sum;
  final String? name;
  final String? typeName;
  final int? com;
  final int? promo;
  final dynamic discounts; // List<Dict>, List<String>, or String

  const TicketonPriceEntity({
    this.type,
    this.sum,
    this.name,
    this.typeName,
    this.com,
    this.promo,
    this.discounts,
  });

  factory TicketonPriceEntity.fromJson(Map<String, dynamic> json) {
    try {
      print('💸 Parsing TicketonPriceEntity: ${json.keys.toList()}');

      // Parse sum with detailed logging
      final double? parsedSum;
      if (json['sum'] != null) {
        print('💰 Sum value: ${json['sum']} (type: ${json['sum'].runtimeType})');
        try {
          parsedSum = json['sum'] is num
              ? (json['sum'] as num).toDouble()
              : double.tryParse(json['sum'].toString());
          print('✅ Price sum parsed: $parsedSum');
        } catch (e) {
          print('❌ Error parsing sum ${json['sum']}: $e');
          rethrow;
        }
      } else {
        parsedSum = null;
        print('✅ Price sum is null');
      }

      // Parse other fields
      final int? parsedCom = json['com'] is int ? json['com'] : int.tryParse(json['com']?.toString() ?? '');
      final int? parsedPromo = json['promo'] is int ? json['promo'] : int.tryParse(json['promo']?.toString() ?? '');

      print('✅ TicketonPriceEntity parsed successfully');

      return TicketonPriceEntity(
        type: json['type'],
        sum: parsedSum,
        name: json['name'],
        typeName: json['type_name'],
        com: parsedCom,
        promo: parsedPromo,
        discounts: json['discounts'],
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in TicketonPriceEntity.fromJson: $e');
      print('📋 JSON: $json');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  List<Object?> get props => [type, sum, name, typeName, com, promo, discounts];
}

class TicketonSingleShowResponseEntity extends Equatable {
  final TicketonShowDataEntity? show;
  final dynamic seatValidationRules; // List<Dict>, List<String>, or String
  final TicketonEventEntity? event;
  final TicketonPlaceEntity? place;
  final TicketonCityEntity? city;
  final TicketonHallEntity? hall;
  final Map<String, TicketonPriceEntity>? prices;

  const TicketonSingleShowResponseEntity({
    this.show,
    this.seatValidationRules,
    this.event,
    this.place,
    this.city,
    this.hall,
    this.prices,
  });

  factory TicketonSingleShowResponseEntity.fromJson(Map<String, dynamic> json) {
    try {
      print('🎭 Parsing TicketonSingleShowResponseEntity');

      Map<String, TicketonPriceEntity>? prices;
      if (json['prices'] != null) {
        print('💰 Parsing prices: ${json['prices'].keys.toList()}');
        prices = {};
        json['prices'].forEach((key, value) {
          try {
            print('💱 Parsing price $key: $value');
            prices![key] = TicketonPriceEntity.fromJson(value);
            print('✅ Price $key parsed successfully');
          } catch (e) {
            print('❌ Error parsing price $key: $e');
            print('🔍 Price data: $value');
            rethrow;
          }
        });
      }

      return TicketonSingleShowResponseEntity(
        show: json['show'] != null
            ? TicketonShowDataEntity.fromJson(json['show'])
            : null,
        seatValidationRules: json['seatValidationRules'],
        event: json['event'] != null
            ? TicketonEventEntity.fromJson(json['event'])
            : null,
        place: json['place'] != null
            ? TicketonPlaceEntity.fromJson(json['place'])
            : null,
        city: json['city'] != null
            ? TicketonCityEntity.fromJson(json['city'])
            : null,
        hall: json['hall'] != null
            ? TicketonHallEntity.fromJson(json['hall'])
            : null,
        prices: prices,
      );
    } catch (e, stackTrace) {
      print('❌ CRITICAL ERROR in TicketonSingleShowResponseEntity.fromJson: $e');
      print('📋 JSON keys: ${json.keys.toList()}');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  List<Object?> get props =>
      [show, seatValidationRules, event, place, city, hall, prices];
}
