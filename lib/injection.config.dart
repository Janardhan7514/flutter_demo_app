// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:demo_app/data/dataSource/car_parking_apidata_source.dart'
    as _i8;
import 'package:demo_app/data/dataSource/tariff_plans_datasource.dart' as _i10;
import 'package:demo_app/data/repository/carparking_repository_impl.dart'
    as _i7;
import 'package:demo_app/data/repository/tariff_plan_repository_impl.dart'
    as _i9;
import 'package:demo_app/domain/usecase/get_parking_slot.dart' as _i4;
import 'package:demo_app/domain/usecase/get_tarrif_plans.dart' as _i5;
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as _i6;
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.CarParkingCubit>(() => _i3.CarParkingCubit(
          getByServiceTypeUseCase: gh<_i4.GetParkingSlotUseCase>(),
          tariffPlansUseCase: gh<_i5.GetTariffPlansUseCase>(),
          patchUseCase: gh<_i6.ReleaseParkingSlotUseCase>(),
        ));
    gh.factory<_i7.CarParkingRepositoryImpl>(() => _i7.CarParkingRepositoryImpl(
        remoteDataSource: gh<_i8.CarParkingAPIRemoteDataSource>()));
    gh.factory<_i9.TariffPlanRepositoryImpl>(() => _i9.TariffPlanRepositoryImpl(
        dataSource: gh<_i10.TariffPlansDataSource>()));
    return this;
  }
}
