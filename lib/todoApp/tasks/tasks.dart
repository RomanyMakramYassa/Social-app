import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/coponanet/coponanet.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

//import '../../shared/coponanet/costant.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        var tasks = AppCubit.getApp(context).newtasks;
        return ConditionalBuilder(
          condition: tasks.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  BuildTaskItem(tasks[index], context),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 3.00,
                    color: Colors.grey,
                  ),
              itemCount: tasks.length),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 100.00,
                  color: Colors.white30,
                ),
                Text(
                  'no data setrouve',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.00),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
