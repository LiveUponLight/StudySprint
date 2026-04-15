import '/flutter_flow/flutter_flow_util.dart';
import 'n_p_s_popup_widget.dart' show NPSPopupWidget;
import 'package:flutter/material.dart';

class NPSPopupModel extends FlutterFlowModel<NPSPopupWidget> {
  ///  Local state fields for this component.

  int selectedScore = -1;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
