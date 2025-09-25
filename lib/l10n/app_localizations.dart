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
  /// **'Зарегистрировать'**
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
  /// **'дн. назад'**
  String get daysAgo;

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
  /// **'Ошибка загрузки'**
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
