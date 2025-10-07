import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('kk')
  ];

  /// No description provided for @services.
  ///
  /// In ru, this message translates to:
  /// **'Сервисы'**
  String get services;

  /// No description provided for @activity.
  ///
  /// In ru, this message translates to:
  /// **'Активность'**
  String get activity;

  /// No description provided for @visitedMatches.
  ///
  /// In ru, this message translates to:
  /// **'посещённых матчей'**
  String get visitedMatches;

  /// No description provided for @myAchievements.
  ///
  /// In ru, this message translates to:
  /// **'Мои достижения'**
  String get myAchievements;

  /// No description provided for @leaderBoard.
  ///
  /// In ru, this message translates to:
  /// **'Список лидеров'**
  String get leaderBoard;

  /// No description provided for @phoneVerificationRequired.
  ///
  /// In ru, this message translates to:
  /// **'Требуется подтверждение номера телефона'**
  String get phoneVerificationRequired;

  /// No description provided for @welcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать!'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In ru, this message translates to:
  /// **'Логин'**
  String get login;

  /// No description provided for @enterUsername.
  ///
  /// In ru, this message translates to:
  /// **'Введите username'**
  String get enterUsername;

  /// No description provided for @incorrectFormat.
  ///
  /// In ru, this message translates to:
  /// **'Некорректный формат'**
  String get incorrectFormat;

  /// No description provided for @enterPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get enterPassword;

  /// No description provided for @minimumThreeChars.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 3 символа'**
  String get minimumThreeChars;

  /// No description provided for @minimumSixChars.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 6 символов'**
  String get minimumSixChars;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get signIn;

  /// No description provided for @registration.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get registration;

  /// No description provided for @goVerification.
  ///
  /// In ru, this message translates to:
  /// **'Пройти верификацию'**
  String get goVerification;

  /// No description provided for @enterLoginHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите логин'**
  String get enterLoginHint;

  /// No description provided for @enterEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите почту'**
  String get enterEmailHint;

  /// No description provided for @enterEmail.
  ///
  /// In ru, this message translates to:
  /// **'Введите email'**
  String get enterEmail;

  /// No description provided for @enterCorrectEmail.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректный email адрес'**
  String get enterCorrectEmail;

  /// No description provided for @passwordMinSixChars.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум 6 символов'**
  String get passwordMinSixChars;

  /// No description provided for @repeatPassword.
  ///
  /// In ru, this message translates to:
  /// **'Повторите пароль'**
  String get repeatPassword;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordsNotMatch;

  /// No description provided for @enterPhone.
  ///
  /// In ru, this message translates to:
  /// **'Введите номер телефона'**
  String get enterPhone;

  /// No description provided for @phoneFormat.
  ///
  /// In ru, this message translates to:
  /// **'Номер должен начинаться с 7 и содержать 11 цифр (7XXXXXXXXXX)'**
  String get phoneFormat;

  /// No description provided for @enterFirstName.
  ///
  /// In ru, this message translates to:
  /// **'Введите имя'**
  String get enterFirstName;

  /// No description provided for @firstNameMinChars.
  ///
  /// In ru, this message translates to:
  /// **'Имя должно содержать минимум 2 символа'**
  String get firstNameMinChars;

  /// No description provided for @enterLastName.
  ///
  /// In ru, this message translates to:
  /// **'Введите фамилию'**
  String get enterLastName;

  /// No description provided for @lastNameMinChars.
  ///
  /// In ru, this message translates to:
  /// **'Фамилия должна содержать минимум 2 символа'**
  String get lastNameMinChars;

  /// No description provided for @enterPatronymic.
  ///
  /// In ru, this message translates to:
  /// **'Введите отчество (необязательно)'**
  String get enterPatronymic;

  /// No description provided for @enterPhoneHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите номер телефона (7XXXXXXXXXX)'**
  String get enterPhoneHint;

  /// No description provided for @registrationSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация успешна! Пожалуйста, подтвердите номер телефона'**
  String get registrationSuccess;

  /// No description provided for @register.
  ///
  /// In ru, this message translates to:
  /// **'Записаться'**
  String get register;

  /// No description provided for @next.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get next;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт? Войти'**
  String get alreadyHaveAccount;

  /// No description provided for @usernameValidation.
  ///
  /// In ru, this message translates to:
  /// **'Логин должен начинаться с буквы и содержать только буквы, цифры и _'**
  String get usernameValidation;

  /// No description provided for @usernameMinChars.
  ///
  /// In ru, this message translates to:
  /// **'Логин должен содержать минимум 3 символа'**
  String get usernameMinChars;

  /// No description provided for @enterPhoneForVerification.
  ///
  /// In ru, this message translates to:
  /// **'Ввод номера телефона для кода подтверждения'**
  String get enterPhoneForVerification;

  /// No description provided for @sendSMSCode.
  ///
  /// In ru, this message translates to:
  /// **'Отправить SMS код'**
  String get sendSMSCode;

  /// No description provided for @iHaveAccount.
  ///
  /// In ru, this message translates to:
  /// **'У меня есть аккаунт'**
  String get iHaveAccount;

  /// No description provided for @somethingWentWrong.
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так'**
  String get somethingWentWrong;

  /// No description provided for @codeResentSuccessfully.
  ///
  /// In ru, this message translates to:
  /// **'Код повторно отправлен'**
  String get codeResentSuccessfully;

  /// No description provided for @codeResendError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка отправки кода'**
  String get codeResendError;

  /// No description provided for @codeVerifiedSuccessfully.
  ///
  /// In ru, this message translates to:
  /// **'Код подтвержден успешно!'**
  String get codeVerifiedSuccessfully;

  /// No description provided for @invalidCode.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код'**
  String get invalidCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In ru, this message translates to:
  /// **'Введите код подтверждения'**
  String get enterVerificationCode;

  /// No description provided for @codeSentToPhone.
  ///
  /// In ru, this message translates to:
  /// **'Код отправлен на номер'**
  String get codeSentToPhone;

  /// No description provided for @timeExpiredRequestNew.
  ///
  /// In ru, this message translates to:
  /// **'Время истекло. Запросите новый код'**
  String get timeExpiredRequestNew;

  /// No description provided for @verify.
  ///
  /// In ru, this message translates to:
  /// **'Верифицировать'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код повторно'**
  String get resendCode;

  /// No description provided for @backToLogin.
  ///
  /// In ru, this message translates to:
  /// **'Назад к входу'**
  String get backToLogin;

  /// No description provided for @news.
  ///
  /// In ru, this message translates to:
  /// **'Новости'**
  String get news;

  /// No description provided for @latestNews.
  ///
  /// In ru, this message translates to:
  /// **'Последние новости'**
  String get latestNews;

  /// No description provided for @newsLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки новостей'**
  String get newsLoadError;

  /// No description provided for @unknownError.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная ошибка'**
  String get unknownError;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @noNewsYet.
  ///
  /// In ru, this message translates to:
  /// **'Новостей пока нет'**
  String get noNewsYet;

  /// No description provided for @checkLater.
  ///
  /// In ru, this message translates to:
  /// **'Проверьте позже'**
  String get checkLater;

  /// No description provided for @selectCategory.
  ///
  /// In ru, this message translates to:
  /// **'Выберите категорию'**
  String get selectCategory;

  /// No description provided for @dateNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Дата не указана'**
  String get dateNotSpecified;

  /// No description provided for @today.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In ru, this message translates to:
  /// **'{days} д. назад'**
  String daysAgo(int days);

  /// No description provided for @singleNewsLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки новости'**
  String get singleNewsLoadError;

  /// No description provided for @back.
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get back;

  /// No description provided for @newsNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Новости не найдены'**
  String get newsNotFound;

  /// No description provided for @tryLater.
  ///
  /// In ru, this message translates to:
  /// **'Попробуйте позже'**
  String get tryLater;

  /// No description provided for @countries.
  ///
  /// In ru, this message translates to:
  /// **'Страны'**
  String get countries;

  /// No description provided for @selectedCountry.
  ///
  /// In ru, this message translates to:
  /// **'Выбрана страна'**
  String get selectedCountry;

  /// No description provided for @saveCountryError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сохранения страны'**
  String get saveCountryError;

  /// No description provided for @loadingError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки'**
  String get loadingError;

  /// No description provided for @noCountriesData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных о странах'**
  String get noCountriesData;

  /// No description provided for @nationalTeam.
  ///
  /// In ru, this message translates to:
  /// **'Сборная'**
  String get nationalTeam;

  /// No description provided for @round.
  ///
  /// In ru, this message translates to:
  /// **'Тур'**
  String get round;

  /// No description provided for @statistics.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get statistics;

  /// No description provided for @lineup.
  ///
  /// In ru, this message translates to:
  /// **'Состав'**
  String get lineup;

  /// No description provided for @players.
  ///
  /// In ru, this message translates to:
  /// **'Игроки'**
  String get players;

  /// No description provided for @loadingErrorWithMessage.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки:'**
  String get loadingErrorWithMessage;

  /// No description provided for @selectLineupTabToLoad.
  ///
  /// In ru, this message translates to:
  /// **'Выберите вкладку \'Состав\' для загрузки состава'**
  String get selectLineupTabToLoad;

  /// No description provided for @selectPlayersTabToLoad.
  ///
  /// In ru, this message translates to:
  /// **'Выберите вкладку \'Статистика игроков\' для загрузки'**
  String get selectPlayersTabToLoad;

  /// No description provided for @ballPossession.
  ///
  /// In ru, this message translates to:
  /// **'Владение мячом'**
  String get ballPossession;

  /// No description provided for @shots.
  ///
  /// In ru, this message translates to:
  /// **'Удары'**
  String get shots;

  /// No description provided for @shotsOnGoal.
  ///
  /// In ru, this message translates to:
  /// **'Удары в створ'**
  String get shotsOnGoal;

  /// No description provided for @shotsOffGoal.
  ///
  /// In ru, this message translates to:
  /// **'Удары мимо'**
  String get shotsOffGoal;

  /// No description provided for @fouls.
  ///
  /// In ru, this message translates to:
  /// **'Фолы'**
  String get fouls;

  /// No description provided for @yellowCards.
  ///
  /// In ru, this message translates to:
  /// **'Желтые карточки'**
  String get yellowCards;

  /// No description provided for @refereeTeam.
  ///
  /// In ru, this message translates to:
  /// **'Судейская бригада'**
  String get refereeTeam;

  /// No description provided for @mainReferee.
  ///
  /// In ru, this message translates to:
  /// **'Главный судья:'**
  String get mainReferee;

  /// No description provided for @firstAssistant.
  ///
  /// In ru, this message translates to:
  /// **'1-й помощник:'**
  String get firstAssistant;

  /// No description provided for @secondAssistant.
  ///
  /// In ru, this message translates to:
  /// **'2-й помощник:'**
  String get secondAssistant;

  /// No description provided for @fourthReferee.
  ///
  /// In ru, this message translates to:
  /// **'4-й судья:'**
  String get fourthReferee;

  /// No description provided for @coachingStaff.
  ///
  /// In ru, this message translates to:
  /// **'Тренерский штаб'**
  String get coachingStaff;

  /// No description provided for @headCoach.
  ///
  /// In ru, this message translates to:
  /// **'Главный тренер'**
  String get headCoach;

  /// No description provided for @assistants.
  ///
  /// In ru, this message translates to:
  /// **'Ассистенты'**
  String get assistants;

  /// No description provided for @goalkeeper.
  ///
  /// In ru, this message translates to:
  /// **'ВР'**
  String get goalkeeper;

  /// No description provided for @goalkeeperFull.
  ///
  /// In ru, this message translates to:
  /// **'Вратарь'**
  String get goalkeeperFull;

  /// No description provided for @fieldPlayer.
  ///
  /// In ru, this message translates to:
  /// **'Полевой игрок'**
  String get fieldPlayer;

  /// No description provided for @onTarget.
  ///
  /// In ru, this message translates to:
  /// **'В створ'**
  String get onTarget;

  /// No description provided for @passes.
  ///
  /// In ru, this message translates to:
  /// **'Передачи'**
  String get passes;

  /// No description provided for @offTarget.
  ///
  /// In ru, this message translates to:
  /// **'Мимо створа'**
  String get offTarget;

  /// No description provided for @yellows.
  ///
  /// In ru, this message translates to:
  /// **'Желтые'**
  String get yellows;

  /// No description provided for @offsides.
  ///
  /// In ru, this message translates to:
  /// **'Офсайды'**
  String get offsides;

  /// No description provided for @corners.
  ///
  /// In ru, this message translates to:
  /// **'Угловые'**
  String get corners;

  /// No description provided for @additionalStats.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительная статистика'**
  String get additionalStats;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @loadingTournaments.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка турниров...'**
  String get loadingTournaments;

  /// No description provided for @pleaseWait.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, подождите'**
  String get pleaseWait;

  /// No description provided for @tournaments.
  ///
  /// In ru, this message translates to:
  /// **'Турниры'**
  String get tournaments;

  /// No description provided for @tournamentsNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Турниры не найдены'**
  String get tournamentsNotFound;

  /// No description provided for @tournamentsLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки турниров'**
  String get tournamentsLoadError;

  /// No description provided for @table.
  ///
  /// In ru, this message translates to:
  /// **'Таблица'**
  String get table;

  /// No description provided for @results.
  ///
  /// In ru, this message translates to:
  /// **'Результаты'**
  String get results;

  /// No description provided for @tableLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки турнирной таблицы'**
  String get tableLoadError;

  /// No description provided for @matchesLoadError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки результатов матчей'**
  String get matchesLoadError;

  /// No description provided for @selectResultsTab.
  ///
  /// In ru, this message translates to:
  /// **'Выберите вкладку \'Результаты\' для загрузки матчей'**
  String get selectResultsTab;

  /// No description provided for @position.
  ///
  /// In ru, this message translates to:
  /// **'№'**
  String get position;

  /// No description provided for @team.
  ///
  /// In ru, this message translates to:
  /// **'Команда'**
  String get team;

  /// No description provided for @matchesPlayed.
  ///
  /// In ru, this message translates to:
  /// **'И'**
  String get matchesPlayed;

  /// No description provided for @goalsScored.
  ///
  /// In ru, this message translates to:
  /// **'Г'**
  String get goalsScored;

  /// No description provided for @points.
  ///
  /// In ru, this message translates to:
  /// **'О'**
  String get points;

  /// No description provided for @allNews.
  ///
  /// In ru, this message translates to:
  /// **'Все новости'**
  String get allNews;

  /// No description provided for @nationalTeamGames.
  ///
  /// In ru, this message translates to:
  /// **'Игры сборной'**
  String get nationalTeamGames;

  /// No description provided for @allGames.
  ///
  /// In ru, this message translates to:
  /// **'Все игры'**
  String get allGames;

  /// No description provided for @clubGames.
  ///
  /// In ru, this message translates to:
  /// **'Клубные игры'**
  String get clubGames;

  /// No description provided for @noUpcomingMatches.
  ///
  /// In ru, this message translates to:
  /// **'Нет предстоящих матчей'**
  String get noUpcomingMatches;

  /// No description provided for @noPastMatches.
  ///
  /// In ru, this message translates to:
  /// **'Нет прошедших матчей'**
  String get noPastMatches;

  /// No description provided for @matchesWillBeDisplayed.
  ///
  /// In ru, this message translates to:
  /// **'Матчи будут отображены, когда станут доступны'**
  String get matchesWillBeDisplayed;

  /// No description provided for @tournamentNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Турнир не указан'**
  String get tournamentNotSpecified;

  /// No description provided for @team1.
  ///
  /// In ru, this message translates to:
  /// **'Команда 1'**
  String get team1;

  /// No description provided for @team2.
  ///
  /// In ru, this message translates to:
  /// **'Команда 2'**
  String get team2;

  /// No description provided for @timeNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Время не указано'**
  String get timeNotSpecified;

  /// No description provided for @invalidFormat.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат'**
  String get invalidFormat;

  /// No description provided for @premierLeague.
  ///
  /// In ru, this message translates to:
  /// **'ПРЕМЬЕР ЛИГА'**
  String get premierLeague;

  /// No description provided for @ofKazakhstan.
  ///
  /// In ru, this message translates to:
  /// **'Казахстана'**
  String get ofKazakhstan;

  /// No description provided for @daysAgoShort.
  ///
  /// In ru, this message translates to:
  /// **'дн. назад'**
  String get daysAgoShort;

  /// No description provided for @hoursAgoShort.
  ///
  /// In ru, this message translates to:
  /// **'ч. назад'**
  String get hoursAgoShort;

  /// No description provided for @minutesAgoShort.
  ///
  /// In ru, this message translates to:
  /// **'мин. назад'**
  String get minutesAgoShort;

  /// No description provided for @justNow.
  ///
  /// In ru, this message translates to:
  /// **'Только что'**
  String get justNow;

  /// No description provided for @nationalTeamMatches.
  ///
  /// In ru, this message translates to:
  /// **'Матчи Сборной'**
  String get nationalTeamMatches;

  /// No description provided for @loadingLeagues.
  ///
  /// In ru, this message translates to:
  /// **'Загружаем лиги...'**
  String get loadingLeagues;

  /// No description provided for @selectNationalTeam.
  ///
  /// In ru, this message translates to:
  /// **'Выберите сборную'**
  String get selectNationalTeam;

  /// No description provided for @untitled.
  ///
  /// In ru, this message translates to:
  /// **'Без названия'**
  String get untitled;

  /// No description provided for @future.
  ///
  /// In ru, this message translates to:
  /// **'Будущие'**
  String get future;

  /// No description provided for @past.
  ///
  /// In ru, this message translates to:
  /// **'Прошлые'**
  String get past;

  /// No description provided for @coaches.
  ///
  /// In ru, this message translates to:
  /// **'Тренеры'**
  String get coaches;

  /// No description provided for @noAvailableLeagues.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных лиг'**
  String get noAvailableLeagues;

  /// No description provided for @tryReloadPage.
  ///
  /// In ru, this message translates to:
  /// **'Попробуйте обновить страницу'**
  String get tryReloadPage;

  /// No description provided for @tour.
  ///
  /// In ru, this message translates to:
  /// **'ТУР'**
  String get tour;

  /// No description provided for @noPlayers.
  ///
  /// In ru, this message translates to:
  /// **'Нет игроков'**
  String get noPlayers;

  /// No description provided for @fullName.
  ///
  /// In ru, this message translates to:
  /// **'ФИО'**
  String get fullName;

  /// No description provided for @club.
  ///
  /// In ru, this message translates to:
  /// **'Клуб'**
  String get club;

  /// No description provided for @games.
  ///
  /// In ru, this message translates to:
  /// **'Игр'**
  String get games;

  /// No description provided for @clubNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Клуб не указан'**
  String get clubNotSpecified;

  /// No description provided for @noCoaches.
  ///
  /// In ru, this message translates to:
  /// **'Нет тренеров'**
  String get noCoaches;

  /// No description provided for @positionNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Должность не указана'**
  String get positionNotSpecified;

  /// No description provided for @nationalityNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Национальность не указана'**
  String get nationalityNotSpecified;

  /// No description provided for @clubMatches.
  ///
  /// In ru, this message translates to:
  /// **'Клубные матчи'**
  String get clubMatches;

  /// No description provided for @matchesLoadingError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки матчей'**
  String get matchesLoadingError;

  /// No description provided for @tournament.
  ///
  /// In ru, this message translates to:
  /// **'Турнир'**
  String get tournament;

  /// No description provided for @stadiumNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Стадион не указан'**
  String get stadiumNotSpecified;

  /// No description provided for @attendance.
  ///
  /// In ru, this message translates to:
  /// **'Посещаемость'**
  String get attendance;

  /// No description provided for @matchProtocol.
  ///
  /// In ru, this message translates to:
  /// **'Протокол матча'**
  String get matchProtocol;

  /// No description provided for @invalidDateFormat.
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат даты'**
  String get invalidDateFormat;

  /// No description provided for @matchDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детали матча'**
  String get matchDetails;

  /// No description provided for @dateAndTime.
  ///
  /// In ru, this message translates to:
  /// **'Дата и время'**
  String get dateAndTime;

  /// No description provided for @status.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get status;

  /// No description provided for @additionalInfo.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительная информация'**
  String get additionalInfo;

  /// No description provided for @attendanceCount.
  ///
  /// In ru, this message translates to:
  /// **'Посещаемость'**
  String get attendanceCount;

  /// No description provided for @downloadPdf.
  ///
  /// In ru, this message translates to:
  /// **'Скачать PDF'**
  String get downloadPdf;

  /// No description provided for @videoOverview.
  ///
  /// In ru, this message translates to:
  /// **'Видеообзор'**
  String get videoOverview;

  /// No description provided for @watchOnYoutube.
  ///
  /// In ru, this message translates to:
  /// **'Смотреть на YouTube'**
  String get watchOnYoutube;

  /// No description provided for @scheduled.
  ///
  /// In ru, this message translates to:
  /// **'Запланирован'**
  String get scheduled;

  /// No description provided for @finished.
  ///
  /// In ru, this message translates to:
  /// **'Завершен'**
  String get finished;

  /// No description provided for @canceled.
  ///
  /// In ru, this message translates to:
  /// **'Отменен'**
  String get canceled;

  /// No description provided for @unknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестно'**
  String get unknown;

  /// No description provided for @stadium.
  ///
  /// In ru, this message translates to:
  /// **'Стадион'**
  String get stadium;

  /// No description provided for @notSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Не указано'**
  String get notSpecified;

  /// No description provided for @stadiumNameNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Название не указано'**
  String get stadiumNameNotSpecified;

  /// No description provided for @matches.
  ///
  /// In ru, this message translates to:
  /// **'Матчи'**
  String get matches;

  /// No description provided for @activeMatch.
  ///
  /// In ru, this message translates to:
  /// **'Активный матч'**
  String get activeMatch;

  /// No description provided for @tickets.
  ///
  /// In ru, this message translates to:
  /// **'Билеты'**
  String get tickets;

  /// No description provided for @yourTickets.
  ///
  /// In ru, this message translates to:
  /// **'Ваши билеты'**
  String get yourTickets;

  /// No description provided for @availableTickets.
  ///
  /// In ru, this message translates to:
  /// **'Доступные билеты'**
  String get availableTickets;

  /// No description provided for @liveNow.
  ///
  /// In ru, this message translates to:
  /// **'Прямо эфир'**
  String get liveNow;

  /// No description provided for @showQrToController.
  ///
  /// In ru, this message translates to:
  /// **'Покажите QR Контролеру'**
  String get showQrToController;

  /// No description provided for @close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get close;

  /// No description provided for @buyMore.
  ///
  /// In ru, this message translates to:
  /// **'Купить еще'**
  String get buyMore;

  /// No description provided for @myTicket.
  ///
  /// In ru, this message translates to:
  /// **'Мой билет'**
  String get myTicket;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @takePhoto.
  ///
  /// In ru, this message translates to:
  /// **'Сделать фото'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать из галереи'**
  String get chooseFromGallery;

  /// No description provided for @takeNewPhoto.
  ///
  /// In ru, this message translates to:
  /// **'Сделать новое фото'**
  String get takeNewPhoto;

  /// No description provided for @chooseNewFromGallery.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать новое из галереи'**
  String get chooseNewFromGallery;

  /// No description provided for @deletePhoto.
  ///
  /// In ru, this message translates to:
  /// **'Удалить фото'**
  String get deletePhoto;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @selectedFileEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Выбранный файл пуст'**
  String get selectedFileEmpty;

  /// No description provided for @fileNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Файл не найден'**
  String get fileNotFound;

  /// No description provided for @errorAccessingCameraGallery.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка доступа к камере/галерее'**
  String get errorAccessingCameraGallery;

  /// No description provided for @photoAccessDenied.
  ///
  /// In ru, this message translates to:
  /// **'Доступ к фото запрещен. Проверьте разрешения в настройках'**
  String get photoAccessDenied;

  /// No description provided for @cameraAccessDenied.
  ///
  /// In ru, this message translates to:
  /// **'Доступ к камере запрещен. Проверьте разрешения в настройках'**
  String get cameraAccessDenied;

  /// No description provided for @cameraConnectionError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения к камере. Попробуйте перезапустить приложение'**
  String get cameraConnectionError;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @errorSelectingImage.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при выборе изображения'**
  String get errorSelectingImage;

  /// No description provided for @profilePhotoUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Фото профиля обновлено'**
  String get profilePhotoUpdated;

  /// No description provided for @profilePhotoDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Фото профиля удалено'**
  String get profilePhotoDeleted;

  /// No description provided for @errorOnLogout.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при выходе'**
  String get errorOnLogout;

  /// No description provided for @data.
  ///
  /// In ru, this message translates to:
  /// **'Данные'**
  String get data;

  /// No description provided for @personalInformation.
  ///
  /// In ru, this message translates to:
  /// **'Личная информация'**
  String get personalInformation;

  /// No description provided for @lastName.
  ///
  /// In ru, this message translates to:
  /// **'Фамилия'**
  String get lastName;

  /// No description provided for @firstName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get firstName;

  /// No description provided for @patronymicOptional.
  ///
  /// In ru, this message translates to:
  /// **'Отчество (необязательно)'**
  String get patronymicOptional;

  /// No description provided for @email.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get phoneNumber;

  /// No description provided for @iinOptional.
  ///
  /// In ru, this message translates to:
  /// **'ИИН (необязательно)'**
  String get iinOptional;

  /// No description provided for @saveChanges.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить изменения'**
  String get saveChanges;

  /// No description provided for @profileSuccessfullyUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Профиль успешно обновлен'**
  String get profileSuccessfullyUpdated;

  /// No description provided for @security.
  ///
  /// In ru, this message translates to:
  /// **'Безопасность'**
  String get security;

  /// No description provided for @passwordChange.
  ///
  /// In ru, this message translates to:
  /// **'Изменение пароля'**
  String get passwordChange;

  /// No description provided for @currentPassword.
  ///
  /// In ru, this message translates to:
  /// **'Текущий пароль'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль'**
  String get newPassword;

  /// No description provided for @repeatNewPassword.
  ///
  /// In ru, this message translates to:
  /// **'Повторите новый пароль'**
  String get repeatNewPassword;

  /// No description provided for @updatePassword.
  ///
  /// In ru, this message translates to:
  /// **'Обновить пароль'**
  String get updatePassword;

  /// No description provided for @passwordSuccessfullyUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Пароль успешно обновлен'**
  String get passwordSuccessfullyUpdated;

  /// No description provided for @newPasswordMustDiffer.
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль должен отличаться от текущего'**
  String get newPasswordMustDiffer;

  /// No description provided for @changePassword.
  ///
  /// In ru, this message translates to:
  /// **'Поменять пароль'**
  String get changePassword;

  /// No description provided for @changeEmail.
  ///
  /// In ru, this message translates to:
  /// **'Поменять почту'**
  String get changeEmail;

  /// No description provided for @deleteAccount.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get deleteAccount;

  /// No description provided for @oldPassword.
  ///
  /// In ru, this message translates to:
  /// **'Старый пароль'**
  String get oldPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите старый пароль'**
  String get enterOldPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите новый пароль'**
  String get enterNewPassword;

  /// No description provided for @editProfile.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfile;

  /// No description provided for @personalData.
  ///
  /// In ru, this message translates to:
  /// **'Личные данные'**
  String get personalData;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выход'**
  String get logout;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите текущий пароль'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPasswordField.
  ///
  /// In ru, this message translates to:
  /// **'Введите новый пароль'**
  String get enterNewPasswordField;

  /// No description provided for @repeatNewPasswordField.
  ///
  /// In ru, this message translates to:
  /// **'Повторите новый пароль'**
  String get repeatNewPasswordField;

  /// No description provided for @shop.
  ///
  /// In ru, this message translates to:
  /// **'Магазин'**
  String get shop;

  /// No description provided for @fields.
  ///
  /// In ru, this message translates to:
  /// **'Поля'**
  String get fields;

  /// No description provided for @sections.
  ///
  /// In ru, this message translates to:
  /// **'Секции'**
  String get sections;

  /// No description provided for @years.
  ///
  /// In ru, this message translates to:
  /// **'лет'**
  String get years;

  /// No description provided for @schedule.
  ///
  /// In ru, this message translates to:
  /// **'Расписание'**
  String get schedule;

  /// No description provided for @noScheduleYet.
  ///
  /// In ru, this message translates to:
  /// **'Расписания пока нет'**
  String get noScheduleYet;

  /// No description provided for @groups.
  ///
  /// In ru, this message translates to:
  /// **'Группы'**
  String get groups;

  /// No description provided for @recruitmentOpen.
  ///
  /// In ru, this message translates to:
  /// **'Набор открыт'**
  String get recruitmentOpen;

  /// No description provided for @recruitmentClosed.
  ///
  /// In ru, this message translates to:
  /// **'Набор закрыт'**
  String get recruitmentClosed;

  /// No description provided for @month.
  ///
  /// In ru, this message translates to:
  /// **'мес'**
  String get month;

  /// No description provided for @free.
  ///
  /// In ru, this message translates to:
  /// **'Бесплатно'**
  String get free;

  /// No description provided for @minutes.
  ///
  /// In ru, this message translates to:
  /// **'мин'**
  String get minutes;

  /// No description provided for @students.
  ///
  /// In ru, this message translates to:
  /// **'учеников'**
  String get students;

  /// No description provided for @errorOccurred.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка'**
  String get errorOccurred;

  /// No description provided for @goBack.
  ///
  /// In ru, this message translates to:
  /// **'Вернуться'**
  String get goBack;

  /// No description provided for @imageNotAvailable.
  ///
  /// In ru, this message translates to:
  /// **'Изображение недоступно'**
  String get imageNotAvailable;

  /// No description provided for @imageLoadingError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки изображения'**
  String get imageLoadingError;

  /// No description provided for @addedToFavorites.
  ///
  /// In ru, this message translates to:
  /// **'Добавлено в избранное'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In ru, this message translates to:
  /// **'Убрано из избранного'**
  String get removedFromFavorites;

  /// No description provided for @productAddedToCart.
  ///
  /// In ru, this message translates to:
  /// **'Товар добавлен в корзину'**
  String get productAddedToCart;

  /// No description provided for @toCart.
  ///
  /// In ru, this message translates to:
  /// **'В корзину'**
  String get toCart;

  /// No description provided for @article.
  ///
  /// In ru, this message translates to:
  /// **'Арт:'**
  String get article;

  /// No description provided for @forChildren.
  ///
  /// In ru, this message translates to:
  /// **'Для детей'**
  String get forChildren;

  /// No description provided for @forAdults.
  ///
  /// In ru, this message translates to:
  /// **'Для взрослых'**
  String get forAdults;

  /// No description provided for @unisex.
  ///
  /// In ru, this message translates to:
  /// **'Унисекс'**
  String get unisex;

  /// No description provided for @forMen.
  ///
  /// In ru, this message translates to:
  /// **'Для мужчин'**
  String get forMen;

  /// No description provided for @forWomen.
  ///
  /// In ru, this message translates to:
  /// **'Для женщин'**
  String get forWomen;

  /// No description provided for @inStock.
  ///
  /// In ru, this message translates to:
  /// **'В наличии'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In ru, this message translates to:
  /// **'Нет в наличии'**
  String get outOfStock;

  /// No description provided for @variants.
  ///
  /// In ru, this message translates to:
  /// **'Варианты'**
  String get variants;

  /// No description provided for @price.
  ///
  /// In ru, this message translates to:
  /// **'Цена'**
  String get price;

  /// No description provided for @add.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// No description provided for @addToCart.
  ///
  /// In ru, this message translates to:
  /// **'Добавить в корзину'**
  String get addToCart;

  /// No description provided for @astanaFacilities.
  ///
  /// In ru, this message translates to:
  /// **'Астана: 256 сооружений'**
  String get astanaFacilities;

  /// No description provided for @addFacility.
  ///
  /// In ru, this message translates to:
  /// **'Добавить площадку'**
  String get addFacility;

  /// No description provided for @filters.
  ///
  /// In ru, this message translates to:
  /// **'Фильтры'**
  String get filters;

  /// No description provided for @searchFreeTime.
  ///
  /// In ru, this message translates to:
  /// **'Поиск свободного времени'**
  String get searchFreeTime;

  /// No description provided for @book.
  ///
  /// In ru, this message translates to:
  /// **'Забронировать'**
  String get book;

  /// No description provided for @selectTime.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время'**
  String get selectTime;

  /// No description provided for @pay.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить'**
  String get pay;

  /// No description provided for @fieldRental.
  ///
  /// In ru, this message translates to:
  /// **'Аренда полей'**
  String get fieldRental;

  /// No description provided for @searchFilters.
  ///
  /// In ru, this message translates to:
  /// **'Фильтры поиска'**
  String get searchFilters;

  /// No description provided for @minimumThreeCharacters.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 3 символа'**
  String get minimumThreeCharacters;

  /// No description provided for @maximumTwoHundredFiftyFiveCharacters.
  ///
  /// In ru, this message translates to:
  /// **'Максимум 255 символов'**
  String get maximumTwoHundredFiftyFiveCharacters;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @enterFieldName.
  ///
  /// In ru, this message translates to:
  /// **'Введите название поля...'**
  String get enterFieldName;

  /// No description provided for @selectCity.
  ///
  /// In ru, this message translates to:
  /// **'Выберите город'**
  String get selectCity;

  /// No description provided for @apply.
  ///
  /// In ru, this message translates to:
  /// **'Применить'**
  String get apply;

  /// No description provided for @noMoreFields.
  ///
  /// In ru, this message translates to:
  /// **'Больше полей нет'**
  String get noMoreFields;

  /// No description provided for @sectionRegistration.
  ///
  /// In ru, this message translates to:
  /// **'Запись в секцию'**
  String get sectionRegistration;

  /// No description provided for @enterSectionName.
  ///
  /// In ru, this message translates to:
  /// **'Введите название секции...'**
  String get enterSectionName;

  /// No description provided for @gender.
  ///
  /// In ru, this message translates to:
  /// **'Пол'**
  String get gender;

  /// No description provided for @any.
  ///
  /// In ru, this message translates to:
  /// **'Любой'**
  String get any;

  /// No description provided for @male.
  ///
  /// In ru, this message translates to:
  /// **'М'**
  String get male;

  /// No description provided for @female.
  ///
  /// In ru, this message translates to:
  /// **'Ж'**
  String get female;

  /// No description provided for @age.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get age;

  /// No description provided for @from.
  ///
  /// In ru, this message translates to:
  /// **'От'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ru, this message translates to:
  /// **'До'**
  String get to;

  /// No description provided for @averagePrice.
  ///
  /// In ru, this message translates to:
  /// **'Средняя цена'**
  String get averagePrice;

  /// No description provided for @priceFrom.
  ///
  /// In ru, this message translates to:
  /// **'Цена от'**
  String get priceFrom;

  /// No description provided for @priceTo.
  ///
  /// In ru, this message translates to:
  /// **'Цена до'**
  String get priceTo;

  /// No description provided for @noMoreSections.
  ///
  /// In ru, this message translates to:
  /// **'Больше секций нет'**
  String get noMoreSections;

  /// No description provided for @newProducts.
  ///
  /// In ru, this message translates to:
  /// **'Новые товары'**
  String get newProducts;

  /// No description provided for @categories.
  ///
  /// In ru, this message translates to:
  /// **'Категории'**
  String get categories;

  /// No description provided for @buy.
  ///
  /// In ru, this message translates to:
  /// **'Купить'**
  String get buy;

  /// No description provided for @firstLeague.
  ///
  /// In ru, this message translates to:
  /// **'Первая лига'**
  String get firstLeague;

  /// No description provided for @activeTickets.
  ///
  /// In ru, this message translates to:
  /// **'Активные билеты'**
  String get activeTickets;

  /// No description provided for @buyTickets.
  ///
  /// In ru, this message translates to:
  /// **'Купить билеты'**
  String get buyTickets;

  /// No description provided for @buyBooking.
  ///
  /// In ru, this message translates to:
  /// **'Купить бронь'**
  String get buyBooking;

  /// No description provided for @payOrder.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить заказ'**
  String get payOrder;

  /// No description provided for @loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка...'**
  String get loading;

  /// No description provided for @httpError.
  ///
  /// In ru, this message translates to:
  /// **'HTTP ошибка'**
  String get httpError;

  /// No description provided for @tryAgain.
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get tryAgain;

  /// No description provided for @repeatPayment.
  ///
  /// In ru, this message translates to:
  /// **'Повторная оплата'**
  String get repeatPayment;

  /// No description provided for @loadingPayment.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка оплаты...'**
  String get loadingPayment;

  /// No description provided for @noActiveTicketsYet.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет активных билетов'**
  String get noActiveTicketsYet;

  /// No description provided for @city.
  ///
  /// In ru, this message translates to:
  /// **'Город'**
  String get city;

  /// No description provided for @event.
  ///
  /// In ru, this message translates to:
  /// **'Событие'**
  String get event;

  /// No description provided for @venueNotSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Место не указано'**
  String get venueNotSpecified;

  /// No description provided for @sport.
  ///
  /// In ru, this message translates to:
  /// **'СПОРТ'**
  String get sport;

  /// No description provided for @venue.
  ///
  /// In ru, this message translates to:
  /// **'Место проведения'**
  String get venue;

  /// No description provided for @pleaseAuthorize.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, пройдите авторизацию'**
  String get pleaseAuthorize;

  /// No description provided for @youHaveNoOrdersYet.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет заказов'**
  String get youHaveNoOrdersYet;

  /// No description provided for @orderedTicketsWillAppearHere.
  ///
  /// In ru, this message translates to:
  /// **'Заказанные билеты будут отображаться здесь'**
  String get orderedTicketsWillAppearHere;

  /// No description provided for @orderDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детали заказа #'**
  String get orderDetails;

  /// No description provided for @genre.
  ///
  /// In ru, this message translates to:
  /// **'Жанр:'**
  String get genre;

  /// No description provided for @duration.
  ///
  /// In ru, this message translates to:
  /// **'Длительность:'**
  String get duration;

  /// No description provided for @unknownLocation.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестное место'**
  String get unknownLocation;

  /// No description provided for @unknownCity.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестный город'**
  String get unknownCity;

  /// No description provided for @hall.
  ///
  /// In ru, this message translates to:
  /// **'Зал:'**
  String get hall;

  /// No description provided for @unknownHall.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестный зал'**
  String get unknownHall;

  /// No description provided for @ticket.
  ///
  /// In ru, this message translates to:
  /// **'Билет'**
  String get ticket;

  /// No description provided for @row.
  ///
  /// In ru, this message translates to:
  /// **'Ряд'**
  String get row;

  /// No description provided for @seat.
  ///
  /// In ru, this message translates to:
  /// **'Место'**
  String get seat;

  /// No description provided for @level.
  ///
  /// In ru, this message translates to:
  /// **'Уровень:'**
  String get level;

  /// No description provided for @orderInformation.
  ///
  /// In ru, this message translates to:
  /// **'Информация о заказе'**
  String get orderInformation;

  /// No description provided for @ticketCount.
  ///
  /// In ru, this message translates to:
  /// **'Количество билетов'**
  String get ticketCount;

  /// No description provided for @totalCost.
  ///
  /// In ru, this message translates to:
  /// **'Общая стоимость'**
  String get totalCost;

  /// No description provided for @phone.
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get phone;

  /// No description provided for @dateCreated.
  ///
  /// In ru, this message translates to:
  /// **'Дата создания'**
  String get dateCreated;

  /// No description provided for @cancellationReason.
  ///
  /// In ru, this message translates to:
  /// **'Причина отмены'**
  String get cancellationReason;

  /// No description provided for @cancelOrder.
  ///
  /// In ru, this message translates to:
  /// **'Отмена заказа'**
  String get cancelOrder;

  /// No description provided for @showPass.
  ///
  /// In ru, this message translates to:
  /// **'Показать пропуск'**
  String get showPass;

  /// No description provided for @statusCanceled.
  ///
  /// In ru, this message translates to:
  /// **'ОТМЕНЕН'**
  String get statusCanceled;

  /// No description provided for @statusPaid.
  ///
  /// In ru, this message translates to:
  /// **'ОПЛАЧЕН'**
  String get statusPaid;

  /// No description provided for @statusActive.
  ///
  /// In ru, this message translates to:
  /// **'АКТИВЕН'**
  String get statusActive;

  /// No description provided for @statusInactive.
  ///
  /// In ru, this message translates to:
  /// **'НЕАКТИВЕН'**
  String get statusInactive;

  /// No description provided for @eventPass.
  ///
  /// In ru, this message translates to:
  /// **'Пропуск на мероприятие'**
  String get eventPass;

  /// No description provided for @order.
  ///
  /// In ru, this message translates to:
  /// **'Заказ'**
  String get order;

  /// No description provided for @loadingPass.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка пропуска...'**
  String get loadingPass;

  /// No description provided for @passLoadingError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки пропуска'**
  String get passLoadingError;

  /// No description provided for @qrCodeUnavailable.
  ///
  /// In ru, this message translates to:
  /// **'QR-код недоступен'**
  String get qrCodeUnavailable;

  /// No description provided for @qrCodesNotFound.
  ///
  /// In ru, this message translates to:
  /// **'QR-коды не найдены'**
  String get qrCodesNotFound;

  /// No description provided for @amount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма'**
  String get amount;

  /// No description provided for @success.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено успешно'**
  String get success;

  /// No description provided for @ticketsCount.
  ///
  /// In ru, this message translates to:
  /// **'Билетов'**
  String get ticketsCount;

  /// No description provided for @details.
  ///
  /// In ru, this message translates to:
  /// **'Подробнее'**
  String get details;

  /// No description provided for @selectCountryFirst.
  ///
  /// In ru, this message translates to:
  /// **'Сначала выберите страну'**
  String get selectCountryFirst;

  /// No description provided for @season.
  ///
  /// In ru, this message translates to:
  /// **'Сезон:'**
  String get season;

  /// No description provided for @tournamentSelected.
  ///
  /// In ru, this message translates to:
  /// **'Выбран турнир:'**
  String get tournamentSelected;

  /// No description provided for @tournamentSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сохранения турнира'**
  String get tournamentSaveError;

  /// No description provided for @selectTournament.
  ///
  /// In ru, this message translates to:
  /// **'Выберите турнир'**
  String get selectTournament;

  /// No description provided for @international.
  ///
  /// In ru, this message translates to:
  /// **'Межд.'**
  String get international;

  /// No description provided for @tournamentLoadingError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки турниров'**
  String get tournamentLoadingError;

  /// No description provided for @retryAttempt.
  ///
  /// In ru, this message translates to:
  /// **'Повторить попытку'**
  String get retryAttempt;

  /// No description provided for @searchTournaments.
  ///
  /// In ru, this message translates to:
  /// **'Поиск турниров...'**
  String get searchTournaments;

  /// No description provided for @maleTournaments.
  ///
  /// In ru, this message translates to:
  /// **'Мужские'**
  String get maleTournaments;

  /// No description provided for @femaleTournaments.
  ///
  /// In ru, this message translates to:
  /// **'Женские'**
  String get femaleTournaments;

  /// No description provided for @tryChangeSearchFilters.
  ///
  /// In ru, this message translates to:
  /// **'Попробуйте изменить фильтры поиска'**
  String get tryChangeSearchFilters;

  /// No description provided for @touchScreenToSkip.
  ///
  /// In ru, this message translates to:
  /// **'Коснитесь экрана, чтобы пропустить'**
  String get touchScreenToSkip;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение удаления аккаунта'**
  String get deleteAccountConfirmation;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountPermanently.
  ///
  /// In ru, this message translates to:
  /// **'Удалить навсегда'**
  String get deleteAccountPermanently;

  /// No description provided for @accountDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Аккаунт успешно удален'**
  String get accountDeleted;

  /// No description provided for @accountDeletionFailed.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления аккаунта'**
  String get accountDeletionFailed;

  /// No description provided for @myBookings.
  ///
  /// In ru, this message translates to:
  /// **'Мои брони'**
  String get myBookings;

  /// No description provided for @pending.
  ///
  /// In ru, this message translates to:
  /// **'Ожидает'**
  String get pending;

  /// No description provided for @paid.
  ///
  /// In ru, this message translates to:
  /// **'Оплачено'**
  String get paid;

  /// No description provided for @cancelled.
  ///
  /// In ru, this message translates to:
  /// **'Отмененные'**
  String get cancelled;

  /// No description provided for @bookingCancelledSuccessfully.
  ///
  /// In ru, this message translates to:
  /// **'Бронь успешно отменена'**
  String get bookingCancelledSuccessfully;

  /// No description provided for @repeat.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get repeat;

  /// No description provided for @noBookings.
  ///
  /// In ru, this message translates to:
  /// **'Нет броней'**
  String get noBookings;

  /// No description provided for @bookingDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детали брони'**
  String get bookingDetails;

  /// No description provided for @field.
  ///
  /// In ru, this message translates to:
  /// **'Поле'**
  String get field;

  /// No description provided for @date.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get date;

  /// No description provided for @time.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get time;

  /// No description provided for @total.
  ///
  /// In ru, this message translates to:
  /// **'Сумма'**
  String get total;

  /// No description provided for @address.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get address;

  /// No description provided for @cancelBooking.
  ///
  /// In ru, this message translates to:
  /// **'Отменить бронь'**
  String get cancelBooking;

  /// No description provided for @cancelBookingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отменить бронь?'**
  String get cancelBookingTitle;

  /// No description provided for @cancelBookingConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите отменить эту бронь? Это действие нельзя отменить.'**
  String get cancelBookingConfirmation;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @yesCancel.
  ///
  /// In ru, this message translates to:
  /// **'Да, отменить'**
  String get yesCancel;

  /// No description provided for @pleaseLogin.
  ///
  /// In ru, this message translates to:
  /// **'Выполните вход'**
  String get pleaseLogin;

  /// No description provided for @addedToCart.
  ///
  /// In ru, this message translates to:
  /// **'Добавлено в корзину'**
  String get addedToCart;

  /// No description provided for @selectQuantity.
  ///
  /// In ru, this message translates to:
  /// **'Выберите количество'**
  String get selectQuantity;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @myOrders.
  ///
  /// In ru, this message translates to:
  /// **'Мои заказы'**
  String get myOrders;

  /// No description provided for @viewPurchaseHistory.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть историю покупок'**
  String get viewPurchaseHistory;

  /// No description provided for @viewMyBookings.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть мои бронирования'**
  String get viewMyBookings;

  /// No description provided for @authorizationRequired.
  ///
  /// In ru, this message translates to:
  /// **'Требуется авторизация'**
  String get authorizationRequired;

  /// No description provided for @loginFirstToBook.
  ///
  /// In ru, this message translates to:
  /// **'Сначала войдите в аккаунт для бронирования'**
  String get loginFirstToBook;

  /// No description provided for @bookingRequestCreated.
  ///
  /// In ru, this message translates to:
  /// **'Запрос на бронирование создан'**
  String get bookingRequestCreated;

  /// No description provided for @cartCleared.
  ///
  /// In ru, this message translates to:
  /// **'Корзина очищена'**
  String get cartCleared;

  /// No description provided for @cartEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Корзина пуста'**
  String get cartEmpty;

  /// No description provided for @addItemsToCheckout.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте товары для оформления заказа'**
  String get addItemsToCheckout;

  /// No description provided for @clearCartQuestion.
  ///
  /// In ru, this message translates to:
  /// **'Очистить корзину?'**
  String get clearCartQuestion;

  /// No description provided for @allItemsWillBeRemoved.
  ///
  /// In ru, this message translates to:
  /// **'Все товары будут удалены из корзины'**
  String get allItemsWillBeRemoved;

  /// No description provided for @clear.
  ///
  /// In ru, this message translates to:
  /// **'Очистить'**
  String get clear;

  /// No description provided for @product.
  ///
  /// In ru, this message translates to:
  /// **'Товар'**
  String get product;

  /// No description provided for @totalToPay.
  ///
  /// In ru, this message translates to:
  /// **'Итого к оплате:'**
  String get totalToPay;

  /// No description provided for @proceedToPayment.
  ///
  /// In ru, this message translates to:
  /// **'Перейти к оплате'**
  String get proceedToPayment;

  /// No description provided for @awaitingPayment.
  ///
  /// In ru, this message translates to:
  /// **'Ожидают'**
  String get awaitingPayment;

  /// No description provided for @noOrdersYet.
  ///
  /// In ru, this message translates to:
  /// **'Заказов пока нет'**
  String get noOrdersYet;

  /// No description provided for @placeFirstOrderInShop.
  ///
  /// In ru, this message translates to:
  /// **'Оформите первый заказ в магазине'**
  String get placeFirstOrderInShop;

  /// No description provided for @paidOn.
  ///
  /// In ru, this message translates to:
  /// **'Оплачено'**
  String get paidOn;

  /// No description provided for @payBefore.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить до'**
  String get payBefore;

  /// No description provided for @cancelOrderConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите отменить этот заказ? Средства будут возвращены на ваш счет после подтверждения администрацией.'**
  String get cancelOrderConfirmation;

  /// No description provided for @deleteOrder.
  ///
  /// In ru, this message translates to:
  /// **'Удаление заказа'**
  String get deleteOrder;

  /// No description provided for @deleteOrderConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить этот заказ? Это действие нельзя отменить.'**
  String get deleteOrderConfirmation;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @orderDataNotAvailable.
  ///
  /// In ru, this message translates to:
  /// **'Данные заказа отсутствуют'**
  String get orderDataNotAvailable;

  /// No description provided for @itemsInOrder.
  ///
  /// In ru, this message translates to:
  /// **'Товары в заказе'**
  String get itemsInOrder;

  /// No description provided for @noItemsInOrder.
  ///
  /// In ru, this message translates to:
  /// **'Нет товаров в заказе'**
  String get noItemsInOrder;

  /// No description provided for @createdDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата создания'**
  String get createdDate;

  /// No description provided for @paymentDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата оплаты'**
  String get paymentDate;

  /// No description provided for @quantity.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во'**
  String get quantity;

  /// No description provided for @statusHistory.
  ///
  /// In ru, this message translates to:
  /// **'История статусов'**
  String get statusHistory;

  /// No description provided for @notifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications;

  /// No description provided for @stayUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Будьте в курсе событий'**
  String get stayUpdated;

  /// No description provided for @active.
  ///
  /// In ru, this message translates to:
  /// **'Активно'**
  String get active;

  /// No description provided for @newNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Новые'**
  String get newNotifications;

  /// No description provided for @readNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Прочитанные'**
  String get readNotifications;

  /// No description provided for @noReadNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Нет прочитанных уведомлений'**
  String get noReadNotifications;

  /// No description provided for @allCaughtUp.
  ///
  /// In ru, this message translates to:
  /// **'Всё прочитано!'**
  String get allCaughtUp;

  /// No description provided for @noReadNotificationsYet.
  ///
  /// In ru, this message translates to:
  /// **'Вы ещё не прочитали ни одного уведомления'**
  String get noReadNotificationsYet;

  /// No description provided for @noNewNotifications.
  ///
  /// In ru, this message translates to:
  /// **'У вас нет новых уведомлений'**
  String get noNewNotifications;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// No description provided for @created.
  ///
  /// In ru, this message translates to:
  /// **'Создано'**
  String get created;

  /// No description provided for @updated.
  ///
  /// In ru, this message translates to:
  /// **'Обновлено'**
  String get updated;

  /// No description provided for @openLink.
  ///
  /// In ru, this message translates to:
  /// **'Открыть ссылку'**
  String get openLink;

  /// No description provided for @navigate.
  ///
  /// In ru, this message translates to:
  /// **'Перейти'**
  String get navigate;

  /// No description provided for @newNotification.
  ///
  /// In ru, this message translates to:
  /// **'Новое уведомление'**
  String get newNotification;

  /// No description provided for @tapToView.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите для просмотра'**
  String get tapToView;

  /// No description provided for @hoursAgo.
  ///
  /// In ru, this message translates to:
  /// **'{hours} ч. назад'**
  String hoursAgo(int hours);

  /// No description provided for @minutesAgo.
  ///
  /// In ru, this message translates to:
  /// **'{minutes} мин. назад'**
  String minutesAgo(int minutes);

  /// No description provided for @cart.
  ///
  /// In ru, this message translates to:
  /// **'Корзина'**
  String get cart;

  /// No description provided for @enterPinCode.
  ///
  /// In ru, this message translates to:
  /// **'Введите PIN-код'**
  String get enterPinCode;

  /// No description provided for @appLogin.
  ///
  /// In ru, this message translates to:
  /// **'Вход в приложение'**
  String get appLogin;

  /// No description provided for @attemptsRemaining.
  ///
  /// In ru, this message translates to:
  /// **'Осталось попыток: {count}'**
  String attemptsRemaining(int count);

  /// No description provided for @confirmLoginWithBiometrics.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите вход с помощью биометрии'**
  String get confirmLoginWithBiometrics;

  /// No description provided for @confirmButton.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirmButton;

  /// No description provided for @useBiometrics.
  ///
  /// In ru, this message translates to:
  /// **'Использовать биометрию'**
  String get useBiometrics;

  /// No description provided for @loginWithDifferentAccount.
  ///
  /// In ru, this message translates to:
  /// **'Войти с другим аккаунтом'**
  String get loginWithDifferentAccount;

  /// No description provided for @attemptsExceededLoginAgain.
  ///
  /// In ru, this message translates to:
  /// **'Превышено количество попыток. Войдите заново.'**
  String get attemptsExceededLoginAgain;

  /// No description provided for @incorrectPinAttemptsRemaining.
  ///
  /// In ru, this message translates to:
  /// **'Неверный PIN-код. Осталось попыток: {count}'**
  String incorrectPinAttemptsRemaining(int count);

  /// No description provided for @failedToRefreshToken.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось обновить токен'**
  String get failedToRefreshToken;

  /// No description provided for @changePinCode.
  ///
  /// In ru, this message translates to:
  /// **'Изменить PIN-код'**
  String get changePinCode;

  /// No description provided for @createPinCode.
  ///
  /// In ru, this message translates to:
  /// **'Создать PIN-код'**
  String get createPinCode;

  /// No description provided for @enterOldAndNewPin.
  ///
  /// In ru, this message translates to:
  /// **'Введите старый PIN-код и новый для изменения'**
  String get enterOldAndNewPin;

  /// No description provided for @createFourDigitPin.
  ///
  /// In ru, this message translates to:
  /// **'Создайте 4-значный PIN-код для защиты приложения'**
  String get createFourDigitPin;

  /// No description provided for @oldPinCode.
  ///
  /// In ru, this message translates to:
  /// **'Старый PIN-код'**
  String get oldPinCode;

  /// No description provided for @newPinCode.
  ///
  /// In ru, this message translates to:
  /// **'Новый PIN-код'**
  String get newPinCode;

  /// No description provided for @pinCode.
  ///
  /// In ru, this message translates to:
  /// **'PIN-код'**
  String get pinCode;

  /// No description provided for @confirmPinCode.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите PIN-код'**
  String get confirmPinCode;

  /// No description provided for @updatePinCode.
  ///
  /// In ru, this message translates to:
  /// **'Обновить PIN-код'**
  String get updatePinCode;

  /// No description provided for @pinCodesDoNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'PIN-коды не совпадают'**
  String get pinCodesDoNotMatch;

  /// No description provided for @newPinCodesDoNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'Новые PIN-коды не совпадают'**
  String get newPinCodesDoNotMatch;

  /// No description provided for @pinCodeSuccessfullySet.
  ///
  /// In ru, this message translates to:
  /// **'PIN-код успешно установлен'**
  String get pinCodeSuccessfullySet;

  /// No description provided for @pinCodeSuccessfullyUpdated.
  ///
  /// In ru, this message translates to:
  /// **'PIN-код успешно обновлен'**
  String get pinCodeSuccessfullyUpdated;

  /// No description provided for @attemptsExceeded.
  ///
  /// In ru, this message translates to:
  /// **'Превышено количество попыток'**
  String get attemptsExceeded;

  /// No description provided for @incorrectOldPinAttemptsRemaining.
  ///
  /// In ru, this message translates to:
  /// **'Неверный старый PIN-код. Осталось попыток: {count}'**
  String incorrectOldPinAttemptsRemaining(int count);

  /// No description provided for @securitySetup.
  ///
  /// In ru, this message translates to:
  /// **'Настройка защиты'**
  String get securitySetup;

  /// No description provided for @useBiometricsOrCreatePin.
  ///
  /// In ru, this message translates to:
  /// **'Используйте биометрию или создайте PIN-код для защиты приложения'**
  String get useBiometricsOrCreatePin;

  /// No description provided for @continueButton.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить'**
  String get continueButton;

  /// No description provided for @giveAccessToData.
  ///
  /// In ru, this message translates to:
  /// **'Дайте доступ к данным'**
  String get giveAccessToData;

  /// No description provided for @privacyButton.
  ///
  /// In ru, this message translates to:
  /// **'Политика обработки персональных данных'**
  String get privacyButton;

  /// No description provided for @privacyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get privacyTitle;

  /// No description provided for @publicTitle.
  ///
  /// In ru, this message translates to:
  /// **'Публичный договор (оферта)'**
  String get publicTitle;

  /// No description provided for @publicMobileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Публичный договор-оферта мобильного приложения'**
  String get publicMobileTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
