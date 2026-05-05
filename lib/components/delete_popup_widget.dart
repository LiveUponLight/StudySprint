import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'delete_popup_model.dart';
export 'delete_popup_model.dart';

class DeletePopupWidget extends StatefulWidget {
  const DeletePopupWidget({
    super.key,
    required this.syllabi,
  });

  final List<StudyPlanRecord>? syllabi;

  @override
  State<DeletePopupWidget> createState() => _DeletePopupWidgetState();
}

class _DeletePopupWidgetState extends State<DeletePopupWidget> {
  late DeletePopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeletePopupModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 150.0, 0.0, 0.0),
        child: Container(
          width: 300.0,
          decoration: BoxDecoration(
            color: Color(0xFF1F1F1E),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color(0xFF1A6BFF),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Text(
                          'Delete:',
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
                                    color: Color(0xFFC0C0C0),
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
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent(
                              'DELETE_POPUP_COMP_Icon_h71euknv_ON_TAP');
                          logFirebaseEvent('Icon_close_dialog_drawer_etc');
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_sharp,
                          color: Color(0xFFC0C0C0),
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    final syllabi = widget.syllabi!.toList();

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
                                0.0, 5.0, 0.0, 10.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                logFirebaseEvent(
                                    'DELETE_POPUP_COMP_Text_f77fwe7m_ON_TAP');
                                logFirebaseEvent('Text_backend_call');

                                await widget.syllabi!
                                    .elementAtOrNull(syllabiIndex)!
                                    .reference
                                    .update(createStudyPlanRecordData(
                                      isDeleted: true,
                                    ));
                                logFirebaseEvent(
                                    'Text_close_dialog_drawer_etc');
                                Navigator.pop(context);
                                logFirebaseEvent('Text_firestore_query');
                                _model.aovn = await queryStudyPlanRecordOnce(
                                  queryBuilder: (studyPlanRecord) =>
                                      studyPlanRecord
                                          .where(
                                            'userId',
                                            isEqualTo: currentUserUid,
                                          )
                                          .where(
                                            'isDeleted',
                                            isEqualTo: false,
                                          ),
                                );
                                if (!(_model.aovn != null &&
                                    (_model.aovn)!.isNotEmpty)) {
                                  logFirebaseEvent('Text_navigate_to');

                                  context.pushNamed(
                                      UploadScheduleWidget.routeName);
                                }

                                safeSetState(() {});
                              },
                              child: Text(
                                syllabiItem.title,
                                textAlign: TextAlign.center,
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
                                      color: Color(0xFFEF4444),
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
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
