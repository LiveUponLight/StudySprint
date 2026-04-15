import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';
  static void maybeSetRouteName(String? updatedRouteName) =>
      routeName = updatedRouteName ?? routeName;
  static void maybeSetRoutePath(String? updatedRoutePath) =>
      routePath = updatedRoutePath ?? routePath;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.light);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200.0,
              child: custom_widgets.FFReadMoreText(
                width: MediaQuery.sizeOf(context).width,
                height: 200.0,
                text:
                    'This widget demonstrates expandable text with a smooth fade and a rotating arrow icon. Keep your layouts clean by showing only three lines by default and letting users expand on demand. Works without external packages and accepts any widget as the toggle icon.',
                maxLines: 3,
                initiallyExpanded: false,
                expandLabel: 'Read more',
                collapseLabel: 'Collapse',
                labelColor: FlutterFlowTheme.of(context).secondary,
                labelSize: 14.0,
                textColor: Color(0xFF111111),
                textSize: 14.0,
                lineHeight: 1.4,
                textAlignStr: 'left',
                labelAlignStr: 'left',
                showFadeWhileCollapsed: true,
                fadeHeight: 28.0,
                fadeColor: FlutterFlowTheme.of(context).info,
                animationMs: 220,
                expandOnTextTap: false,
                gapBetweenTextAndLabel: 8.0,
                labelIcon: Icon(
                  FFIcons.kchevronDown,
                  color: FlutterFlowTheme.of(context).secondary,
                  size: 20.0,
                ),
                rotateIconOnToggle: true,
                iconTurnsCollapsed: 0.0,
                iconTurnsExpanded: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
