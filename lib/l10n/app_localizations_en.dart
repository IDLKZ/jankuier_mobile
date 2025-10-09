// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get services => 'Services';

  @override
  String get activity => 'Activity';

  @override
  String get visitedMatches => 'matches attended';

  @override
  String get myAchievements => 'My Achievements';

  @override
  String get leaderBoard => 'Leader Board';

  @override
  String get phoneVerificationRequired => 'Phone number verification required';

  @override
  String get welcome => 'Welcome!';

  @override
  String get login => 'Login';

  @override
  String get enterUsername => 'Enter username';

  @override
  String get incorrectFormat => 'Incorrect format';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get minimumThreeChars => 'Minimum 3 characters';

  @override
  String get minimumSixChars => 'Minimum 6 characters';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get registration => 'Registration';

  @override
  String get goVerification => 'Go to verification';

  @override
  String get enterLoginHint => 'Enter login';

  @override
  String get enterEmailHint => 'Enter email';

  @override
  String get enterEmail => 'Enter email';

  @override
  String get enterCorrectEmail => 'Enter a valid email address';

  @override
  String get passwordMinSixChars =>
      'Password must contain at least 6 characters';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get enterPhone => 'Enter phone number';

  @override
  String get phoneFormat =>
      'Number must start with 7 and contain 11 digits (7XXXXXXXXXX)';

  @override
  String get enterFirstName => 'Enter first name';

  @override
  String get firstNameMinChars =>
      'First name must contain at least 2 characters';

  @override
  String get enterLastName => 'Enter last name';

  @override
  String get lastNameMinChars => 'Last name must contain at least 2 characters';

  @override
  String get enterPatronymic => 'Enter patronymic (optional)';

  @override
  String get enterPhoneHint => 'Enter phone number (7XXXXXXXXXX)';

  @override
  String get registrationSuccess =>
      'Registration successful! Please verify your phone number';

  @override
  String get register => 'Register';

  @override
  String get next => 'Next';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';

  @override
  String get usernameValidation =>
      'Username must start with a letter and contain only letters, numbers and _';

  @override
  String get usernameMinChars => 'Username must contain at least 3 characters';

  @override
  String get enterPhoneForVerification =>
      'Enter phone number for verification code';

  @override
  String get sendSMSCode => 'Send SMS code';

  @override
  String get iHaveAccount => 'I have an account';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get codeResentSuccessfully => 'Code resent successfully';

  @override
  String get codeResendError => 'Error sending code';

  @override
  String get codeVerifiedSuccessfully => 'Code verified successfully!';

  @override
  String get invalidCode => 'Invalid code';

  @override
  String get enterVerificationCode => 'Enter verification code';

  @override
  String get codeSentToPhone => 'Code sent to number';

  @override
  String get timeExpiredRequestNew => 'Time expired. Request a new code';

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get news => 'News';

  @override
  String get latestNews => 'Latest News';

  @override
  String get newsLoadError => 'Error loading news';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get retry => 'Retry';

  @override
  String get noNewsYet => 'No news yet';

  @override
  String get checkLater => 'Check later';

  @override
  String get selectCategory => 'Select category';

  @override
  String get dateNotSpecified => 'Date not specified';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get singleNewsLoadError => 'Error loading news article';

  @override
  String get back => 'Back';

  @override
  String get newsNotFound => 'No news found';

  @override
  String get tryLater => 'Try later';

  @override
  String get countries => 'Countries';

  @override
  String get selectedCountry => 'Selected country';

  @override
  String get saveCountryError => 'Error saving country';

  @override
  String get loadingError => 'Loading error';

  @override
  String get noCountriesData => 'No countries data';

  @override
  String get nationalTeam => 'National team';

  @override
  String get round => 'Round';

  @override
  String get statistics => 'Statistics';

  @override
  String get lineup => 'Lineup';

  @override
  String get players => 'Players';

  @override
  String get loadingErrorWithMessage => 'Loading error:';

  @override
  String get selectLineupTabToLoad => 'Select \'Lineup\' tab to load lineup';

  @override
  String get selectPlayersTabToLoad =>
      'Select \'Player Statistics\' tab to load';

  @override
  String get ballPossession => 'Ball possession';

  @override
  String get shots => 'Shots';

  @override
  String get shotsOnGoal => 'Shots on goal';

  @override
  String get shotsOffGoal => 'Shots off goal';

  @override
  String get fouls => 'Fouls';

  @override
  String get yellowCards => 'Yellow cards';

  @override
  String get refereeTeam => 'Referee team';

  @override
  String get mainReferee => 'Main referee:';

  @override
  String get firstAssistant => '1st assistant:';

  @override
  String get secondAssistant => '2nd assistant:';

  @override
  String get fourthReferee => '4th referee:';

  @override
  String get coachingStaff => 'Coaching staff';

  @override
  String get headCoach => 'Head coach';

  @override
  String get assistants => 'Assistants';

  @override
  String get goalkeeper => 'GK';

  @override
  String get goalkeeperFull => 'Goalkeeper';

  @override
  String get fieldPlayer => 'Field player';

  @override
  String get onTarget => 'On target';

  @override
  String get passes => 'Passes';

  @override
  String get offTarget => 'Off target';

  @override
  String get yellows => 'Yellows';

  @override
  String get offsides => 'Offsides';

  @override
  String get corners => 'Corners';

  @override
  String get additionalStats => 'Additional statistics';

  @override
  String get home => 'Home';

  @override
  String get loadingTournaments => 'Loading tournaments...';

  @override
  String get pleaseWait => 'Please wait';

  @override
  String get tournaments => 'Tournaments';

  @override
  String get tournamentsNotFound => 'Tournaments not found';

  @override
  String get tournamentsLoadError => 'Error loading tournaments';

  @override
  String get table => 'Table';

  @override
  String get results => 'Results';

  @override
  String get tableLoadError => 'Error loading tournament table';

  @override
  String get matchesLoadError => 'Error loading match results';

  @override
  String get selectResultsTab => 'Select \'Results\' tab to load matches';

  @override
  String get position => '#';

  @override
  String get team => 'Team';

  @override
  String get matchesPlayed => 'MP';

  @override
  String get goalsScored => 'GF';

  @override
  String get points => 'Pts';

  @override
  String get allNews => 'All News';

  @override
  String get nationalTeamGames => 'National Team Games';

  @override
  String get allGames => 'All Games';

  @override
  String get clubGames => 'Club Games';

  @override
  String get noUpcomingMatches => 'No upcoming matches';

  @override
  String get noPastMatches => 'No past matches';

  @override
  String get matchesWillBeDisplayed =>
      'Matches will be displayed when available';

  @override
  String get tournamentNotSpecified => 'Tournament not specified';

  @override
  String get team1 => 'Team 1';

  @override
  String get team2 => 'Team 2';

  @override
  String get timeNotSpecified => 'Time not specified';

  @override
  String get invalidFormat => 'Invalid format';

  @override
  String get premierLeague => 'PREMIER LEAGUE';

  @override
  String get ofKazakhstan => 'of Kazakhstan';

  @override
  String get daysAgoShort => 'd. ago';

  @override
  String get hoursAgoShort => 'h. ago';

  @override
  String get minutesAgoShort => 'min. ago';

  @override
  String get justNow => 'Just now';

  @override
  String get nationalTeamMatches => 'National Team Matches';

  @override
  String get loadingLeagues => 'Loading leagues...';

  @override
  String get selectNationalTeam => 'Select a national team';

  @override
  String get untitled => 'Untitled';

  @override
  String get future => 'Future';

  @override
  String get past => 'Past';

  @override
  String get coaches => 'Coaches';

  @override
  String get noAvailableLeagues => 'No available leagues';

  @override
  String get tryReloadPage => 'Try reloading the page';

  @override
  String get tour => 'TOUR';

  @override
  String get noPlayers => 'No players';

  @override
  String get fullName => 'Full Name';

  @override
  String get club => 'Club';

  @override
  String get games => 'Games';

  @override
  String get clubNotSpecified => 'Club not specified';

  @override
  String get noCoaches => 'No coaches';

  @override
  String get positionNotSpecified => 'Position not specified';

  @override
  String get nationalityNotSpecified => 'Nationality not specified';

  @override
  String get clubMatches => 'Club matches';

  @override
  String get matchesLoadingError => 'Error loading matches';

  @override
  String get tournament => 'Tournament';

  @override
  String get stadiumNotSpecified => 'Stadium not specified';

  @override
  String get attendance => 'Attendance';

  @override
  String get matchProtocol => 'Match protocol';

  @override
  String get invalidDateFormat => 'Invalid date format';

  @override
  String get matchDetails => 'Match details';

  @override
  String get dateAndTime => 'Date and time';

  @override
  String get status => 'Status';

  @override
  String get additionalInfo => 'Additional information';

  @override
  String get attendanceCount => 'Attendance';

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get videoOverview => 'Video overview';

  @override
  String get watchOnYoutube => 'Watch on YouTube';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get finished => 'Finished';

  @override
  String get canceled => 'Canceled';

  @override
  String get unknown => 'Unknown';

  @override
  String get stadium => 'Stadium';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get stadiumNameNotSpecified => 'Stadium name not specified';

  @override
  String get matches => 'Matches';

  @override
  String get activeMatch => 'Active Match';

  @override
  String get tickets => 'Tickets';

  @override
  String get yourTickets => 'Your Tickets';

  @override
  String get availableTickets => 'Available Tickets';

  @override
  String get liveNow => 'Live Now';

  @override
  String get showQrToController => 'Show QR to Controller';

  @override
  String get close => 'Close';

  @override
  String get buyMore => 'Buy More';

  @override
  String get myTicket => 'My Ticket';

  @override
  String get profile => 'Profile';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get takeNewPhoto => 'Take New Photo';

  @override
  String get chooseNewFromGallery => 'Choose New from Gallery';

  @override
  String get deletePhoto => 'Delete Photo';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectedFileEmpty => 'Selected file is empty';

  @override
  String get fileNotFound => 'File not found';

  @override
  String get errorAccessingCameraGallery => 'Error accessing camera/gallery';

  @override
  String get photoAccessDenied =>
      'Photo access denied. Check permissions in settings';

  @override
  String get cameraAccessDenied =>
      'Camera access denied. Check permissions in settings';

  @override
  String get cameraConnectionError =>
      'Camera connection error. Try restarting the app';

  @override
  String get settings => 'Settings';

  @override
  String get errorSelectingImage => 'Error selecting image';

  @override
  String get profilePhotoUpdated => 'Profile photo updated';

  @override
  String get profilePhotoDeleted => 'Profile photo deleted';

  @override
  String get errorOnLogout => 'Error on logout';

  @override
  String get data => 'Data';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get lastName => 'Last Name';

  @override
  String get firstName => 'First Name';

  @override
  String get patronymicOptional => 'Patronymic (optional)';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get iinOptional => 'IIN (optional)';

  @override
  String get iinMustBe12Digits => 'IIN must be 12 digits';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get profileSuccessfullyUpdated => 'Profile successfully updated';

  @override
  String get security => 'Security';

  @override
  String get passwordChange => 'Password Change';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get repeatNewPassword => 'Repeat New Password';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get passwordSuccessfullyUpdated => 'Password successfully updated';

  @override
  String get newPasswordMustDiffer =>
      'New password must be different from current';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changeEmail => 'Change Email';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get enterOldPassword => 'Enter old password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get personalData => 'Personal Data';

  @override
  String get logout => 'Logout';

  @override
  String get enterCurrentPassword => 'Enter current password';

  @override
  String get enterNewPasswordField => 'Enter new password';

  @override
  String get repeatNewPasswordField => 'Repeat new password';

  @override
  String get shop => 'Shop';

  @override
  String get fields => 'Fields';

  @override
  String get sections => 'Sections';

  @override
  String get years => 'years';

  @override
  String get schedule => 'Schedule';

  @override
  String get noScheduleYet => 'No schedule yet';

  @override
  String get groups => 'Groups';

  @override
  String get recruitmentOpen => 'Recruitment open';

  @override
  String get recruitmentClosed => 'Recruitment closed';

  @override
  String get month => 'month';

  @override
  String get free => 'Free';

  @override
  String get minutes => 'min';

  @override
  String get students => 'students';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get goBack => 'Go back';

  @override
  String get imageNotAvailable => 'Image not available';

  @override
  String get imageLoadingError => 'Image loading error';

  @override
  String get addedToFavorites => 'Added to favorites';

  @override
  String get removedFromFavorites => 'Removed from favorites';

  @override
  String get productAddedToCart => 'Product added to cart';

  @override
  String get toCart => 'To cart';

  @override
  String get article => 'Art:';

  @override
  String get forChildren => 'For children';

  @override
  String get forAdults => 'For adults';

  @override
  String get unisex => 'Unisex';

  @override
  String get forMen => 'For men';

  @override
  String get forWomen => 'For women';

  @override
  String get inStock => 'In stock';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get variants => 'Variants';

  @override
  String get price => 'Price';

  @override
  String get add => 'Add';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get astanaFacilities => 'Astana: 256 facilities';

  @override
  String get addFacility => 'Add facility';

  @override
  String get filters => 'Filters';

  @override
  String get searchFreeTime => 'Search free time';

  @override
  String get book => 'Book';

  @override
  String get selectTime => 'Select time';

  @override
  String get pay => 'Pay';

  @override
  String get fieldRental => 'Field Rental';

  @override
  String get searchFilters => 'Search Filters';

  @override
  String get minimumThreeCharacters => 'Minimum 3 characters';

  @override
  String get maximumTwoHundredFiftyFiveCharacters => 'Maximum 255 characters';

  @override
  String get search => 'Search';

  @override
  String get enterFieldName => 'Enter field name...';

  @override
  String get selectCity => 'Select city';

  @override
  String get apply => 'Apply';

  @override
  String get noMoreFields => 'No more fields';

  @override
  String get sectionRegistration => 'Section Registration';

  @override
  String get enterSectionName => 'Enter section name...';

  @override
  String get gender => 'Gender';

  @override
  String get any => 'Any';

  @override
  String get male => 'M';

  @override
  String get female => 'F';

  @override
  String get age => 'Age';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get averagePrice => 'Average Price';

  @override
  String get priceFrom => 'Price from';

  @override
  String get priceTo => 'Price to';

  @override
  String get noMoreSections => 'No more sections';

  @override
  String get newProducts => 'New Products';

  @override
  String get categories => 'Categories';

  @override
  String get buy => 'Buy';

  @override
  String get firstLeague => 'First League';

  @override
  String get activeTickets => 'Active Tickets';

  @override
  String get buyTickets => 'Buy Tickets';

  @override
  String get buyBooking => 'Buy Booking';

  @override
  String get payOrder => 'Pay order';

  @override
  String get loading => 'Loading...';

  @override
  String get httpError => 'HTTP error';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get repeatPayment => 'Repeat Payment';

  @override
  String get loadingPayment => 'Loading payment...';

  @override
  String get noActiveTicketsYet => 'No active tickets yet';

  @override
  String get city => 'City';

  @override
  String get event => 'Event';

  @override
  String get venueNotSpecified => 'Venue not specified';

  @override
  String get sport => 'SPORT';

  @override
  String get venue => 'Venue';

  @override
  String get pleaseAuthorize => 'Please authorize';

  @override
  String get youHaveNoOrdersYet => 'You have no orders yet';

  @override
  String get orderedTicketsWillAppearHere => 'Ordered tickets will appear here';

  @override
  String get orderDetails => 'Order details #';

  @override
  String get genre => 'Genre:';

  @override
  String get duration => 'Duration:';

  @override
  String get unknownLocation => 'Unknown location';

  @override
  String get unknownCity => 'Unknown city';

  @override
  String get hall => 'Hall:';

  @override
  String get unknownHall => 'Unknown hall';

  @override
  String get ticket => 'Ticket';

  @override
  String get row => 'Row';

  @override
  String get seat => 'Seat';

  @override
  String get level => 'Level:';

  @override
  String get orderInformation => 'Order Information';

  @override
  String get ticketCount => 'Ticket count';

  @override
  String get totalCost => 'Total cost';

  @override
  String get phone => 'Phone';

  @override
  String get dateCreated => 'Date created';

  @override
  String get cancellationReason => 'Cancellation reason';

  @override
  String get cancelOrder => 'Cancel order';

  @override
  String get showPass => 'Show pass';

  @override
  String get statusCanceled => 'CANCELED';

  @override
  String get statusPaid => 'PAID';

  @override
  String get statusActive => 'ACTIVE';

  @override
  String get statusInactive => 'INACTIVE';

  @override
  String get eventPass => 'Event Pass';

  @override
  String get order => 'Order';

  @override
  String get loadingPass => 'Loading pass...';

  @override
  String get passLoadingError => 'Error loading pass';

  @override
  String get qrCodeUnavailable => 'QR code unavailable';

  @override
  String get qrCodesNotFound => 'QR codes not found';

  @override
  String get amount => 'Amount';

  @override
  String get success => 'Success';

  @override
  String get ticketsCount => 'Tickets';

  @override
  String get details => 'Details';

  @override
  String get selectCountryFirst => 'Select country first';

  @override
  String get season => 'Season:';

  @override
  String get tournamentSelected => 'Tournament selected:';

  @override
  String get tournamentSaveError => 'Error saving tournament';

  @override
  String get selectTournament => 'Select Tournament';

  @override
  String get international => 'Int.';

  @override
  String get tournamentLoadingError => 'Error loading tournaments';

  @override
  String get retryAttempt => 'Retry attempt';

  @override
  String get searchTournaments => 'Search tournaments...';

  @override
  String get maleTournaments => 'Male';

  @override
  String get femaleTournaments => 'Female';

  @override
  String get tryChangeSearchFilters => 'Try changing search filters';

  @override
  String get touchScreenToSkip => 'Touch screen to skip';

  @override
  String get deleteAccountConfirmation => 'Delete Account Confirmation';

  @override
  String get deleteAccountWarning =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get deleteAccountPermanently => 'Delete Permanently';

  @override
  String get accountDeleted => 'Account successfully deleted';

  @override
  String get accountDeletionFailed => 'Account deletion failed';

  @override
  String get myBookings => 'My Bookings';

  @override
  String get pending => 'Pending';

  @override
  String get paid => 'Paid';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get bookingCancelledSuccessfully => 'Booking cancelled successfully';

  @override
  String get repeat => 'Repeat';

  @override
  String get noBookings => 'No bookings';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get field => 'Field';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get total => 'Total';

  @override
  String get address => 'Address';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get cancelBookingTitle => 'Cancel booking?';

  @override
  String get cancelBookingConfirmation =>
      'Are you sure you want to cancel this booking? This action cannot be undone.';

  @override
  String get no => 'No';

  @override
  String get yesCancel => 'Yes, cancel';

  @override
  String get pleaseLogin => 'Please log in';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get selectQuantity => 'Select quantity';

  @override
  String get confirm => 'Confirm';

  @override
  String get myOrders => 'My Orders';

  @override
  String get viewPurchaseHistory => 'View purchase history';

  @override
  String get viewMyBookings => 'View my bookings';

  @override
  String get authorizationRequired => 'Authorization required';

  @override
  String get loginFirstToBook => 'Please log in first to make a booking';

  @override
  String get bookingRequestCreated => 'Booking request created';

  @override
  String get cartCleared => 'Cart cleared';

  @override
  String get cartEmpty => 'Cart is empty';

  @override
  String get addItemsToCheckout => 'Add items to checkout';

  @override
  String get clearCartQuestion => 'Clear cart?';

  @override
  String get allItemsWillBeRemoved => 'All items will be removed from cart';

  @override
  String get clear => 'Clear';

  @override
  String get product => 'Product';

  @override
  String get totalToPay => 'Total to pay:';

  @override
  String get proceedToPayment => 'Proceed to payment';

  @override
  String get awaitingPayment => 'Awaiting';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get placeFirstOrderInShop => 'Place your first order in the shop';

  @override
  String get paidOn => 'Paid';

  @override
  String get payBefore => 'Pay before';

  @override
  String get cancelOrderConfirmation =>
      'Are you sure you want to cancel this order? Funds will be refunded to your account after admin confirmation.';

  @override
  String get deleteOrder => 'Delete order';

  @override
  String get deleteOrderConfirmation =>
      'Are you sure you want to delete this order? This action cannot be undone.';

  @override
  String get delete => 'Delete';

  @override
  String get orderDataNotAvailable => 'Order data not available';

  @override
  String get itemsInOrder => 'Items in order';

  @override
  String get noItemsInOrder => 'No items in order';

  @override
  String get createdDate => 'Created date';

  @override
  String get paymentDate => 'Payment date';

  @override
  String get quantity => 'Qty';

  @override
  String get statusHistory => 'Status history';

  @override
  String get notifications => 'Notifications';

  @override
  String get stayUpdated => 'Stay updated';

  @override
  String get active => 'Active';

  @override
  String get newNotifications => 'New';

  @override
  String get readNotifications => 'Read';

  @override
  String get noReadNotifications => 'No read notifications';

  @override
  String get allCaughtUp => 'All caught up!';

  @override
  String get noReadNotificationsYet =>
      'You haven\'t read any notifications yet';

  @override
  String get noNewNotifications => 'You have no new notifications';

  @override
  String get error => 'Error';

  @override
  String get created => 'Created';

  @override
  String get updated => 'Updated';

  @override
  String get openLink => 'Open Link';

  @override
  String get navigate => 'Navigate';

  @override
  String get newNotification => 'New notification';

  @override
  String get tapToView => 'Tap to view';

  @override
  String hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get cart => 'Cart';

  @override
  String get enterPinCode => 'Enter PIN code';

  @override
  String get appLogin => 'App Login';

  @override
  String attemptsRemaining(int count) {
    return 'Attempts remaining: $count';
  }

  @override
  String get confirmLoginWithBiometrics => 'Confirm login with biometrics';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get useBiometrics => 'Use biometrics';

  @override
  String get loginWithDifferentAccount => 'Login with different account';

  @override
  String get attemptsExceededLoginAgain =>
      'Attempts exceeded. Please login again.';

  @override
  String incorrectPinAttemptsRemaining(int count) {
    return 'Incorrect PIN code. Attempts remaining: $count';
  }

  @override
  String get failedToRefreshToken => 'Failed to refresh token';

  @override
  String get changePinCode => 'Change PIN code';

  @override
  String get createPinCode => 'Create PIN code';

  @override
  String get enterOldAndNewPin => 'Enter old PIN code and new one to change';

  @override
  String get createFourDigitPin =>
      'Create a 4-digit PIN code to protect the app';

  @override
  String get oldPinCode => 'Old PIN code';

  @override
  String get newPinCode => 'New PIN code';

  @override
  String get pinCode => 'PIN code';

  @override
  String get confirmPinCode => 'Confirm PIN code';

  @override
  String get updatePinCode => 'Update PIN code';

  @override
  String get pinCodesDoNotMatch => 'PIN codes do not match';

  @override
  String get newPinCodesDoNotMatch => 'New PIN codes do not match';

  @override
  String get pinCodeSuccessfullySet => 'PIN code successfully set';

  @override
  String get pinCodeSuccessfullyUpdated => 'PIN code successfully updated';

  @override
  String get attemptsExceeded => 'Attempts exceeded';

  @override
  String incorrectOldPinAttemptsRemaining(int count) {
    return 'Incorrect old PIN code. Attempts remaining: $count';
  }

  @override
  String get securitySetup => 'Security Setup';

  @override
  String get useBiometricsOrCreatePin =>
      'Use biometrics or create a PIN code to protect the app';

  @override
  String get continueButton => 'Continue';

  @override
  String get giveAccessToData => 'Grant access to data';

  @override
  String get resetPinCode => 'Reset PIN code';

  @override
  String get privacyButton => 'Personal data processing policy';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get publicTitle => 'Public contract (offer)';

  @override
  String get publicMobileTitle => 'Mobile application public offer agreement';

  @override
  String get weWillSendSmsCode => 'Мы отправим SMS-код для подтверждения';

  @override
  String get smsCodeWillArriveIn => 'SMS-код придет в течение 1-2 минут';

  @override
  String get or => 'или';

  @override
  String get enterCodeFromSms => 'Введите код из SMS';

  @override
  String get codeResentAgain => 'Код отправлен повторно';

  @override
  String get passwordSuccessfullyChanged => 'Пароль успешно изменен';

  @override
  String get wrongCodeOrResetError => 'Неверный код или ошибка сброса пароля';

  @override
  String get newPasswordTitle => 'Новый пароль';

  @override
  String get enterSmsCodeAndNewPassword => 'Введите код из SMS и новый пароль';

  @override
  String get codeValidFor => 'Код действителен:';

  @override
  String get codeExpiredRequestNew =>
      'Время действия кода истекло. Запросите новый код.';

  @override
  String get codeExpired => 'Время действия кода истекло';

  @override
  String get resetPasswordButton => 'Сбросить пароль';

  @override
  String get resendCodeAgain => 'Отправить код повторно';

  @override
  String get backToSignIn => 'Вернуться к входу';

  @override
  String get resetCodeSent => 'Код для сброса пароля отправлен';

  @override
  String get passwordResetTitle => 'Сброс пароля';

  @override
  String get enterPhoneToGetCode => 'Введите номер телефона для получения кода';

  @override
  String get sendCode => 'Отправить код';

  @override
  String get enterValidPhoneNumber => 'Введите корректный номер телефона';

  @override
  String get enterValidEmail => 'Введите корректный email';

  @override
  String get enterEmailPhoneOrLogin => 'Введите email, телефон или логин';

  @override
  String get emailPhoneOrLogin => 'Email, телефон или логин';

  @override
  String get createNewAccount => 'Создайте новый аккаунт';

  @override
  String get passwordRequirements =>
      'Пароль должен содержать минимум 1 заглавную, 1 строчную букву, 1 цифру и 1 спецсимвол';
}
