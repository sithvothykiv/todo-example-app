import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todos_app/components/custom_app_bar.dart';
import 'package:todos_app/res/r.dart';
import 'package:todos_app/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todos_app/tasks/presentation/widget/task_item_view.dart';
import 'package:todos_app/utils/color_palette.dart';
import 'package:todos_app/utils/util.dart';

import '../../../components/widgets.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/font_sizes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TasksBloc>().add(FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: 'Hi User',
            actionWidgets: _actionWidgets(),
          ),
          body: _buildBody(size),
          floatingActionButton: _floatingCreateTaskBtn(),
        ),
      ),
    );
  }

  _actionWidgets() {
    return [
      PopupMenuButton<int>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 1,
        onSelected: (value) => _onSelected(value),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  SvgPicture.asset(R.calender, width: 15),
                  const SizedBox(width: 10),
                  buildText(
                    'Sort by date',
                    kBlackColor,
                    textSmall,
                    FontWeight.normal,
                    TextAlign.start,
                    TextOverflow.clip,
                  )
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  SvgPicture.asset(R.taskChecked, width: 15),
                  const SizedBox(width: 10),
                  buildText(
                    'Completed tasks',
                    kBlackColor,
                    textSmall,
                    FontWeight.normal,
                    TextAlign.start,
                    TextOverflow.clip,
                  )
                ],
              ),
            ),
          ];
        },
        child: SvgPicture.asset(R.filter),
      ),
      IconButton(
        key: Key('addTaskButton'),
        onPressed: () => Navigator.pushNamed(context, AppPages.dashboard),
        icon: const Icon(Icons.auto_graph),
      ),
    ];
  }

  _buildBody(Size size) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is LoadTaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.error, kRed));
            }

            if (state is AddTaskFailure || state is UpdateTaskFailure) {
              context.read<TasksBloc>().add(FetchTaskEvent());
            }
          },
          builder: (context, state) {
            if (state is TasksLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state is LoadTaskFailure) {
              return Center(
                child: buildText(
                  state.error,
                  kBlackColor,
                  textMedium,
                  FontWeight.normal,
                  TextAlign.center,
                  TextOverflow.clip,
                ),
              );
            }

            if (state is FetchTasksSuccess) {
              return state.tasks.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItemView(taskModel: state.tasks[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(color: kGrey3);
                      },
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(R.tasks, height: size.height * .20, width: size.width),
                          const SizedBox(height: 50),
                          buildText(
                            'Schedule your tasks',
                            kBlackColor,
                            textBold,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip,
                          ),
                          buildText(
                            'Manage your task schedule easily\nand efficiently',
                            kBlackColor.withOpacity(.5),
                            textSmall,
                            FontWeight.normal,
                            TextAlign.center,
                            TextOverflow.clip,
                          ),
                        ],
                      ),
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _floatingCreateTaskBtn() {
    return FloatingActionButton(
      child: const Icon(Icons.add_circle, color: kPrimaryColor),
      onPressed: () => Navigator.pushNamed(context, AppPages.createNewTask),
    );
  }

  _onSelected(int value) {
    switch (value) {
      case 0:
        {
          context.read<TasksBloc>().add(SortTaskEvent(sortOption: 0));
          break;
        }
      case 1:
        {
          context.read<TasksBloc>().add(SortTaskEvent(sortOption: 1));
          break;
        }
    }
  }
}
