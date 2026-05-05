import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_popup_widget.dart' show DeletePopupWidget;
import 'package:flutter/material.dart';

class DeletePopupModel extends FlutterFlowModel<DeletePopupWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> syllabiQuery = [];
  void addToSyllabiQuery(DocumentReference item) => syllabiQuery.add(item);
  void removeFromSyllabiQuery(DocumentReference item) =>
      syllabiQuery.remove(item);
  void removeAtIndexFromSyllabiQuery(int index) => syllabiQuery.removeAt(index);
  void insertAtIndexInSyllabiQuery(int index, DocumentReference item) =>
      syllabiQuery.insert(index, item);
  void updateSyllabiQueryAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      syllabiQuery[index] = updateFn(syllabiQuery[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<StudyPlanRecord>? aovn;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
