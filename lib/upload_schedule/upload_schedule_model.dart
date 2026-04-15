import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'upload_schedule_widget.dart' show UploadScheduleWidget;
import 'package:flutter/material.dart';

class UploadScheduleModel extends FlutterFlowModel<UploadScheduleWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for syllabus widget.
  FocusNode? syllabusFocusNode;
  TextEditingController? syllabusTextController;
  String? Function(BuildContext, String?)? syllabusTextControllerValidator;
  // Stores action output result for [Backend Call - API (generateStudyPlan)] action in confirm widget.
  ApiCallResponse? apiResult0ge;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    syllabusFocusNode?.dispose();
    syllabusTextController?.dispose();
  }
}
