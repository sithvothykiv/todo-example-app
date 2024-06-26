import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todos_app/res/r.dart';

import '../../../components/widgets.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/font_sizes.dart';
import '../../../utils/util.dart';
import '../../data/local/model/task_model.dart';
import '../bloc/tasks_bloc.dart';

class TaskItemView extends StatefulWidget {
  final TaskModel taskModel;

  const TaskItemView({super.key, required this.taskModel});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.1), //Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: widget.taskModel.completed,
            onChanged: (value) => _onChanged,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: buildText(
                        widget.taskModel.title,
                        kBlackColor,
                        textMedium,
                        FontWeight.w500,
                        TextAlign.start,
                        TextOverflow.clip,
                      ),
                    ),
                    PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: kWhiteColor,
                      elevation: 1,
                      onSelected: (value) => _onSelected(value),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                SvgPicture.asset(R.edit, width: 20),
                                const SizedBox(width: 10),
                                buildText(
                                  'Edit task',
                                  kBlackColor,
                                  textMedium,
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
                                SvgPicture.asset(R.delete, width: 20),
                                const SizedBox(width: 10),
                                buildText(
                                  'Delete task',
                                  kRed,
                                  textMedium,
                                  FontWeight.normal,
                                  TextAlign.start,
                                  TextOverflow.clip,
                                )
                              ],
                            ),
                          ),
                        ];
                      },
                      child: SvgPicture.asset(R.verticalMenu),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: buildText(
                    widget.taskModel.description,
                    kGrey1,
                    textSmall,
                    FontWeight.normal,
                    TextAlign.start,
                    TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: kGrey0.withOpacity(.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(R.calender, width: 12),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildText(
                          '${formatDate(dateTime: widget.taskModel.startDateTime.toString())} - ${formatDate(dateTime: widget.taskModel.stopDateTime.toString())}',
                          kBlackColor,
                          textTiny,
                          FontWeight.w400,
                          TextAlign.start,
                          TextOverflow.clip,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  _onSelected(int value) {
    switch (value) {
      case 0:
        {
          Navigator.pushNamed(context, AppPages.updateTask, arguments: widget.taskModel);
          break;
        }
      case 1:
        {
          context.read<TasksBloc>().add(DeleteTaskEvent(taskModel: widget.taskModel));
          break;
        }
    }
  }

  _onChanged() {
    var taskModel = TaskModel(
      id: widget.taskModel.id,
      title: widget.taskModel.title,
      description: widget.taskModel.description,
      completed: !widget.taskModel.completed,
      startDateTime: widget.taskModel.startDateTime,
      stopDateTime: widget.taskModel.stopDateTime,
    );
    context.read<TasksBloc>().add(UpdateTaskEvent(taskModel: taskModel));
  }
}
