import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/delete_popup_widget.dart';
import '/components/n_p_s_popup_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
        queryBuilder: (studyPlanRecord) => studyPlanRecord
            .where(
              'userId',
              isEqualTo: currentUserUid,
            )
            .where(
              'isDeleted',
              isEqualTo: false,
            ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF0D0D1A),
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

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF0D0D1A),
            drawer: Drawer(
              elevation: 16.0,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xFF8888AA),
                  borderRadius: BorderRadius.only(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 64.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: Icon(
                              Icons.auto_stories_rounded,
                              color: Color(0xFF1A6BFF),
                              size: 25.0,
                            ),
                          ),
                          Text(
                            'StudySprint',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Switch Syllabus:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) {
                            final syllabi = tasksStudyPlanRecordList.toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: syllabi.length,
                              itemBuilder: (context, syllabiIndex) {
                                final syllabiItem = syllabi[syllabiIndex];
                                return Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'TASKS_PAGE_Text_36f1k05j_ON_TAP');
                                        logFirebaseEvent(
                                            'Text_update_app_state');
                                        FFAppState().syllabusIndex =
                                            syllabiIndex;
                                        safeSetState(() {});
                                        logFirebaseEvent('Text_drawer');
                                        if (scaffoldKey
                                                .currentState!.isDrawerOpen ||
                                            scaffoldKey.currentState!
                                                .isEndDrawerOpen) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        syllabiItem.title,
                                        textAlign: TextAlign.center,
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
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('TASKS_PAGE_Text_zlocycip_ON_TAP');
                        logFirebaseEvent('Text_navigate_to');

                        context.pushNamed(UploadScheduleWidget.routeName);
                      },
                      child: Text(
                        'Add a Syllabus',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: Color(0xFF1A6BFF),
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    Builder(
                      builder: (context) => InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent('TASKS_PAGE_Text_e7hkkybs_ON_TAP');
                          logFirebaseEvent('Text_close_dialog_drawer_etc');
                          Navigator.pop(context);
                          logFirebaseEvent('Text_alert_dialog');
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: DeletePopupWidget(
                                    syllabi: tasksStudyPlanRecordList,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Delete a Syllabus',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFEF4444),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('TASKS_PAGE_Text_tugko0i4_ON_TAP');
                        logFirebaseEvent('Text_auth');
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        context.goNamedAuth(
                            LoginWidget.routeName, context.mounted);
                      },
                      child: Text(
                        'Sign Out',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: Color(0xFFEF4444),
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Color(0xFF1A6BFF),
              automaticallyImplyLeading: true,
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Container(
                                width: 350.0,
                                decoration: BoxDecoration(),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      tasksStudyPlanRecordList
                                          .elementAtOrNull(
                                              FFAppState().syllabusIndex)
                                          ?.title,
                                      'Title not Found',
                                    ),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.interTight(
                                      color: Color(0xFF8888AA),
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 220.0,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 27.2,
                                  fillColor: Color(0xFF1A6BFF),
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
                                    FFAppState().WhichWeek = FFAppState()
                                            .WhichWeek +
                                        ((FFAppState().WhichWeek > 0) &&
                                                (FFAppState().WhichWeek <=
                                                    tasksStudyPlanRecordList
                                                        .elementAtOrNull(
                                                            FFAppState()
                                                                .syllabusIndex)!
                                                        .totalWeeks)
                                            ? -1
                                            : 0);
                                    safeSetState(() {});
                                  },
                                ),
                                Text(
                                  'Week: ${valueOrDefault<String>(
                                    FFAppState().WhichWeek.toString(),
                                    'Week: 0',
                                  )}',
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
                                        color: Color(0xFF8888AA),
                                        fontSize: 20.0,
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
                                  fillColor: Color(0xFF1A6BFF),
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
                                    FFAppState().WhichWeek = FFAppState()
                                            .WhichWeek +
                                        ((FFAppState().WhichWeek >= 0) &&
                                                (FFAppState().WhichWeek <
                                                    (tasksStudyPlanRecordList
                                                            .elementAtOrNull(
                                                                FFAppState()
                                                                    .syllabusIndex)!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 27.2,
                                  fillColor: Color(0xFF1A6BFF),
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
                                    FFAppState().WhichWeek = FFAppState()
                                            .WhichWeek +
                                        ((FFAppState().DayOfWeek ==
                                                    DaysOfTheWeek
                                                        .monday.name) &&
                                                (FFAppState().WhichWeek > 0) &&
                                                (FFAppState().WhichWeek <=
                                                    tasksStudyPlanRecordList
                                                        .elementAtOrNull(
                                                            FFAppState()
                                                                .syllabusIndex)!
                                                        .totalWeeks)
                                            ? -1
                                            : 0);
                                    safeSetState(() {});
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
                                Text(
                                  valueOrDefault<String>(
                                    'Day: ${FFAppState().DayOfWeek}',
                                    'Day: monday',
                                  ),
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
                                        color: Color(0xFF8888AA),
                                        fontSize: 20.0,
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
                                  fillColor: Color(0xFF1A6BFF),
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
                                    FFAppState().WhichWeek = FFAppState()
                                            .WhichWeek +
                                        ((FFAppState().DayOfWeek ==
                                                    DaysOfTheWeek
                                                        .friday.name) &&
                                                (FFAppState().WhichWeek <
                                                    (tasksStudyPlanRecordList
                                                            .elementAtOrNull(
                                                                FFAppState()
                                                                    .syllabusIndex)!
                                                            .totalWeeks -
                                                        1)) &&
                                                (FFAppState().WhichWeek >= 0)
                                            ? 1
                                            : 0);
                                    safeSetState(() {});
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
                          ]
                              .divide(SizedBox(height: 10.0))
                              .around(SizedBox(height: 10.0)),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 350.0,
                      height: 600.0,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Builder(
                              builder: (context) {
                                final taskList = functions
                                    .getDayTasks(
                                        tasksStudyPlanRecordList
                                            .elementAtOrNull(
                                                FFAppState().syllabusIndex)!
                                            .weeks,
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
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Container(
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF23233A),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Color(0xFF1A6BFF),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 3.0, 3.0, 3.0),
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
                                                  color: Color(0xFF8888AA),
                                                  letterSpacing: 0.0,
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
                                          ),
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
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Streak: ',
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
                                                color: Color(0xFF8888AA),
                                                fontSize: 25.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            valueOrDefault<String>(
                                              valueOrDefault(
                                                      currentUserDocument
                                                          ?.streak,
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
                                                  color: Color(0xFF8888AA),
                                                  fontSize: 25.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/16021504_0.jpg',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            AnimatedDefaultTextStyle(
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFFBFBFB),
                                    fontSize: 30.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              duration: Duration(milliseconds: 600),
                              curve: Curves.bounceOut,
                              child: Text(
                                'StudySprint',
                              ),
                            ),
                            Icon(
                              Icons.auto_stories_rounded,
                              color: Color(0xFF1A6BFF),
                              size: 35.0,
                            ),
                          ].divide(SizedBox(height: 10.0)),
                        ),
                      ),
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
