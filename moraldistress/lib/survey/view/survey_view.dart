import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/assets/constants.dart' as constants;
import 'package:moraldistress/assets/survey_constants.dart' as surveyconstants;
import 'package:expandable_text/expandable_text.dart';
import 'package:moraldistress/submitted/view/submitted_route.dart';
import 'package:moralpainapi/src/model/survey_section.dart';
import 'package:moralpainapi/src/model/survey_option.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:uva_themed_widgets/uva_themed_widgets.dart';

import '../survey.dart';

class SurveyView extends StatefulWidget {
  @override
  SurveyViewState createState() => SurveyViewState();
}

class SurveyViewState extends State<SurveyView> {
  final controller = ScrollController();
  bool _show = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollHandler);
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      _show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurveyBloc, SurveyState>(
        listenWhen: (previous, current) =>
            current is SurveyComplete ||
            current is SurveySubmitting ||
            current is SurveyLoadFailed,
        listener: (context, state) => handleSubmitEvents(context, state),
        buildWhen: (previous, current) =>
            current is SurveyLoading || current is SurveyLoaded,
        builder: (context, state) => handleLoadEvents(context, state));
  }

  /**
   * Invoked by the BlocListener when a survey is submitted. 
   * Returns to the home screen.
   */
  void handleSubmitEvents(BuildContext context, SurveyState state) {
    if (state is SurveySubmitting) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: submittingScreenBuilder);
    } else if (state is SurveyComplete) {
      if (!state.success) {
        showDialog(context: context, builder: failedSubmitScreenBuilder);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SubmittedRoute()),
            (route) => route.isFirst);
      }
    } else if (state is SurveyLoadFailed) {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(context: context, builder: failedSubmitScreenBuilder);
    } else {
      assert(false);
    }
  }

  /**
   * A builder function that returns an overlay with a loading bar.
   */
  Widget submittingScreenBuilder(BuildContext context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: UVALinearProgressIndicator()));

  /**
   * A builder function that alerts on submission failure.
   */

  Widget failedSubmitScreenBuilder(BuildContext context) => AlertDialog(
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                color: Colors.red, size: 40),
            SizedBox(width: 10),
            Text(surveyconstants.SURVEY_FAILED_SUBMISSION_TITLE,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
      actions: [
        ElevatedButton(
          child: const Text(
            'OK',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
      content: SingleChildScrollView(
          child: ListBody(
        children: const <Widget>[
          Text(surveyconstants.SURVEY_FAILED_SUBMISSION_TEXT),
          Text(surveyconstants.SURVEY_FAILED_SUBMISSION_TEXT_2),
        ],
      )));

  Widget handleLoadEvents(BuildContext context, SurveyState state) {
    final title = Text(
      surveyconstants.SURVEY_TITLE,
      style: TextStyle(fontSize: 16),
    );

    final spacer = SizedBox(
      height: 10,
    );

    final instructions = ExpandableText(
      surveyconstants.SURVEY_INSTRUCTIONS,
      expandText: surveyconstants.SURVEY_EXPAND_TEXT,
      collapseText: surveyconstants.SURVEY_COLLAPSE_TEXT,
      maxLines: 1,
      linkEllipsis: false,
      linkColor: Colors.blue,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.APPBAR_TEXT),
      ),
      body: Padding(
          padding: EdgeInsets.all(constants.PADDING),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                spacer,
                instructions,
                spacer,
                surveyFromState(state)
              ])),
      // TODO (nphair): Since this button is always visible now we can get
      // rid of the visibility widget and make this whole page stateless.
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {
            var bloc = context.read<SurveyBloc>();
            print(bloc.score);
            if (bloc.score >
                    surveyconstants.SURVEY_NO_SELCTIONS_REQUIRED_SCORE &&
                !bloc.options.containsValue(true)) {
              badSubmissionToast(context);
            } else {
              bloc.add(SurveySubmitEvent());
            }
          },
          child: Icon(Icons.send),
        ),
      ),
    );
  }

  /**
   * Returns a view of the survey depending on the current state.
   * 
   * Only invoked on SurveyLoaded and SurveyLoading states.
   */
  Widget surveyFromState(SurveyState state) {
    if (state is SurveyLoading) {
      return Expanded(child: Center(child: UVACircularProgressIndicator()));
    } else if (state is SurveyLoaded) {
      return Expanded(
          child: ListView(
              controller: controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: state.survey.sections!
                  .map((q) => cardForSection(q))
                  .toList()));
    } else {
      assert(false);
      return ErrorWidget("Error State");
    }
  }

  void badSubmissionToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          surveyconstants.SURVEY_BAD_SUBMISSION_TEXT,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void scrollHandler() {
    print(controller.position.pixels);
    print(controller.position.maxScrollExtent);

    if (controller.position.pixels == controller.position.maxScrollExtent) {
      showFloationButton();
    } else {
      hideFloationButton();
    }
  }

  Widget cardForSection(SurveySection section) {
    return ExpansionTileCard(
      title: Text(section.title!),
      subtitle: Text(section.subtitle!),
      initialElevation: 3,
      elevation: 3,
      initialPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      finalPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SurveyOptionsWidget(section.sectionId!, section.options!)],
        )
      ],
    );
  }
}

class SurveyOptionsWidget extends StatefulWidget {
  final List<SurveyOption> options;
  final String sectionId;

  SurveyOptionsWidget(this.sectionId, this.options);

  @override
  SurveyOptionsWidgetState createState() =>
      new SurveyOptionsWidgetState(sectionId, options);
}

class SurveyOptionsWidgetState extends State<SurveyOptionsWidget> {
  final List<SurveyOption> options;
  final String sectionId;

  SurveyOptionsWidgetState(this.sectionId, this.options);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SurveyBloc, SurveyState, bool>(
        selector: (state) => state is SurveyUpdated,
        builder: (ctx, state) {
          final bloc = context.read<SurveyBloc>();

          return new Column(
              children: this.options.map((option) {
            // Prepend section id to try and establish unique option ids.
            final optionId = '${this.sectionId}_${option.id}';
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(option.description!),
              value: bloc.options.putIfAbsent(optionId, () => false),
              onChanged: (bool? value) {
                setState(() {
                  bloc.add(SurveyUpdateEvent(optionId, value!));
                });
              },
            );
          }).toList());
        });
  }
}
