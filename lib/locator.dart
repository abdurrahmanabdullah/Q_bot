import 'package:get_it/get_it.dart';
import 'package:q_bot/core/services/home_api.dart';
import 'package:q_bot/core/view_models/base_view_model.dart';
import 'package:q_bot/core/view_models/home_view_model.dart';

/// Dependency Injections
/// Registering all the ViewModels and API or Service classes using GetIt
/// Factory for ViewModels
/// Lazy Singleton for API classes

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BaseViewModel());

  locator.registerFactory(() => HomeViewModel());

  locator.registerLazySingleton(() => CounterAPI());
}
