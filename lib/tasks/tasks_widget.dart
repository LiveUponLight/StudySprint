import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/n_p_s_popup_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tasks_model.dart';
export 'tasks_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  static String routeName = 'Tasks';
  static String routePath = '/tasks';

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late TasksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TasksModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Tasks'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('TASKS_PAGE_Tasks_ON_INIT_STATE');
      logFirebaseEvent('Tasks_custom_action');
      await actions.updateDailyStreak(
        valueOrDefault(currentUserDocument?.streak, 0),
        currentUserDocument?.lastVisit,
      );
      logFirebaseEvent('Tasks_backend_call');

      await currentUserReference!.update(createUserRecordData(
        lastVisit: getCurrentTimestamp,
        streak: functions.calculateStreakV2(
            valueOrDefault(currentUserDocument?.streak, 0),
            currentUserDocument?.lastVisit),
      ));
      logFirebaseEvent('Tasks_firestore_query');
      _model.npsQuery = await queryNpsResponsesRecordOnce(
        queryBuilder: (npsResponsesRecord) => npsResponsesRecord.where(
          'user_id',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (!valueOrDefault<bool>(currentUserDocument?.hasCompletedNPS, false)) {
        logFirebaseEvent('Tasks_bottom_sheet');
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Color(0xFFFFFEFE),
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: Container(
                  height: 400.0,
                  child: NPSPopupWidget(),
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<StudyPlanRecord>>(
      stream: queryStudyPlanRecord(
        queryBuilder: (studyPlanRecord) => studyPlanRecord.where(
          'userId',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<StudyPlanRecord> tasksStudyPlanRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final tasksStudyPlanRecord = tasksStudyPlanRecordList.isNotEmpty
            ? tasksStudyPlanRecordList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Tasks',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.interTight(
                            color: Color(0x00000000),
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Week: ${valueOrDefault<String>(
                                  FFAppState().WhichWeek.toString(),
                                  'Week: 0',
                                )}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 27.2,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 10.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'TASKS_PAGE_arrow_back_ICN_ON_TAP');
                                  logFirebaseEvent(
                                      'IconButton_update_app_state');
                                  FFAppState().WhichWeek =
                                      FFAppState().WhichWeek +
                                          ((FFAppState().WhichWeek > 0) &&
                                                  (FFAppState().WhichWeek <=
                                                      tasksStudyPlanRecord!
                                                          .totalWeeks)
                                              ? -1
                                              : 0);
                                  safeSetState(() {});
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 27.2,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 10.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'TASKS_PAGE_arrow_forward_ICN_ON_TAP');
                                  logFirebaseEvent(
                                      'IconButton_update_app_state');
                                  FFAppState().WhichWeek =
                                      FFAppState().WhichWeek +
                                          ((FFAppState().WhichWeek >= 0) &&
                                                  (FFAppState().WhichWeek <
                                                      (tasksStudyPlanRecord!
                                                              .totalWeeks -
                                                          1))
                                              ? 1
                                              : 0);
                                  safeSetState(() {});
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  'Day: ${FFAppState().DayOfWeek}',
                                  'Day: monday',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 27.2,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 10.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'TASKS_PAGE_arrow_back_ICN_ON_TAP');
                                  logFirebaseEvent(
                                      'IconButton_update_app_state');
                                  FFAppState().DayOfWeek = () {
                                    if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.monday.name) {
                                      return DaysOfTheWeek.friday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.friday.name) {
                                      return DaysOfTheWeek.thursday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.thursday.name) {
                                      return DaysOfTheWeek.wednesday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.wednesday.name) {
                                      return DaysOfTheWeek.tuesday.name;
                                    } else {
                                      return DaysOfTheWeek.monday.name;
                                    }
                                  }();
                                  safeSetState(() {});
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 27.2,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 10.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'TASKS_PAGE_arrow_forward_ICN_ON_TAP');
                                  logFirebaseEvent(
                                      'IconButton_update_app_state');
                                  FFAppState().DayOfWeek = () {
                                    if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.monday.name) {
                                      return DaysOfTheWeek.tuesday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.tuesday.name) {
                                      return DaysOfTheWeek.wednesday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.wednesday.name) {
                                      return DaysOfTheWeek.thursday.name;
                                    } else if (FFAppState().DayOfWeek ==
                                        DaysOfTheWeek.thursday.name) {
                                      return DaysOfTheWeek.friday.name;
                                    } else {
                                      return DaysOfTheWeek.monday.name;
                                    }
                                  }();
                                  safeSetState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Container(
                      height: 600.0,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) {
                                  final taskList = functions
                                      .getDayTasks(
                                          tasksStudyPlanRecord!.weeks,
                                          FFAppState().WhichWeek,
                                          FFAppState().DayOfWeek)
                                      .toList();

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: taskList.length,
                                    itemBuilder: (context, taskListIndex) {
                                      final taskListItem =
                                          taskList[taskListIndex];
                                      return Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Text(
                                          taskListItem,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              if (getRemoteConfigBool('show_streak_feature') ==
                                  true)
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Streak ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 25.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/16021504_0.jpg',
                                          width: 150.0,
                                          height: 150.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          valueOrDefault<String>(
                                            valueOrDefault(
                                                    currentUserDocument?.streak,
                                                    0)
                                                .toString(),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 30.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ]
                                .divide(SizedBox(height: 10.0))
                                .around(SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent('TASKS_PAGE_LOGOUT_BTN_ON_TAP');
                      logFirebaseEvent('Button_auth');
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();

                      context.goNamedAuth(
                          LoginWidget.routeName, context.mounted);
                    },
                    text: 'Logout',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
