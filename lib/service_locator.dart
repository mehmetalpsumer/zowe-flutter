import 'package:get_it/get_it.dart';
import 'package:zowe_flutter/services/services.dart';
import 'package:zowe_flutter/view_models/view_models.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  // Services
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => AuthService());
  sl.registerLazySingleton(() => DataSetService());

  // View models
  sl.registerFactory(() => LoginViewModel());
  sl.registerFactory(() => HomeViewModel());
  sl.registerFactory(() => DataSetListViewModel());
  sl.registerFactory(() => DataSetContentViewModel());
}
