import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/check_biometrics_available_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/check_biometrics_data_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/check_pin_code_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/get_local_auth_type_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/get_pin_hash_before_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/reload_pin_code_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/set_local_auth_type_usecase.dart';
import 'package:jankuier_mobile/features/local_auth/domain/usecases/set_pin_hash_usecase.dart';
import 'local_auth_event.dart';
import 'local_auth_state.dart';

@injectable
class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  final CheckBiometricsAvailableUseCase _checkBiometricsAvailable;
  final CheckBiometricsDataUseCase _checkBiometricsData;
  final CheckPinCodeUseCase _checkPinCode;
  final SetPinHashUseCase _setPinHash;
  final GetPinHashBeforeUseCase _getPinHashBefore;
  final ReloadPinCodeUseCase _reloadPinCode;
  final GetLocalAuthTypeUseCase _getLocalAuthType;
  final SetLocalAuthTypeUseCase _setLocalAuthType;

  LocalAuthBloc(
    this._checkBiometricsAvailable,
    this._checkBiometricsData,
    this._checkPinCode,
    this._setPinHash,
    this._getPinHashBefore,
    this._reloadPinCode,
    this._getLocalAuthType,
    this._setLocalAuthType,
  ) : super(const LocalAuthInitial()) {
    on<CheckBiometricsAvailable>(_onCheckBiometricsAvailable);
    on<AuthenticateWithBiometrics>(_onAuthenticateWithBiometrics);
    on<CheckPinCode>(_onCheckPinCode);
    on<SetPinCode>(_onSetPinCode);
    on<CheckPinExists>(_onCheckPinExists);
    on<UpdatePinCode>(_onUpdatePinCode);
    on<GetAuthType>(_onGetAuthType);
    on<SetAuthType>(_onSetAuthType);
  }

  Future<void> _onCheckBiometricsAvailable(
    CheckBiometricsAvailable event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _checkBiometricsAvailable(const NoParams());

    result.fold(
      (failure) => emit(LocalAuthError(failure.message ?? 'Ошибка проверки биометрии')),
      (biometricTypes) {
        if (biometricTypes != null && biometricTypes.isNotEmpty) {
          emit(BiometricsAvailable(biometricTypes));
        } else {
          emit(const BiometricsNotAvailable());
        }
      },
    );
  }

  Future<void> _onAuthenticateWithBiometrics(
    AuthenticateWithBiometrics event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _checkBiometricsData(
      BiometricAuthParams(message: event.message),
    );

    result.fold(
      (failure) => emit(AuthenticationFailure(failure.message ?? 'Ошибка аутентификации')),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(const AuthenticationSuccess());
        } else {
          emit(const AuthenticationFailure('Биометрическая аутентификация не удалась'));
        }
      },
    );
  }

  Future<void> _onCheckPinCode(
    CheckPinCode event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _checkPinCode(PinCodeParams(pin: event.pin));

    result.fold(
      (failure) => emit(LocalAuthError(failure.message ?? 'Ошибка проверки PIN-кода')),
      (isValid) {
        if (isValid) {
          emit(const PinCheckSuccess());
        } else {
          emit(const PinCheckFailure());
        }
      },
    );
  }

  Future<void> _onSetPinCode(
    SetPinCode event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _setPinHash(SetPinParams(pin: event.pin));

    result.fold(
      (failure) => emit(PinSetFailure(failure.message ?? 'Ошибка установки PIN-кода')),
      (isSet) {
        if (isSet) {
          emit(const PinSetSuccess());
        } else {
          emit(const PinSetFailure('PIN-код уже установлен'));
        }
      },
    );
  }

  Future<void> _onCheckPinExists(
    CheckPinExists event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _getPinHashBefore(const NoParams());

    result.fold(
      (failure) => emit(LocalAuthError(failure.message ?? 'Ошибка проверки PIN-кода')),
      (exists) {
        if (exists) {
          emit(const PinExists());
        } else {
          emit(const PinNotExists());
        }
      },
    );
  }

  Future<void> _onUpdatePinCode(
    UpdatePinCode event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _reloadPinCode(
      ReloadPinParams(newPin: event.newPin),
    );

    result.fold(
      (failure) => emit(PinUpdateFailure(failure.message ?? 'Ошибка обновления PIN-кода')),
      (isUpdated) {
        if (isUpdated) {
          emit(const PinUpdated());
        } else {
          emit(const PinUpdateFailure('Ошибка обновления PIN-кода'));
        }
      },
    );
  }

  Future<void> _onGetAuthType(
    GetAuthType event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _getLocalAuthType(const NoParams());

    result.fold(
      (failure) => emit(LocalAuthError(failure.message ?? 'Ошибка получения типа аутентификации')),
      (authType) => emit(AuthTypeLoaded(authType)),
    );
  }

  Future<void> _onSetAuthType(
    SetAuthType event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(const LocalAuthLoading());

    final result = await _setLocalAuthType(
      LocalAuthTypeParams(authType: event.authType),
    );

    result.fold(
      (failure) => emit(AuthTypeSetFailure(failure.message ?? 'Ошибка установки типа аутентификации')),
      (isSet) {
        if (isSet) {
          emit(const AuthTypeSet());
        } else {
          emit(const AuthTypeSetFailure('Не удалось установить тип аутентификации'));
        }
      },
    );
  }
}
