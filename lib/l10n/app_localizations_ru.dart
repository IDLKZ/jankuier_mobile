// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get services => 'Сервисы';

  @override
  String get activity => 'Активность';

  @override
  String get visitedMatches => 'посещённых матчей';

  @override
  String get myAchievements => 'Мои достижения';

  @override
  String get leaderBoard => 'Список лидеров';

  @override
  String get phoneVerificationRequired =>
      'Требуется подтверждение номера телефона';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get login => 'Логин';

  @override
  String get enterUsername => 'Введите username';

  @override
  String get incorrectFormat => 'Некорректный формат';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get minimumThreeChars => 'Минимум 3 символа';

  @override
  String get minimumSixChars => 'Минимум 6 символов';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get signIn => 'Войти';

  @override
  String get registration => 'Регистрация';

  @override
  String get goVerification => 'Пройти верификацию';

  @override
  String get enterLoginHint => 'Введите логин';

  @override
  String get enterEmailHint => 'Введите почту';

  @override
  String get enterEmail => 'Введите email';

  @override
  String get enterCorrectEmail => 'Введите корректный email адрес';

  @override
  String get passwordMinSixChars =>
      'Пароль должен содержать минимум 6 символов';

  @override
  String get repeatPassword => 'Повторите пароль';

  @override
  String get passwordsNotMatch => 'Пароли не совпадают';

  @override
  String get enterPhone => 'Введите номер телефона';

  @override
  String get phoneFormat =>
      'Номер должен начинаться с 7 и содержать 11 цифр (7XXXXXXXXXX)';

  @override
  String get enterFirstName => 'Введите имя';

  @override
  String get firstNameMinChars => 'Имя должно содержать минимум 2 символа';

  @override
  String get enterLastName => 'Введите фамилию';

  @override
  String get lastNameMinChars => 'Фамилия должна содержать минимум 2 символа';

  @override
  String get enterPatronymic => 'Введите отчество (необязательно)';

  @override
  String get enterPhoneHint => 'Введите номер телефона (7XXXXXXXXXX)';

  @override
  String get registrationSuccess =>
      'Регистрация успешна! Пожалуйста, подтвердите номер телефона';

  @override
  String get register => 'Записаться';

  @override
  String get next => 'Далее';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт? Войти';

  @override
  String get usernameValidation =>
      'Логин должен начинаться с буквы и содержать только буквы, цифры и _';

  @override
  String get usernameMinChars => 'Логин должен содержать минимум 3 символа';

  @override
  String get enterPhoneForVerification =>
      'Ввод номера телефона для кода подтверждения';

  @override
  String get sendSMSCode => 'Отправить SMS код';

  @override
  String get iHaveAccount => 'У меня есть аккаунт';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get codeResentSuccessfully => 'Код повторно отправлен';

  @override
  String get codeResendError => 'Ошибка отправки кода';

  @override
  String get codeVerifiedSuccessfully => 'Код подтвержден успешно!';

  @override
  String get invalidCode => 'Неверный код';

  @override
  String get enterVerificationCode => 'Введите код подтверждения';

  @override
  String get codeSentToPhone => 'Код отправлен на номер';

  @override
  String get timeExpiredRequestNew => 'Время истекло. Запросите новый код';

  @override
  String get verify => 'Верифицировать';

  @override
  String get resendCode => 'Отправить код повторно';

  @override
  String get backToLogin => 'Назад к входу';

  @override
  String get news => 'Новости';

  @override
  String get latestNews => 'Последние новости';

  @override
  String get newsLoadError => 'Ошибка загрузки новостей';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get noNewsYet => 'Новостей пока нет';

  @override
  String get checkLater => 'Проверьте позже';

  @override
  String get selectCategory => 'Выберите категорию';

  @override
  String get dateNotSpecified => 'Дата не указана';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String daysAgo(int days) {
    return '$days д. назад';
  }

  @override
  String get singleNewsLoadError => 'Ошибка загрузки новости';

  @override
  String get back => 'Назад';

  @override
  String get newsNotFound => 'Новости не найдены';

  @override
  String get tryLater => 'Попробуйте позже';

  @override
  String get countries => 'Страны';

  @override
  String get selectedCountry => 'Выбрана страна';

  @override
  String get saveCountryError => 'Ошибка сохранения страны';

  @override
  String get loadingError => 'Ошибка загрузки';

  @override
  String get noCountriesData => 'Нет данных о странах';

  @override
  String get nationalTeam => 'Сборная';

  @override
  String get round => 'Тур';

  @override
  String get statistics => 'Статистика';

  @override
  String get lineup => 'Состав';

  @override
  String get players => 'Игроки';

  @override
  String get loadingErrorWithMessage => 'Ошибка загрузки:';

  @override
  String get selectLineupTabToLoad =>
      'Выберите вкладку \'Состав\' для загрузки состава';

  @override
  String get selectPlayersTabToLoad =>
      'Выберите вкладку \'Статистика игроков\' для загрузки';

  @override
  String get ballPossession => 'Владение мячом';

  @override
  String get shots => 'Удары';

  @override
  String get shotsOnGoal => 'Удары в створ';

  @override
  String get shotsOffGoal => 'Удары мимо';

  @override
  String get fouls => 'Фолы';

  @override
  String get yellowCards => 'Желтые карточки';

  @override
  String get refereeTeam => 'Судейская бригада';

  @override
  String get mainReferee => 'Главный судья:';

  @override
  String get firstAssistant => '1-й помощник:';

  @override
  String get secondAssistant => '2-й помощник:';

  @override
  String get fourthReferee => '4-й судья:';

  @override
  String get coachingStaff => 'Тренерский штаб';

  @override
  String get headCoach => 'Главный тренер';

  @override
  String get assistants => 'Ассистенты';

  @override
  String get goalkeeper => 'ВР';

  @override
  String get goalkeeperFull => 'Вратарь';

  @override
  String get fieldPlayer => 'Полевой игрок';

  @override
  String get onTarget => 'В створ';

  @override
  String get passes => 'Передачи';

  @override
  String get offTarget => 'Мимо створа';

  @override
  String get yellows => 'Желтые';

  @override
  String get offsides => 'Офсайды';

  @override
  String get corners => 'Угловые';

  @override
  String get additionalStats => 'Дополнительная статистика';

  @override
  String get home => 'Главная';

  @override
  String get loadingTournaments => 'Загрузка турниров...';

  @override
  String get pleaseWait => 'Пожалуйста, подождите';

  @override
  String get tournaments => 'Турниры';

  @override
  String get tournamentsNotFound => 'Турниры не найдены';

  @override
  String get tournamentsLoadError => 'Ошибка загрузки турниров';

  @override
  String get table => 'Таблица';

  @override
  String get results => 'Результаты';

  @override
  String get tableLoadError => 'Ошибка загрузки турнирной таблицы';

  @override
  String get matchesLoadError => 'Ошибка загрузки результатов матчей';

  @override
  String get selectResultsTab =>
      'Выберите вкладку \'Результаты\' для загрузки матчей';

  @override
  String get position => '№';

  @override
  String get team => 'Команда';

  @override
  String get matchesPlayed => 'И';

  @override
  String get goalsScored => 'Г';

  @override
  String get points => 'О';

  @override
  String get allNews => 'Все новости';

  @override
  String get nationalTeamGames => 'Игры сборной';

  @override
  String get allGames => 'Все игры';

  @override
  String get clubGames => 'Клубные игры';

  @override
  String get noUpcomingMatches => 'Нет предстоящих матчей';

  @override
  String get noPastMatches => 'Нет прошедших матчей';

  @override
  String get matchesWillBeDisplayed =>
      'Матчи будут отображены, когда станут доступны';

  @override
  String get tournamentNotSpecified => 'Турнир не указан';

  @override
  String get team1 => 'Команда 1';

  @override
  String get team2 => 'Команда 2';

  @override
  String get timeNotSpecified => 'Время не указано';

  @override
  String get invalidFormat => 'Неверный формат';

  @override
  String get premierLeague => 'ПРЕМЬЕР ЛИГА';

  @override
  String get ofKazakhstan => 'Казахстана';

  @override
  String get daysAgoShort => 'дн. назад';

  @override
  String get hoursAgoShort => 'ч. назад';

  @override
  String get minutesAgoShort => 'мин. назад';

  @override
  String get justNow => 'Только что';

  @override
  String get nationalTeamMatches => 'Матчи Сборной';

  @override
  String get loadingLeagues => 'Загружаем лиги...';

  @override
  String get selectNationalTeam => 'Выберите сборную';

  @override
  String get untitled => 'Без названия';

  @override
  String get future => 'Будущие';

  @override
  String get past => 'Прошлые';

  @override
  String get coaches => 'Тренеры';

  @override
  String get noAvailableLeagues => 'Нет доступных лиг';

  @override
  String get tryReloadPage => 'Попробуйте обновить страницу';

  @override
  String get tour => 'ТУР';

  @override
  String get noPlayers => 'Нет игроков';

  @override
  String get fullName => 'ФИО';

  @override
  String get club => 'Клуб';

  @override
  String get games => 'Игр';

  @override
  String get clubNotSpecified => 'Клуб не указан';

  @override
  String get noCoaches => 'Нет тренеров';

  @override
  String get positionNotSpecified => 'Должность не указана';

  @override
  String get nationalityNotSpecified => 'Национальность не указана';

  @override
  String get clubMatches => 'Клубные матчи';

  @override
  String get matchesLoadingError => 'Ошибка загрузки матчей';

  @override
  String get tournament => 'Турнир';

  @override
  String get stadiumNotSpecified => 'Стадион не указан';

  @override
  String get attendance => 'Посещаемость';

  @override
  String get matchProtocol => 'Протокол матча';

  @override
  String get invalidDateFormat => 'Неверный формат даты';

  @override
  String get matchDetails => 'Детали матча';

  @override
  String get dateAndTime => 'Дата и время';

  @override
  String get status => 'Статус';

  @override
  String get additionalInfo => 'Дополнительная информация';

  @override
  String get attendanceCount => 'Посещаемость';

  @override
  String get downloadPdf => 'Скачать PDF';

  @override
  String get videoOverview => 'Видеообзор';

  @override
  String get watchOnYoutube => 'Смотреть на YouTube';

  @override
  String get scheduled => 'Запланирован';

  @override
  String get finished => 'Завершен';

  @override
  String get canceled => 'Отменен';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get stadium => 'Стадион';

  @override
  String get notSpecified => 'Не указано';

  @override
  String get stadiumNameNotSpecified => 'Название не указано';

  @override
  String get matches => 'Матчи';

  @override
  String get activeMatch => 'Активный матч';

  @override
  String get tickets => 'Билеты';

  @override
  String get yourTickets => 'Ваши билеты';

  @override
  String get availableTickets => 'Доступные билеты';

  @override
  String get liveNow => 'Прямо эфир';

  @override
  String get showQrToController => 'Покажите QR Контролеру';

  @override
  String get close => 'Закрыть';

  @override
  String get buyMore => 'Купить еще';

  @override
  String get myTicket => 'Мой билет';

  @override
  String get profile => 'Профиль';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get takeNewPhoto => 'Сделать новое фото';

  @override
  String get chooseNewFromGallery => 'Выбрать новое из галереи';

  @override
  String get deletePhoto => 'Удалить фото';

  @override
  String get cancel => 'Отмена';

  @override
  String get selectedFileEmpty => 'Выбранный файл пуст';

  @override
  String get fileNotFound => 'Файл не найден';

  @override
  String get errorAccessingCameraGallery => 'Ошибка доступа к камере/галерее';

  @override
  String get photoAccessDenied =>
      'Доступ к фото запрещен. Проверьте разрешения в настройках';

  @override
  String get cameraAccessDenied =>
      'Доступ к камере запрещен. Проверьте разрешения в настройках';

  @override
  String get cameraConnectionError =>
      'Ошибка подключения к камере. Попробуйте перезапустить приложение';

  @override
  String get settings => 'Настройки';

  @override
  String get errorSelectingImage => 'Ошибка при выборе изображения';

  @override
  String get profilePhotoUpdated => 'Фото профиля обновлено';

  @override
  String get profilePhotoDeleted => 'Фото профиля удалено';

  @override
  String get errorOnLogout => 'Ошибка при выходе';

  @override
  String get data => 'Данные';

  @override
  String get personalInformation => 'Личная информация';

  @override
  String get lastName => 'Фамилия';

  @override
  String get firstName => 'Имя';

  @override
  String get patronymicOptional => 'Отчество (необязательно)';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get iinOptional => 'ИИН (необязательно)';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get profileSuccessfullyUpdated => 'Профиль успешно обновлен';

  @override
  String get security => 'Безопасность';

  @override
  String get passwordChange => 'Изменение пароля';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get repeatNewPassword => 'Повторите новый пароль';

  @override
  String get updatePassword => 'Обновить пароль';

  @override
  String get passwordSuccessfullyUpdated => 'Пароль успешно обновлен';

  @override
  String get newPasswordMustDiffer =>
      'Новый пароль должен отличаться от текущего';

  @override
  String get changePassword => 'Поменять пароль';

  @override
  String get changeEmail => 'Поменять почту';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get oldPassword => 'Старый пароль';

  @override
  String get enterOldPassword => 'Введите старый пароль';

  @override
  String get enterNewPassword => 'Введите новый пароль';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get personalData => 'Личные данные';

  @override
  String get logout => 'Выход';

  @override
  String get enterCurrentPassword => 'Введите текущий пароль';

  @override
  String get enterNewPasswordField => 'Введите новый пароль';

  @override
  String get repeatNewPasswordField => 'Повторите новый пароль';

  @override
  String get shop => 'Магазин';

  @override
  String get fields => 'Поля';

  @override
  String get sections => 'Секции';

  @override
  String get years => 'лет';

  @override
  String get schedule => 'Расписание';

  @override
  String get noScheduleYet => 'Расписания пока нет';

  @override
  String get groups => 'Группы';

  @override
  String get recruitmentOpen => 'Набор открыт';

  @override
  String get recruitmentClosed => 'Набор закрыт';

  @override
  String get month => 'мес';

  @override
  String get free => 'Бесплатно';

  @override
  String get minutes => 'мин';

  @override
  String get students => 'учеников';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get goBack => 'Вернуться';

  @override
  String get imageNotAvailable => 'Изображение недоступно';

  @override
  String get imageLoadingError => 'Ошибка загрузки изображения';

  @override
  String get addedToFavorites => 'Добавлено в избранное';

  @override
  String get removedFromFavorites => 'Убрано из избранного';

  @override
  String get productAddedToCart => 'Товар добавлен в корзину';

  @override
  String get toCart => 'В корзину';

  @override
  String get article => 'Арт:';

  @override
  String get forChildren => 'Для детей';

  @override
  String get forAdults => 'Для взрослых';

  @override
  String get unisex => 'Унисекс';

  @override
  String get forMen => 'Для мужчин';

  @override
  String get forWomen => 'Для женщин';

  @override
  String get inStock => 'В наличии';

  @override
  String get outOfStock => 'Нет в наличии';

  @override
  String get variants => 'Варианты';

  @override
  String get price => 'Цена';

  @override
  String get add => 'Добавить';

  @override
  String get addToCart => 'Добавить в корзину';

  @override
  String get astanaFacilities => 'Астана: 256 сооружений';

  @override
  String get addFacility => 'Добавить площадку';

  @override
  String get filters => 'Фильтры';

  @override
  String get searchFreeTime => 'Поиск свободного времени';

  @override
  String get book => 'Забронировать';

  @override
  String get selectTime => 'Выберите время';

  @override
  String get pay => 'Оплатить';

  @override
  String get fieldRental => 'Аренда полей';

  @override
  String get searchFilters => 'Фильтры поиска';

  @override
  String get minimumThreeCharacters => 'Минимум 3 символа';

  @override
  String get maximumTwoHundredFiftyFiveCharacters => 'Максимум 255 символов';

  @override
  String get search => 'Поиск';

  @override
  String get enterFieldName => 'Введите название поля...';

  @override
  String get selectCity => 'Выберите город';

  @override
  String get apply => 'Применить';

  @override
  String get noMoreFields => 'Больше полей нет';

  @override
  String get sectionRegistration => 'Запись в секцию';

  @override
  String get enterSectionName => 'Введите название секции...';

  @override
  String get gender => 'Пол';

  @override
  String get any => 'Любой';

  @override
  String get male => 'М';

  @override
  String get female => 'Ж';

  @override
  String get age => 'Возраст';

  @override
  String get from => 'От';

  @override
  String get to => 'До';

  @override
  String get averagePrice => 'Средняя цена';

  @override
  String get priceFrom => 'Цена от';

  @override
  String get priceTo => 'Цена до';

  @override
  String get noMoreSections => 'Больше секций нет';

  @override
  String get newProducts => 'Новые товары';

  @override
  String get categories => 'Категории';

  @override
  String get buy => 'Купить';

  @override
  String get firstLeague => 'Первая лига';

  @override
  String get activeTickets => 'Активные билеты';

  @override
  String get buyTickets => 'Купить билеты';

  @override
  String get buyBooking => 'Купить бронь';

  @override
  String get payOrder => 'Оплатить заказ';

  @override
  String get loading => 'Загрузка...';

  @override
  String get httpError => 'HTTP ошибка';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get repeatPayment => 'Повторная оплата';

  @override
  String get loadingPayment => 'Загрузка оплаты...';

  @override
  String get noActiveTicketsYet => 'Пока нет активных билетов';

  @override
  String get city => 'Город';

  @override
  String get event => 'Событие';

  @override
  String get venueNotSpecified => 'Место не указано';

  @override
  String get sport => 'СПОРТ';

  @override
  String get venue => 'Место проведения';

  @override
  String get pleaseAuthorize => 'Пожалуйста, пройдите авторизацию';

  @override
  String get youHaveNoOrdersYet => 'У вас пока нет заказов';

  @override
  String get orderedTicketsWillAppearHere =>
      'Заказанные билеты будут отображаться здесь';

  @override
  String get orderDetails => 'Детали заказа #';

  @override
  String get genre => 'Жанр:';

  @override
  String get duration => 'Длительность:';

  @override
  String get unknownLocation => 'Неизвестное место';

  @override
  String get unknownCity => 'Неизвестный город';

  @override
  String get hall => 'Зал:';

  @override
  String get unknownHall => 'Неизвестный зал';

  @override
  String get ticket => 'Билет';

  @override
  String get row => 'Ряд';

  @override
  String get seat => 'Место';

  @override
  String get level => 'Уровень:';

  @override
  String get orderInformation => 'Информация о заказе';

  @override
  String get ticketCount => 'Количество билетов';

  @override
  String get totalCost => 'Общая стоимость';

  @override
  String get phone => 'Телефон';

  @override
  String get dateCreated => 'Дата создания';

  @override
  String get cancellationReason => 'Причина отмены';

  @override
  String get cancelOrder => 'Отмена заказа';

  @override
  String get showPass => 'Показать пропуск';

  @override
  String get statusCanceled => 'ОТМЕНЕН';

  @override
  String get statusPaid => 'ОПЛАЧЕН';

  @override
  String get statusActive => 'АКТИВЕН';

  @override
  String get statusInactive => 'НЕАКТИВЕН';

  @override
  String get eventPass => 'Пропуск на мероприятие';

  @override
  String get order => 'Заказ';

  @override
  String get loadingPass => 'Загрузка пропуска...';

  @override
  String get passLoadingError => 'Ошибка загрузки пропуска';

  @override
  String get qrCodeUnavailable => 'QR-код недоступен';

  @override
  String get qrCodesNotFound => 'QR-коды не найдены';

  @override
  String get amount => 'Сумма';

  @override
  String get success => 'Выполнено успешно';

  @override
  String get ticketsCount => 'Билетов';

  @override
  String get details => 'Подробнее';

  @override
  String get selectCountryFirst => 'Сначала выберите страну';

  @override
  String get season => 'Сезон:';

  @override
  String get tournamentSelected => 'Выбран турнир:';

  @override
  String get tournamentSaveError => 'Ошибка сохранения турнира';

  @override
  String get selectTournament => 'Выберите турнир';

  @override
  String get international => 'Межд.';

  @override
  String get tournamentLoadingError => 'Ошибка загрузки турниров';

  @override
  String get retryAttempt => 'Повторить попытку';

  @override
  String get searchTournaments => 'Поиск турниров...';

  @override
  String get maleTournaments => 'Мужские';

  @override
  String get femaleTournaments => 'Женские';

  @override
  String get tryChangeSearchFilters => 'Попробуйте изменить фильтры поиска';

  @override
  String get touchScreenToSkip => 'Коснитесь экрана, чтобы пропустить';

  @override
  String get deleteAccountConfirmation => 'Подтверждение удаления аккаунта';

  @override
  String get deleteAccountWarning =>
      'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.';

  @override
  String get deleteAccountPermanently => 'Удалить навсегда';

  @override
  String get accountDeleted => 'Аккаунт успешно удален';

  @override
  String get accountDeletionFailed => 'Ошибка удаления аккаунта';

  @override
  String get myBookings => 'Мои брони';

  @override
  String get pending => 'Ожидает';

  @override
  String get paid => 'Оплачено';

  @override
  String get cancelled => 'Отмененные';

  @override
  String get bookingCancelledSuccessfully => 'Бронь успешно отменена';

  @override
  String get repeat => 'Повторить';

  @override
  String get noBookings => 'Нет броней';

  @override
  String get bookingDetails => 'Детали брони';

  @override
  String get field => 'Поле';

  @override
  String get date => 'Дата';

  @override
  String get time => 'Время';

  @override
  String get total => 'Сумма';

  @override
  String get address => 'Адрес';

  @override
  String get cancelBooking => 'Отменить бронь';

  @override
  String get cancelBookingTitle => 'Отменить бронь?';

  @override
  String get cancelBookingConfirmation =>
      'Вы уверены, что хотите отменить эту бронь? Это действие нельзя отменить.';

  @override
  String get no => 'Нет';

  @override
  String get yesCancel => 'Да, отменить';

  @override
  String get pleaseLogin => 'Выполните вход';

  @override
  String get addedToCart => 'Добавлено в корзину';

  @override
  String get selectQuantity => 'Выберите количество';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get myOrders => 'Мои заказы';

  @override
  String get viewPurchaseHistory => 'Посмотреть историю покупок';

  @override
  String get viewMyBookings => 'Посмотреть мои бронирования';

  @override
  String get authorizationRequired => 'Требуется авторизация';

  @override
  String get loginFirstToBook => 'Сначала войдите в аккаунт для бронирования';

  @override
  String get bookingRequestCreated => 'Запрос на бронирование создан';

  @override
  String get cartCleared => 'Корзина очищена';

  @override
  String get cartEmpty => 'Корзина пуста';

  @override
  String get addItemsToCheckout => 'Добавьте товары для оформления заказа';

  @override
  String get clearCartQuestion => 'Очистить корзину?';

  @override
  String get allItemsWillBeRemoved => 'Все товары будут удалены из корзины';

  @override
  String get clear => 'Очистить';

  @override
  String get product => 'Товар';

  @override
  String get totalToPay => 'Итого к оплате:';

  @override
  String get proceedToPayment => 'Перейти к оплате';

  @override
  String get awaitingPayment => 'Ожидают';

  @override
  String get noOrdersYet => 'Заказов пока нет';

  @override
  String get placeFirstOrderInShop => 'Оформите первый заказ в магазине';

  @override
  String get paidOn => 'Оплачено';

  @override
  String get payBefore => 'Оплатить до';

  @override
  String get cancelOrderConfirmation =>
      'Вы уверены, что хотите отменить этот заказ? Средства будут возвращены на ваш счет после подтверждения администрацией.';

  @override
  String get deleteOrder => 'Удаление заказа';

  @override
  String get deleteOrderConfirmation =>
      'Вы уверены, что хотите удалить этот заказ? Это действие нельзя отменить.';

  @override
  String get delete => 'Удалить';

  @override
  String get orderDataNotAvailable => 'Данные заказа отсутствуют';

  @override
  String get itemsInOrder => 'Товары в заказе';

  @override
  String get noItemsInOrder => 'Нет товаров в заказе';

  @override
  String get createdDate => 'Дата создания';

  @override
  String get paymentDate => 'Дата оплаты';

  @override
  String get quantity => 'Кол-во';

  @override
  String get statusHistory => 'История статусов';

  @override
  String get notifications => 'Уведомления';

  @override
  String get stayUpdated => 'Будьте в курсе событий';

  @override
  String get active => 'Активно';

  @override
  String get newNotifications => 'Новые';

  @override
  String get readNotifications => 'Прочитанные';

  @override
  String get noReadNotifications => 'Нет прочитанных уведомлений';

  @override
  String get allCaughtUp => 'Всё прочитано!';

  @override
  String get noReadNotificationsYet =>
      'Вы ещё не прочитали ни одного уведомления';

  @override
  String get noNewNotifications => 'У вас нет новых уведомлений';

  @override
  String get error => 'Ошибка';

  @override
  String get created => 'Создано';

  @override
  String get updated => 'Обновлено';

  @override
  String get openLink => 'Открыть ссылку';

  @override
  String get navigate => 'Перейти';

  @override
  String get newNotification => 'Новое уведомление';

  @override
  String get tapToView => 'Нажмите для просмотра';

  @override
  String hoursAgo(int hours) {
    return '$hours ч. назад';
  }

  @override
  String minutesAgo(int minutes) {
    return '$minutes мин. назад';
  }

  @override
  String get cart => 'Корзина';

  @override
  String get enterPinCode => 'Введите PIN-код';

  @override
  String get appLogin => 'Вход в приложение';

  @override
  String attemptsRemaining(int count) {
    return 'Осталось попыток: $count';
  }

  @override
  String get confirmLoginWithBiometrics =>
      'Подтвердите вход с помощью биометрии';

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get useBiometrics => 'Использовать биометрию';

  @override
  String get loginWithDifferentAccount => 'Войти с другим аккаунтом';

  @override
  String get attemptsExceededLoginAgain =>
      'Превышено количество попыток. Войдите заново.';

  @override
  String incorrectPinAttemptsRemaining(int count) {
    return 'Неверный PIN-код. Осталось попыток: $count';
  }

  @override
  String get failedToRefreshToken => 'Не удалось обновить токен';

  @override
  String get changePinCode => 'Изменить PIN-код';

  @override
  String get createPinCode => 'Создать PIN-код';

  @override
  String get enterOldAndNewPin =>
      'Введите старый PIN-код и новый для изменения';

  @override
  String get createFourDigitPin =>
      'Создайте 4-значный PIN-код для защиты приложения';

  @override
  String get oldPinCode => 'Старый PIN-код';

  @override
  String get newPinCode => 'Новый PIN-код';

  @override
  String get pinCode => 'PIN-код';

  @override
  String get confirmPinCode => 'Подтвердите PIN-код';

  @override
  String get updatePinCode => 'Обновить PIN-код';

  @override
  String get pinCodesDoNotMatch => 'PIN-коды не совпадают';

  @override
  String get newPinCodesDoNotMatch => 'Новые PIN-коды не совпадают';

  @override
  String get pinCodeSuccessfullySet => 'PIN-код успешно установлен';

  @override
  String get pinCodeSuccessfullyUpdated => 'PIN-код успешно обновлен';

  @override
  String get attemptsExceeded => 'Превышено количество попыток';

  @override
  String incorrectOldPinAttemptsRemaining(int count) {
    return 'Неверный старый PIN-код. Осталось попыток: $count';
  }

  @override
  String get securitySetup => 'Настройка защиты';

  @override
  String get useBiometricsOrCreatePin =>
      'Используйте биометрию или создайте PIN-код для защиты приложения';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get giveAccessToData => 'Дайте доступ к данным';

  @override
  String get resetPinCode => 'Сбросить PIN-код';

  @override
  String get privacyButton => 'Политика обработки персональных данных';

  @override
  String get privacyTitle => 'Политика конфиденциальности';

  @override
  String get publicTitle => 'Публичный договор (оферта)';

  @override
  String get publicMobileTitle =>
      'Публичный договор-оферта мобильного приложения';
}
