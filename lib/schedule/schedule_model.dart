import '/components/schedule_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_widget.dart' show ScheduleWidget;
import 'package:flutter/material.dart';

class ScheduleModel extends FlutterFlowModel<ScheduleWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Schedule_Component component.
  late ScheduleComponentModel scheduleComponentModel1;
  // Model for Schedule_Component component.
  late ScheduleComponentModel scheduleComponentModel2;
  // Model for Schedule_Component component.
  late ScheduleComponentModel scheduleComponentModel3;
  // Model for Schedule_Component component.
  late ScheduleComponentModel scheduleComponentModel4;

  @override
  void initState(BuildContext context) {
    scheduleComponentModel1 =
        createModel(context, () => ScheduleComponentModel());
    scheduleComponentModel2 =
        createModel(context, () => ScheduleComponentModel());
    scheduleComponentModel3 =
        createModel(context, () => ScheduleComponentModel());
    scheduleComponentModel4 =
        createModel(context, () => ScheduleComponentModel());
  }

  @override
  void dispose() {
    scheduleComponentModel1.dispose();
    scheduleComponentModel2.dispose();
    scheduleComponentModel3.dispose();
    scheduleComponentModel4.dispose();
  }
}
