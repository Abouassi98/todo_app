// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../features/home/data/models/todo_model.dart';
import '../../../../features/home/presentation/utils/constants.dart';
import '../../../presentation/providers/provider_utils.dart';
import '../../../presentation/utils/fp_framework.dart';
import '../../../presentation/utils/riverpod_framework.dart';
import '../extensions/local_error_extension.dart';
import 'i_sqflite_storage_caller.dart';
part 'sqflite_pref_local_storage_caller.g.dart';

@Riverpod(keepAlive: true)
class GetDatabase extends _$GetDatabase with NotifierUpdate {
  @override
  Option<Database> build() => const None();
}

@Riverpod(keepAlive: true)
FutureOr<Database> sqflitePrefsAsync(SqflitePrefsAsyncRef ref) async {
  final database = ref.watch(getDatabaseProvider);
  if (database.isSome()) {
    return database.toNullable()!;
  }
  final initDB = await ref.watch(initDbProvider.future);
  ref.watch(getDatabaseProvider.notifier).update((state) => Some(initDB));
  return database.toNullable()!;
}

@Riverpod(keepAlive: true)
Future<Database> initDb(InitDbRef ref) async {
  final path = join(await getDatabasesPath(), 'todo_database.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: _onCreate,
  );
}

Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
        CREATE TABLE $todoTable (
        itemId TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        description TEXT NOT NULL,
        color INTEGER NOT NULL,
        status TEXT NOT NULL)
      ''');
}

@Riverpod(keepAlive: true)
ISqfliteStorageCaller sqfliteStorageCaller(SqfliteStorageCallerRef ref) {
  return SqfliteCallerLocalStorageCaller(
    database: ref.watch(sqflitePrefsAsyncProvider).requireValue,
  );
}

class SqfliteCallerLocalStorageCaller implements ISqfliteStorageCaller {
  SqfliteCallerLocalStorageCaller({required this.database});

  final Database? database;

  @override
  Future<void> addData<T>({required T visualNoteModel}) {
    return _errorHandler(
      () async {
        return database!.insert(
          todoTable,
          visualNoteModel as Map<String, Object?>,
        );
      },
    );
  }

  @override
  Future<void> deleteData({required String itemId}) {
    return _errorHandler(
      () async {
        return database!.delete(
          todoTable,
          where: 'itemId = ?',
          whereArgs: [itemId],
        );
      },
    );
  }

  @override
  Future<List<T>?> getAllData<T>() async {
    return _errorHandler(() async {
      final List<Map<String, dynamic>> notesMaps =
          await database!.rawQuery('SELECT * FROM $todoTable');
      // ignore: omit_local_variable_types, prefer_final_locals
      List<T> notesList = notesMaps.isNotEmpty
          ? notesMaps.map<T>((json) => TodoModel.fromJson(json) as T).toList()
          : [];

      return notesList;
    });
  }

  @override
  Future<void> updateData<T>({
    required T visualNoteModel,
    required String oldItemId,
  }) {
    return _errorHandler(
      () async {
        return database!.update(
          todoTable,
          visualNoteModel as Map<String, Object?>,
          where: 'itemId = ?',
          whereArgs: [oldItemId],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  FutureOr<T> _errorHandler<T>(FutureOr<T> Function() body) async {
    try {
      return await body.call();
    } catch (e, st) {
      final error = e.localErrorToCacheException();
      throw Error.throwWithStackTrace(error, st);
    }
  }
}
