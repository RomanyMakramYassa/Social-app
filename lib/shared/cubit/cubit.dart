import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/cubit/states.dart';

import 'package:sqflite/sqflite.dart';

import '../../todoApp/archeved/archived.dart';
import '../../todoApp/done/done.dart';
import '../../todoApp/tasks/tasks.dart';
import '../network/local/cachhelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialStates());
  static AppCubit getApp(context) => BlocProvider.of(context);
  int curent = 0;
  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];
  List<Widget> sc = [
    Task(),
    done(),
    archive(),
  ];
  List<String> tit = ['tasks', 'done', 'archive'];
  void changebuton(int index) {
    curent = index;
    emit(AppchangebotonNavegation());
  }

  void createDatabse() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('crated');
      database
          .execute(
              'CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT,time TEXT , data TEXT ,states TEXT)')
          .then((value) {
        print('table created');
      }).catchError((onError) {
        print('error 266 ${onError.toString()}');
      });
    }, onOpen: (database) {
      getDatabase(database);
    }).then((value) {
      database = value;
      emit(Appcreatedatabase());
    });
  }

  void deletedatabase({required int id}) {
    database.rawDelete('DELETE FROM TASKS WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(AppDeletedatabase());
    });
  }

  insertdatabase({
    required String title,
    required String time,
    required String data,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              'INSERT INTO TASKS (title,time, data,states)VALUES("$title","$time","$data","new")')
          .then((value) {
        emit(Appinsertintodatabase());
        print('$value table raw creteed');
        getDatabase(database);
      }).catchError((onError) {
        print('eror hapend 285 ${onError.toString()}');
      });
    });
  }

  void updateStates({required String states, required int? id}) async {
    database.rawUpdate(
      'UPDATE TASKS SET states = ? WHERE id = ?',
      ['$states', id],
    ).then((value) {
      getDatabase(database);
      emit(Appupdatedatabase());
    });
  }

  void getDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetloaddatabase());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      /// tasks = value;
      value.forEach((element) {
        if (element['states'] == 'done') {
          donetasks.add(element);
        } else if (element['states'] == 'archive') {
          archivetasks.add(element);
        } else {
          newtasks.add(element);
        }

        print(element['states']);
      });
      emit(AppGetfromdatabase());
    });
  }

  bool isbotem = false;
  IconData fbicon = Icons.edit;
  void changeicon({required bool isshow, required IconData data}) {
    isbotem = isshow;
    fbicon = data;
    emit(AppChangIcon());
  }

  bool isdark = false;
  void changmode({bool? fromn}) {
    if (fromn != null) {
      emit(changedmode());
      isdark = fromn;
    } else {
      isdark = !isdark;
      CachHelper.putdata(key: 'isDark', val: isdark).then((value) {
        emit(changedmode());
      });
    }
  }
}
