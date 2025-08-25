# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter mobile application for Jankuier that implements Clean Architecture with BLoC pattern. The app includes features like home navigation, tasks management, services/fields booking, profile management, and more.

## Development Commands

### Essential Commands
- `flutter pub get` - Install dependencies
- `flutter run` - Run the app in debug mode
- `flutter run --release` - Run in release mode
- `flutter gen-l10n` - Generate localization files
- `flutter packages pub run build_runner build` - Generate code (freezed, json_serializable, injectable)
- `flutter packages pub run build_runner watch` - Watch and auto-generate code
- `flutter test` - Run unit tests
- `flutter analyze` - Run static analysis

### Build Commands
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle
- `flutter build ios` - Build iOS

## Architecture Overview

### Clean Architecture Layers
The project follows Clean Architecture with three main layers:

1. **Presentation Layer** (`presentation/`) - UI, BLoC, widgets, pages
2. **Domain Layer** (`domain/`) - Business logic, entities, use cases, repository interfaces
3. **Data Layer** (`data/`) - Repository implementations, data sources, models

### Key Architectural Patterns
- **BLoC Pattern** for state management using `flutter_bloc`
- **Dependency Injection** using `get_it` + `injectable`
- **Repository Pattern** for data abstraction
- **Use Case Pattern** for business logic encapsulation
- **Error Handling** with `dartz` Either type (Left for failures, Right for success)

### Project Structure
```
lib/
├── core/                   # Shared core components
│   ├── constants/         # App constants and configurations
│   ├── di/               # Dependency injection setup
│   ├── errors/           # Error handling (Failure classes)
│   ├── network/          # HTTP client (Dio) setup
│   ├── routes/           # Navigation routing (go_router)
│   └── usecases/         # Base UseCase interface
├── features/             # Feature modules
│   ├── [feature]/
│   │   ├── data/        # Data layer
│   │   ├── domain/      # Domain layer
│   │   └── presentation/ # Presentation layer
├── l10n/                # Internationalization
└── shared/              # Shared widgets and themes
```

### Key Features
- **Tasks Management** - Complete CRUD operations with BLoC
- **Home/Navigation** - Bottom navigation with persistent_bottom_nav_bar
- **Services** - Fields booking, shop, sections
- **Profile** - Account management and settings
- **Activity** - Achievements and leaderboards
- **Blog** - News/content display
- **Multi-language** - Supports English, Russian, Kazakh

## Dependencies and Tools

### State Management
- `flutter_bloc` - BLoC pattern implementation
- `hydrated_bloc` - Persistent state management

### Navigation
- `go_router` - Declarative routing
- `persistent_bottom_nav_bar` - Bottom navigation

### Network & API
- `dio` - HTTP client
- `pretty_dio_logger` - Network request logging

### Code Generation
- `freezed` + `freezed_annotation` - Immutable data classes
- `json_annotation` + `json_serializable` - JSON serialization
- `injectable` + `injectable_generator` - DI code generation
- `build_runner` - Code generation runner

### UI & Utils
- `flutter_screenutil` - Screen adaptation
- `flutter_svg` - SVG support
- `equatable` - Object comparison
- `dartz` - Functional programming (Either, Option)

## Development Guidelines

### Adding New Features
1. Create feature folder structure following existing patterns
2. Start with domain layer (entities, repositories, use cases)
3. Implement data layer (models, data sources, repository implementation)
4. Build presentation layer (BLoC, pages, widgets)
5. Register dependencies in `core/di/injection.dart`
6. Add routes in `core/routes/app_router.dart`
7. Run code generation: `flutter packages pub run build_runner build`

### BLoC Pattern Implementation
- Use separate files for events, states, and bloc
- Implement proper error handling in states
- Use dependency injection for use cases in BLoC constructors
- Follow existing naming conventions (LoadTasks, TaskLoading, TasksLoaded, etc.)

### Data Models
- Use freezed for immutable data classes
- Implement `fromJson`/`toJson` with json_serializable
- Add `fromEntity`/`toEntity` conversion methods
- Place models in `data/models/` directory

### Error Handling
- Use `Either<Failure, T>` for operations that can fail
- Define specific failure types in `core/errors/failures.dart`
- Handle errors in repository implementations
- Display errors appropriately in UI

### Localization
- Add strings to `.arb` files in `l10n/` directory
- Run `flutter gen-l10n` after adding new strings
- Use `AppLocalizations.of(context)!.stringKey` in widgets

### Testing
- Write unit tests for use cases and repositories
- Test BLoC logic with bloc_test package
- Place tests in `test/` directory mirroring `lib/` structure

## Common Patterns

### Use Case Implementation
```dart
@injectable
class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository repository;
  
  GetTasks(this.repository);
  
  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
```

### BLoC Event Handling
```dart
Future<void> _onLoadTasks(
  LoadTasks event,
  Emitter<TaskState> emit,
) async {
  emit(const TaskLoading());
  
  final result = await getTasks(NoParams());
  
  result.fold(
    (failure) => emit(TaskError(failure.message)),
    (tasks) => emit(TasksLoaded(tasks)),
  );
}
```

### Repository Implementation
```dart
@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;
  
  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final taskModels = await _remoteDataSource.getTasks();
      final tasks = taskModels.map((model) => model.toEntity()).toList();
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

## Important Notes

- The app uses Inter font family with complete weight variants
- Default locale is set to Russian ("ru")
- Uses Material 3 design system
- Screen adaptation is handled with ScreenUtilInit
- Flavor configuration supports dev/prod environments
- HydratedBloc provides persistent state across app restarts