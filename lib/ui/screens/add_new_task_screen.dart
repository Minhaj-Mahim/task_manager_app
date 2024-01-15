import 'package:flutter/material.dart';
import 'package:task_manager_app/data/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data/data.network_caller/network_response.dart';
import 'package:task_manager_app/data/data.utility/urls.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_app/ui/widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _creatTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummeryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                              hintText: 'Subject',
                            ),
                            validator: (String? value){
                              if(value?.trim().isEmpty ?? true){
                                return 'Enter the subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ),
                            validator: (String? value){
                              if(value?.trim().isEmpty ?? true){
                                return 'Enter the description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _creatTaskInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: createTask,
                                child:
                                    const Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if(_formKey.currentState!.validate()){
      _creatTaskInProgress = true;
      if(mounted){
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status":"New"
      });
      _creatTaskInProgress = false;
      if(mounted){
        setState(() {});
      }
      if(response.isSuccess){
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if(mounted){
          showSnackMessage(context, 'New task added',);
        }
      } else{
        if(mounted){
          showSnackMessage(context, 'Create New Task failed! Please try again', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
