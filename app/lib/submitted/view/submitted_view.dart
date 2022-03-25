import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:moralpain/assets/constants.dart' as Constant;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralpain/assets/colors.dart' as uvacolors;
import 'package:moralpain/submitted/submitted.dart';
import 'package:moralpainapi/moralpainapi.dart' as api;
import 'package:url_launcher/url_launcher.dart';

class SubmittedView extends StatelessWidget {
  const SubmittedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constant.APPBAR_TEXT)),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 2, child: thankYouHeader(context)),
            Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "If you need immediate relief please page PIC1712 to notify the MDC",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))),
            Flexible(
              flex: 4,
              child: helpfulLinkView(context),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ResourcesBloc>().add(VisitedResourcesSubmitEvent());
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(Icons.home_rounded)),
    );
  }

  Widget thankYouHeader(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: new Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: <Color>[
                  uvacolors.UVABlueTints,
                  uvacolors.UVABlueTints.shade50
                ],
                tileMode:
                    TileMode.clamp, // repeats the gradient over the canvas
              ),
              boxShadow: [
                BoxShadow(
                    color: uvacolors.UVABlueTints.shade100, spreadRadius: 2),
                BoxShadow(
                    color: uvacolors.UVABlueTints.shade200,
                    spreadRadius: 4,
                    blurRadius: 3),
              ],
              color: uvacolors.UVABlue,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank You!",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Your MoD score is important to us and has been recorded",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ])),
      );

  Widget helpfulLinkView(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Resiliencey Resources",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            BlocBuilder<ResourcesBloc, ResourcesState>(
                builder: (context, state) {
              if (state is ResourcesLoaded) {
                return Expanded(
                    child: GridView.count(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        childAspectRatio: 1.5,
                        crossAxisCount: 2,
                        children: state.resources.resources!
                            .map((p0) => buildContainer(context, p0))
                            .toList()));
              } else {
                return Text("FOO");
              }
            })
          ]);

  Widget buildContainer(
      BuildContext context, api.ResiliencyResource resiliencyResource) {
    return Card(
        elevation: 3,
        child: InkWell(
            splashColor: uvacolors.UVAOrange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(resiliencyResource.title!),
                buildIcon(resiliencyResource),
                Text(resiliencyResource.description!),
              ],
            ),
            onTap: () {
              context
                  .read<ResourcesBloc>()
                  .add(ResourceVisitedEvent(resiliencyResource.resourceId!));
              _launchURL(resiliencyResource.url!);
            }));
  }

  Widget buildIcon(api.ResiliencyResource resiliencyResource) {
    final input = resiliencyResource.icon!;
    final iconData = IconData(
        int.parse(input.codePoint!.replaceFirst('0x', ''), radix: 16),
        fontFamily: input.fontFamily);
    return Icon(iconData, size: 40.0);
  }

  void _launchURL(String url) async => await canLaunch(url)
      ? await launch(url, forceWebView: true, enableJavaScript: true)
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
