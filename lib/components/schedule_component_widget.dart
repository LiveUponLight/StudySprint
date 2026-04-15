import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'schedule_component_model.dart';
export 'schedule_component_model.dart';

/// New Component Gen
class ScheduleComponentWidget extends StatefulWidget {
  const ScheduleComponentWidget({super.key});

  @override
  State<ScheduleComponentWidget> createState() =>
      _ScheduleComponentWidgetState();
}

class _ScheduleComponentWidgetState extends State<ScheduleComponentWidget> {
  late ScheduleComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
