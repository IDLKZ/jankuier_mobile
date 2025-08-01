# Руководство по расширению проекта

Это руководство поможет вам добавить новые функции в приложение, следуя принципам Clean Architecture.

## 📋 Содержание

1. [Добавление нового feature](#добавление-нового-feature)
2. [Добавление нового use case](#добавление-нового-use-case)
3. [Добавление нового экрана](#добавление-нового-экрана)
4. [Добавление нового API endpoint](#добавление-нового-api-endpoint)
5. [Добавление новой темы](#добавление-новой-темы)
6. [Добавление локализации](#добавление-локализации)

## 🆕 Добавление нового feature

### Шаг 1: Создание структуры папок

```bash
mkdir -p lib/features/[feature_name]/{data,domain,presentation}
mkdir -p lib/features/[feature_name]/data/{datasources,models,repositories}
mkdir -p lib/features/[feature_name]/domain/{entities,repositories,usecases}
mkdir -p lib/features/[feature_name]/presentation/{bloc,pages,widgets}
```

### Шаг 2: Создание entity

```dart
// lib/features/[feature_name]/domain/entities/[entity_name].dart
import 'package:equatable/equatable.dart';

class EntityName extends Equatable {
  final String id;
  final String name;
  // другие поля

  const EntityName({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
```

### Шаг 3: Создание repository interface

```dart
// lib/features/[feature_name]/domain/repositories/[feature_name]_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/[entity_name].dart';

abstract class FeatureNameRepository {
  Future<Either<Failure, List<EntityName>>> getEntities();
  Future<Either<Failure, EntityName>> getEntityById(String id);
  Future<Either<Failure, EntityName>> createEntity(EntityName entity);
  Future<Either<Failure, EntityName>> updateEntity(EntityName entity);
  Future<Either<Failure, void>> deleteEntity(String id);
}
```

## 🔧 Добавление нового use case

### Шаг 1: Создание параметров

```dart
// lib/features/[feature_name]/domain/usecases/[usecase_name]_params.dart
class UseCaseNameParams {
  final String param1;
  final int param2;

  UseCaseNameParams({
    required this.param1,
    required this.param2,
  });
}
```

### Шаг 2: Создание use case

```dart
// lib/features/[feature_name]/domain/usecases/[usecase_name].dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/[entity_name].dart';
import '../repositories/[feature_name]_repository.dart';
import '[usecase_name]_params.dart';

@injectable
class UseCaseName implements UseCase<EntityName, UseCaseNameParams> {
  final FeatureNameRepository repository;

  UseCaseName(this.repository);

  @override
  Future<Either<Failure, EntityName>> call(UseCaseNameParams params) async {
    // Реализация бизнес-логики
    return await repository.getEntityById(params.param1);
  }
}
```

### Шаг 3: Регистрация в DI

```dart
// lib/core/di/injection.dart
// Добавьте в configureDependencies():
getIt.registerLazySingleton<UseCaseName>(
  () => UseCaseName(getIt<FeatureNameRepository>()),
);
```

## 📱 Добавление нового экрана

### Шаг 1: Создание событий BLoC

```dart
// lib/features/[feature_name]/presentation/bloc/[feature_name]_event.dart
import 'package:equatable/equatable.dart';

abstract class FeatureNameEvent extends Equatable {
  const FeatureNameEvent();

  @override
  List<Object?> get props => [];
}

class LoadEntities extends FeatureNameEvent {
  const LoadEntities();
}

class CreateEntity extends FeatureNameEvent {
  final String name;
  // другие параметры

  const CreateEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
```

### Шаг 2: Создание состояний BLoC

```dart
// lib/features/[feature_name]/presentation/bloc/[feature_name]_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/[entity_name].dart';

abstract class FeatureNameState extends Equatable {
  const FeatureNameState();

  @override
  List<Object?> get props => [];
}

class FeatureNameInitial extends FeatureNameState {}

class FeatureNameLoading extends FeatureNameState {}

class EntitiesLoaded extends FeatureNameState {
  final List<EntityName> entities;

  const EntitiesLoaded(this.entities);

  @override
  List<Object?> get props => [entities];
}

class FeatureNameError extends FeatureNameState {
  final String message;

  const FeatureNameError(this.message);

  @override
  List<Object?> get props => [message];
}
```

### Шаг 3: Создание BLoC

```dart
// lib/features/[feature_name]/presentation/bloc/[feature_name]_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/[usecase_name].dart';
import '../../../../core/usecases/usecase.dart';
import '[feature_name]_event.dart';
import '[feature_name]_state.dart';

@injectable
class FeatureNameBloc extends Bloc<FeatureNameEvent, FeatureNameState> {
  final UseCaseName _useCaseName;

  FeatureNameBloc({
    required UseCaseName useCaseName,
  })  : _useCaseName = useCaseName,
        super(FeatureNameInitial()) {
    on<LoadEntities>(_onLoadEntities);
    on<CreateEntity>(_onCreateEntity);
  }

  Future<void> _onLoadEntities(
    LoadEntities event,
    Emitter<FeatureNameState> emit,
  ) async {
    emit(const FeatureNameLoading());
    
    final result = await _useCaseName(const UseCaseNameParams());
    
    result.fold(
      (failure) => emit(FeatureNameError(failure.message)),
      (entities) => emit(EntitiesLoaded(entities)),
    );
  }

  Future<void> _onCreateEntity(
    CreateEntity event,
    Emitter<FeatureNameState> emit,
  ) async {
    // Реализация
  }
}
```

### Шаг 4: Создание страницы

```dart
// lib/features/[feature_name]/presentation/pages/[feature_name]_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/[feature_name]_bloc.dart';
import '../bloc/[feature_name]_event.dart';
import '../bloc/[feature_name]_state.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/error_widget.dart';

class FeatureNamePage extends StatefulWidget {
  const FeatureNamePage({super.key});

  @override
  State<FeatureNamePage> createState() => _FeatureNamePageState();
}

class _FeatureNamePageState extends State<FeatureNamePage> {
  late final FeatureNameBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<FeatureNameBloc>();
    _bloc.add(const LoadEntities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Name'),
      ),
      body: BlocBuilder<FeatureNameBloc, FeatureNameState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is FeatureNameLoading) {
            return const LoadingWidget();
          } else if (state is FeatureNameError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => _bloc.add(const LoadEntities()),
            );
          } else if (state is EntitiesLoaded) {
            return _buildEntitiesList(state.entities);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildEntitiesList(List<EntityName> entities) {
    return ListView.builder(
      itemCount: entities.length,
      itemBuilder: (context, index) {
        final entity = entities[index];
        return ListTile(
          title: Text(entity.name),
          // другие виджеты
        );
      },
    );
  }
}
```

### Шаг 5: Добавление роута

```dart
// lib/core/routes/app_router.dart
// Добавьте новый роут:
GoRoute(
  path: '/feature-name',
  name: 'feature_name',
  builder: (context, state) => const FeatureNamePage(),
),
```

## 🌐 Добавление нового API endpoint

### Шаг 1: Создание модели

```dart
// lib/features/[feature_name]/data/models/[entity_name]_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/[entity_name].dart';

part '[entity_name]_model.freezed.dart';
part '[entity_name]_model.g.dart';

@freezed
class EntityNameModel with _$EntityNameModel {
  const factory EntityNameModel({
    required String id,
    required String name,
  }) = _EntityNameModel;

  factory EntityNameModel.fromJson(Map<String, dynamic> json) =>
      _$EntityNameModelFromJson(json);

  factory EntityNameModel.fromEntity(EntityName entity) => EntityNameModel(
        id: entity.id,
        name: entity.name,
      );
}

extension EntityNameModelExtension on EntityNameModel {
  EntityName toEntity() => EntityName(
        id: id,
        name: name,
      );
}
```

### Шаг 2: Создание data source

```dart
// lib/features/[feature_name]/data/datasources/[feature_name]_remote_data_source.dart
import 'package:injectable/injectable.dart';
import '../../../../core/network/dio_client.dart';
import '../models/[entity_name]_model.dart';

abstract class FeatureNameRemoteDataSource {
  Future<List<EntityNameModel>> getEntities();
  Future<EntityNameModel> getEntityById(String id);
  Future<EntityNameModel> createEntity(EntityNameModel entity);
  Future<EntityNameModel> updateEntity(EntityNameModel entity);
  Future<void> deleteEntity(String id);
}

@Injectable(as: FeatureNameRemoteDataSource)
class FeatureNameRemoteDataSourceImpl implements FeatureNameRemoteDataSource {
  final DioClient _dioClient;

  FeatureNameRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<EntityNameModel>> getEntities() async {
    try {
      final response = await _dioClient.dio.get('/entities');
      return (response.data as List)
          .map((json) => EntityNameModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to load entities: ${e.toString()}');
    }
  }

  // Реализуйте остальные методы...
}
```

### Шаг 3: Создание репозитория

```dart
// lib/features/[feature_name]/data/repositories/[feature_name]_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/[entity_name].dart';
import '../../domain/repositories/[feature_name]_repository.dart';
import '../datasources/[feature_name]_remote_data_source.dart';

@Injectable(as: FeatureNameRepository)
class FeatureNameRepositoryImpl implements FeatureNameRepository {
  final FeatureNameRemoteDataSource _remoteDataSource;

  FeatureNameRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<EntityName>>> getEntities() async {
    try {
      final entityModels = await _remoteDataSource.getEntities();
      final entities = entityModels.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // Реализуйте остальные методы...
}
```

## 🎨 Добавление новой темы

### Шаг 1: Создание цветовой схемы

```dart
// lib/shared/theme/custom_color_scheme.dart
import 'package:flutter/material.dart';

class CustomColorScheme {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);
  
  // Добавьте другие цвета
}
```

### Шаг 2: Обновление темы

```dart
// lib/shared/theme/app_theme.dart
// Добавьте новую тему:
static ThemeData get customTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColorScheme.primaryColor,
    ),
    // Другие настройки темы
  );
}
```

## 🌍 Добавление локализации

### Шаг 1: Создание файлов локализации

```dart
// lib/l10n/app_en.arb
{
  "appTitle": "MyApp",
  "welcome": "Welcome",
  "addTask": "Add Task",
  "deleteTask": "Delete Task",
  "taskTitle": "Task Title",
  "taskDescription": "Task Description"
}
```

```dart
// lib/l10n/app_ru.arb
{
  "appTitle": "МоеПриложение",
  "welcome": "Добро пожаловать",
  "addTask": "Добавить задачу",
  "deleteTask": "Удалить задачу",
  "taskTitle": "Название задачи",
  "taskDescription": "Описание задачи"
}
```

### Шаг 2: Обновление pubspec.yaml

```yaml
flutter:
  generate: true
```

### Шаг 3: Использование в коде

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// В виджете:
Text(AppLocalizations.of(context)!.appTitle)
```

## 🔄 Генерация кода

После добавления новых файлов с аннотациями (freezed, json_serializable, injectable), запустите:

```bash
flutter packages pub run build_runner build
```

Для автоматической генерации при изменении файлов:

```bash
flutter packages pub run build_runner watch
```

## 📝 Лучшие практики

1. **Следуйте принципам SOLID**
2. **Используйте dependency injection**
3. **Разделяйте ответственность между слоями**
4. **Пишите тесты для каждого слоя**
5. **Используйте meaningful names для переменных и функций**
6. **Добавляйте документацию к публичным API**
7. **Следуйте конвенциям именования**

## 🧪 Тестирование

### Unit тесты для use cases

```dart
// test/features/[feature_name]/domain/usecases/[usecase_name]_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:your_app/features/[feature_name]/domain/usecases/[usecase_name].dart';
import 'package:your_app/features/[feature_name]/domain/repositories/[feature_name]_repository.dart';

@GenerateMocks([FeatureNameRepository])
void main() {
  late UseCaseName useCase;
  late MockFeatureNameRepository mockRepository;

  setUp(() {
    mockRepository = MockFeatureNameRepository();
    useCase = UseCaseName(mockRepository);
  });

  test('should return entity when repository call is successful', () async {
    // arrange
    final entity = EntityName(id: '1', name: 'Test');
    when(mockRepository.getEntityById('1'))
        .thenAnswer((_) async => Right(entity));

    // act
    final result = await useCase(UseCaseNameParams(param1: '1', param2: 2));

    // assert
    expect(result, Right(entity));
    verify(mockRepository.getEntityById('1'));
    verifyNoMoreInteractions(mockRepository);
  });
}
```

### Widget тесты

```dart
// test/features/[feature_name]/presentation/pages/[feature_name]_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app/features/[feature_name]/presentation/pages/[feature_name]_page.dart';
import 'package:your_app/features/[feature_name]/presentation/bloc/[feature_name]_bloc.dart';

class MockFeatureNameBloc extends Mock implements FeatureNameBloc {}

void main() {
  late MockFeatureNameBloc mockBloc;

  setUp(() {
    mockBloc = MockFeatureNameBloc();
  });

  testWidgets('should display loading when state is loading', (tester) async {
    // arrange
    when(mockBloc.state).thenReturn(FeatureNameLoading());

    // act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FeatureNameBloc>.value(
          value: mockBloc,
          child: const FeatureNamePage(),
        ),
      ),
    );

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

---

Это руководство поможет вам эффективно расширять проект, следуя принципам Clean Architecture. Помните, что главное - это разделение ответственности и соблюдение принципов SOLID. 