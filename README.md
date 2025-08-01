# MyApp - Flutter Clean Architecture

Мобильное приложение на Flutter с использованием чистой архитектуры (Clean Architecture) и BLoC-подхода для управления состоянием.

## 🏗️ Архитектура

Приложение построено по принципам Clean Architecture с разделением на слои:

### 📁 Структура проекта

```
lib/
├── core/                    # Общие компоненты
│   ├── constants/          # Константы приложения
│   ├── di/                # Dependency Injection
│   ├── errors/            # Обработка ошибок
│   ├── network/           # Сетевой слой
│   ├── routes/            # Навигация
│   └── usecases/          # Базовые use cases
├── features/              # Функциональные модули
│   └── tasks/             # Модуль задач
│       ├── data/          # Data слой
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/        # Domain слой
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/  # Presentation слой
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── shared/                # Общие компоненты
    ├── services/
    ├── theme/
    └── widgets/
```

### 🎯 Слои архитектуры

1. **Presentation Layer** - UI, BLoC, события и состояния
2. **Domain Layer** - Бизнес-логика, сущности, use cases
3. **Data Layer** - Репозитории, data sources, модели

## 🚀 Технологии

- **Flutter** - UI фреймворк
- **flutter_bloc** - Управление состоянием
- **hydrated_bloc** - Персистентность состояния
- **go_router** - Навигация
- **dio** - HTTP клиент
- **get_it** + **injectable** - Dependency Injection
- **freezed** + **json_serializable** - Генерация кода
- **equatable** - Сравнение объектов

## 📱 Функциональность

- ✅ Список задач с моковыми данными
- ✅ Добавление новых задач
- ✅ Редактирование и удаление задач
- ✅ Фильтрация по приоритету
- ✅ Поиск по названию, описанию и тегам
- ✅ Поддержка светлой/темной темы
- ✅ Локализация (en, ru)

## 🛠️ Установка и запуск

### Предварительные требования

- Flutter SDK 3.3.4+
- Dart 3.0+
- Android Studio / VS Code

### Установка зависимостей

```bash
flutter pub get
```

### Генерация кода

```bash
flutter packages pub run build_runner build
```

### Запуск приложения

```bash
# Для разработки
flutter run

# Для продакшена
flutter run --release
```

## 🔧 Конфигурация

### Flavors

Приложение поддерживает различные конфигурации:

- **dev** - Конфигурация для разработки
- **prod** - Продакшн конфигурация

### Переменные окружения

Создайте файл `.env` в корне проекта:

```env
API_BASE_URL=https://api.example.com
API_VERSION=v1
```

## 📖 Как расширять проект

### Добавление нового use case

1. Создайте use case в `lib/features/[feature]/domain/usecases/`
2. Добавьте параметры в `lib/features/[feature]/domain/usecases/[usecase]_params.dart`
3. Зарегистрируйте в DI (`lib/core/di/injection.dart`)

Пример:
```dart
@injectable
class GetUserProfile implements UseCase<User, String> {
  final UserRepository repository;
  
  GetUserProfile(this.repository);
  
  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
```

### Добавление нового экрана

1. Создайте BLoC события и состояния
2. Создайте страницу в `lib/features/[feature]/presentation/pages/`
3. Добавьте роут в `lib/core/routes/app_router.dart`
4. Создайте виджеты в `lib/features/[feature]/presentation/widgets/`

### Добавление нового API endpoint

1. Добавьте метод в data source
2. Обновите репозиторий
3. Создайте use case
4. Добавьте в BLoC

## 🧪 Тестирование

```bash
# Unit тесты
flutter test

# Widget тесты
flutter test test/widget_test.dart

# Integration тесты
flutter test integration_test/
```

## 📦 Сборка

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

## 🤝 Contributing

1. Fork проект
2. Создайте feature branch (`git checkout -b feature/amazing-feature`)
3. Commit изменения (`git commit -m 'Add amazing feature'`)
4. Push в branch (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

## 📄 Лицензия

Этот проект лицензирован под MIT License - см. файл [LICENSE](LICENSE) для деталей.

## 🆘 Поддержка

Если у вас есть вопросы или проблемы, создайте issue в репозитории.

---

**Примечание**: Это демонстрационный проект с моковыми данными. Для продакшн использования замените моковые данные на реальные API вызовы.
