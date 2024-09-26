import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moraldistress/assets/constants.dart' as constants;
import 'package:moraldistress/assets/submitted_constants.dart' as submittedconstants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/submitted/submitted.dart';
import 'package:moralpainapi/moralpainapi.dart' as api;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uva_themed_widgets/src/colors.dart' as uvacolors;

class SubmittedView extends StatelessWidget {
  const SubmittedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.APPBAR_TEXT),
        automaticallyImplyLeading: false,
      ),
      body: Submitted(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ResourcesBloc>(context)
                .add(VisitedResourcesSubmitEvent());
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(Icons.home_rounded)),
    );
  }
}

class Submitted extends StatefulWidget {
  @override
  _SubmittedState createState() => _SubmittedState();
}

// NB (nphair): Hack courtesy of https://github.com/flutter/flutter/issues/50946
class _SubmittedState extends State<Submitted> {
  late PageController _pageController;
  late ScrollController _listScrollController;
  late ScrollController _activeScrollController;
  late Drag _drag;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_listScrollController.hasClients) {
      final RenderBox renderBox = _listScrollController
          .position.context.storageContext
          .findRenderObject() as RenderBox;
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    _activeScrollController = _pageController;
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  bool _listScrollerAtBounds() {
    if (_activeScrollController != _listScrollController) {
      return false;
    }

    double currentPos = _activeScrollController.position.pixels.roundToDouble();
    double maxPos =
        _activeScrollController.position.maxScrollExtent.roundToDouble();
    return currentPos >= maxPos || currentPos <= 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_listScrollerAtBounds()) {
      _activeScrollController = _pageController;
      _drag.cancel();
      _drag = _pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    _drag.end(details);
  }

  void _handleDragCancel() {
    _drag.cancel();
  }

  void _disposeDrag() {/* noop. */}

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
              (VerticalDragGestureRecognizer instance) {
            instance
              ..onStart = _handleDragStart
              ..onUpdate = _handleDragUpdate
              ..onEnd = _handleDragEnd
              ..onCancel = _handleDragCancel;
          })
        },
        behavior: HitTestBehavior.opaque,
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            thankYouPage(context),
            resourcesPage(context),
          ],
        ));
  }

  Widget thankYouPage(BuildContext context) {
    return Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(flex: 2, child: thankYouHeader(context)),
        Flexible(
            flex: 0,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  submittedconstants.SUBMITTED_BODY,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1,
                ))),
        Flexible(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                submittedconstants.SUBMITTED_BODY2,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1,
              )),
          flex: 0,
        ),
        Flexible(flex: 4, child: SizedBox()),
      ])
    ]);
  }

  Widget thankYouHeader(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      decoration: thankYouDecoration(),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              submittedconstants.SUBMITTED_TITLE,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .apply(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              submittedconstants.SUBMITTED_SUBTITLE,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.white),
            )
          ]));

  BoxDecoration thankYouDecoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            uvacolors.UVABlueTints,
            uvacolors.UVABlueTints.shade50
          ],
          tileMode: TileMode.clamp,
        ),
        boxShadow: [
          BoxShadow(color: uvacolors.UVABlueTints.shade100, spreadRadius: 2),
          BoxShadow(
              color: uvacolors.UVABlueTints.shade200,
              spreadRadius: 4,
              blurRadius: 3),
        ],
        color: uvacolors.UVABlue,
      );

  Widget resourcesPage(BuildContext context) {
    return BlocBuilder<ResourcesBloc, ResourcesState>(
        builder: (context, state) {
      if (state is ResourcesLoaded) {
        var cards = state.resources.resources!;
        return Container(
            child: ListView.builder(
                itemCount: cards.length,
                controller: _listScrollController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var resource = cards[index];
                  return resiliencyTile(resource, context);
                }));
      } else {
        return Container();
      }
    });
  }

  Widget resiliencyTile(api.ResiliencyResource resource, BuildContext context) {
    return Material(
        child: ListTile(
            leading: buildIcon(resource),
            title: Text(resource.title!),
            onTap: () {
              context
                  .read<ResourcesBloc>()
                  .add(ResourceVisitedEvent(resource.resourceId!));
              _launchURL(resource.url!);
            }));
  }

  Widget buildIcon(api.ResiliencyResource resiliencyResource) {
    final input = resiliencyResource.icon!;
    final iconData = IconData(
        int.parse(input.codePoint!.replaceFirst('0x', ''), radix: 16),
        fontFamily: input.fontFamily);
    return Icon(iconData, size: 40.0);
  }

  void _launchURL(String url) async => await canLaunchUrlString(url)
      ? await launchUrlString(url)
      : throw 'Could not launch $url';
}

// TODO (nphair): Replace with a model.
class HelpfulLink {
  final String title;
  final String description;
  final IconData icon;
  final String url;

  const HelpfulLink(this.title, this.description, this.icon, this.url);
}
