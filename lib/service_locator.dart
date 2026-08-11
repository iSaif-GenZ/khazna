import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:khazna/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:khazna/features/statistics/domain/usecases/get_category_breakdown_usecase.dart';
import 'package:khazna/features/statistics/domain/usecases/get_income_expense_trend_usecase.dart';
import 'package:khazna/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:khazna/features/transactions/data/datasources/image_picker_local_data_source.dart';
import 'package:khazna/features/transactions/data/datasources/transaction_local_datasource.dart';
import 'package:khazna/features/transactions/data/repositories/image_picker_repository_impl.dart';
import 'package:khazna/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:khazna/features/transactions/domain/repositories/image_picker_repository.dart';
import 'package:khazna/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:khazna/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_balance_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_expenses_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_income_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/picker_and_crop_image_use_case.dart';
import 'package:khazna/features/transactions/presentation/cubit/image_picker/image_picker_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction_summary/transaction_summary_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // (Data Sources & External Tools)
  sl.registerLazySingleton<TransactionLocalDatasource>(
    () => TransactionLocalDatasourceImpl(sl<Isar>()),
  );
  sl.registerLazySingleton<ImagePickerLocalDataSource>(
    () => ImagePickerLocalDataSourceImpl(),
  );

  // (Repositories)
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl<TransactionLocalDatasource>()),
  );
  sl.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(sl()),
  );

  // (Use Cases)
  sl.registerLazySingleton(() => AddTransactionUseCase(sl<TransactionRepository>()));
  sl.registerLazySingleton(() => DeleteTransactionUseCase(sl<TransactionRepository>()));
  sl.registerLazySingleton(() => GetTransactionsUseCase(sl<TransactionRepository>()));
  sl.registerLazySingleton(() => PickerAndCropImageUseCase(sl<ImagePickerRepository>()));
  sl.registerLazySingleton(() => GetTotalBalanceUseCase());
  sl.registerLazySingleton(() => GetTotalIncomeUseCase());
  sl.registerLazySingleton(() => GetTotalExpensesUsecase());

  // Statistics Use Cases
  sl.registerLazySingleton(() => GetCategoryBreakdownUseCase());
  sl.registerLazySingleton(() => GetIncomeExpenseTrendUseCase());

  // Cubits / Blocs
  sl.registerFactory(
    () => TransactionCubit(
      getTransactionsUseCase: sl(),
      addTransactionUseCase: sl(),
      deleteTransactionUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => TransactionSummaryCubit(
      getTotalBalanceUseCase: sl<GetTotalBalanceUseCase>(),
      getTotalIncomeUseCase: sl<GetTotalIncomeUseCase>(),
      getTotalExpensesUsecase: sl<GetTotalExpensesUsecase>(),
    ),
  );
  sl.registerFactory(() => ImagePickerCubit(sl<PickerAndCropImageUseCase>()));
  sl.registerFactory(
    () => StatisticsCubit(
      getCategoryBreakdownUseCase: sl(),
      getIncomeExpenseTrendUseCase: sl(),
    ),
  );
  sl.registerFactory(() => SettingsCubit());
}