import 'package:demo_app/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'car_parking_injection.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void setup() async{
  final changeSettingsInjectionModule = CarParkingInjectionModule(getIt);
  await changeSettingsInjectionModule.registerDependencies();
}




