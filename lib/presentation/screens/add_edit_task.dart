// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky_apis/data/models/task_creation_request.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/models/task_edit_request.dart';
import 'package:tasky_apis/logic/cubit/task_creation_cubit.dart';
import 'package:tasky_apis/logic/cubit/tasks_cubit.dart';
import 'package:tasky_apis/presentation/widgets/primary_button.dart';
import 'package:tasky_apis/presentation/widgets/primary_textformfield.dart';
import 'package:tasky_apis/presentation/widgets/secondary_appbar.dart';

class AddEditTask extends StatefulWidget {
  TaskCreationResponse? taskCreationResponse;

  AddEditTask({super.key, this.taskCreationResponse});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  String? _id;
  String? _selectedPriority;
  String? _selectedStatus;
  DateTime? _selectedDate;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final List<String> _priorities = [
    "low",
    "medium",
    "high",
  ];
  final List<String> _status = [
    "inProgress",
    "waiting",
    "finished",
  ];

  Future<void> _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    if (widget.taskCreationResponse != null) {
      _id = widget.taskCreationResponse!.sId;
      titleCtrl.text = widget.taskCreationResponse!.title!;
      descCtrl.text = widget.taskCreationResponse!.desc!;
      _selectedPriority = widget.taskCreationResponse!.priority;
      _selectedStatus = widget.taskCreationResponse!.status;
      _selectedDate =
          DateTime.tryParse(widget.taskCreationResponse!.createdAt!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SecodaryAppBar(
        title: "Add new task",
      ),
      body: BlocBuilder<TaskCreationCubit, TaskCreationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                if (widget.taskCreationResponse == null)
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/add_img.png"),
                          const SizedBox(width: 10),
                          Text(
                            "Add Img",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                const Text("Task Title"),
                const SizedBox(height: 7),
                PrimaryTextformfield(
                  controller: titleCtrl,
                  obsecure: false,
                  hint: "Enter title here...",
                ),
                const SizedBox(height: 10),
                const Text("Task Description"),
                const SizedBox(height: 7),
                TextFormField(
                  controller: descCtrl,
                  minLines: 6,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    hintText: "Enter description here",
                    hintStyle: TextStyle(
                      color: Color(0xffBABABA),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Priority"),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF0ECFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPriority,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.purple),
                      hint: const Row(
                        children: [
                          Text(
                            "Choose Priority",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      items: _priorities.map((String priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Row(
                            children: [
                              Text(
                                priority,
                                style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value;
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.taskCreationResponse != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("Status"),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffF0ECFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedStatus,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.purple),
                            hint: Row(
                              children: const [
                                Text(
                                  "Choose Status",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            items: _status.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Row(
                                  children: [
                                    Text(
                                      status,
                                      style: const TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedStatus = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text("Due Date"),
                SizedBox(height: 5),
                InkWell(
                  onTap: _pickDueDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "Choose due date..."
                              : "${_selectedDate?.toLocal().toString().split(' ')[0]}",
                          style: TextStyle(
                            color: _selectedDate == null
                                ? Colors.grey
                                : Colors.deepPurple,
                          ),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.purple),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                PrimaryButton(
                    onPressed: () {
                      // if (_selectedImage == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: Text('Please select an image'),
                      //   ));
                      //   return;
                      // }
                      if (widget.taskCreationResponse == null) {
                        Navigator.pop(context);
                        BlocProvider.of<TasksCubit>(context).getTasks();
                        TaskCreationRequest taskCreationRequest =
                            TaskCreationRequest(
                                desc: descCtrl.text,
                                dueDate: formatDate(_selectedDate!),
                                image: "path.png",
                                priority: _selectedPriority,
                                title: titleCtrl.text);
                        BlocProvider.of<TaskCreationCubit>(context)
                            .createTask(taskCreationRequest);

                        if (widget.taskCreationResponse == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Sucessfully Added - ${titleCtrl.text}"),
                            duration: Duration(seconds: 3),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 4,
                            backgroundColor: Colors.white,
                            content: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.green.shade400,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Sucessfully Edited - ${titleCtrl.text}",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      } else {
                        Navigator.pop(context);
                        BlocProvider.of<TasksCubit>(context)
                            .editTask(TaskEditRequest(
                          id: _id!,
                          desc: descCtrl.text,
                          image: "path.png",
                          priority: _selectedPriority!,
                          status: _selectedStatus!,
                          title: titleCtrl.text,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Sucessfully Edited - ${titleCtrl.text}"),
                          duration: Duration(seconds: 3),
                        ));
                      }
                      BlocProvider.of<TasksCubit>(context).getTasks();
                    },
                    text: widget.taskCreationResponse == null
                        ? "Add task"
                        : "Edit task"),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  String formatDate(DateTime date) {
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String year = '${date.year}';
    return '$month/$day/$year';
  }
}
