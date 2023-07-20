import 'dart:async';
import 'dart:io';

import 'package:demo_app/data/dataSource/car_parking_apidata_source_impl.dart';
import 'package:demo_app/data/mappers/car_parking_domain_model_mapper.dart';
import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/data/repository/carparking_repository_impl.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:demo_app/domain/repository/tariff_plans_repository.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart';
import 'package:demo_app/domain/usecase/get_tarrif_plans.dart';
import 'package:demo_app/injection_module.dart';
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/dataSource/car_parking_apidata_source.dart';
import 'data/dataSource/tariff_plans_datasource.dart';
import 'data/dataSource/tariff_plans_datasource_impl.dart';
import 'data/mappers/tariff_domain_model_mapper.dart';
import 'data/model/parking_domain_model.dart';
import 'data/repository/tariff_plan_repository_impl.dart';
import 'domain/entity/parking_domain_entity.dart';
import 'domain/repository/carparking_repository.dart';
import 'domain/usecase/release_parking_slot.dart';
import 'functions.dart';

class CarParkingInjectionModule extends InjectionModule {
  static const aemInstanceName = 'change_settings';

  CarParkingInjectionModule(this.injector);

  final GetIt injector;

  @override
  FutureOr<void> registerDependencies() {
    _registerCubits();
    _registerUseCases();
    _registerRepositories();
    _registerDatSources();
    _registerMappers();
  }

  _registerUseCases() {
    injector.registerFactory<GetParkingSlotUseCase>(
      () => GetParkingSlotUseCase(
        featuresRepository: injector(),
      ),
    );
    injector.registerFactory<ReleaseParkingSlotUseCase>(
      () => ReleaseParkingSlotUseCase(
        featuresRepository: injector(),
      ),
    );
    injector.registerFactory<GetTariffPlansUseCase>(
      () => GetTariffPlansUseCase(
        featuresRepository: injector(),
      ),
    );
  }

  _registerCubits() {
    injector.registerFactory<CarParkingCubit>(
      () => CarParkingCubit(
          getByServiceTypeUseCase: injector(),
          patchUseCase: injector(),
          tariffPlansUseCase: injector()),
    );
  }

  _registerRepositories() {
    injector.registerFactory<CarParkingRepository>(
      () => CarParkingRepositoryImpl(remoteDataSource: injector()),
    );
    injector.registerFactory<TariffsPlanRepository>(
      () => TariffPlanRepositoryImpl(dataSource: injector()),
    );
  }

  _registerDatSources() {
    injector.registerFactory<CarParkingAPIRemoteDataSource>(
        () => CarParkingAPIRemoteDataSourceImpl(injector()));
    injector.registerFactory<TariffPlansDataSource>(
        () => TariffPlanDataSourceImpl(injector()));
  }

  _registerMappers() {
    injector
        .registerFactory<Function1<ParkingDomainModel, ParkingDomainEntity>>(
            () => CarParkingDomainModelMapper());
    injector.registerFactory<Function1<TariffDomainModel, TariffDomainEntity>>(
        () => TariffDomainModelMapper());
  }
}
