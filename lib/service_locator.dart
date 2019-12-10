import 'package:get_it/get_it.dart';
import 'package:zowe_flutter/services/services.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  // Services
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => AuthService());

  // View models
  // sl.registerFactory(() => DataSetViewModel());
}
