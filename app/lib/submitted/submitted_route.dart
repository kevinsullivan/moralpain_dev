import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moralpain/assets/constants.dart' as Constant;
import 'package:moralpain/assets/colors.dart' as uvacolors;
import 'package:url_launcher/url_launcher.dart';

class SubmittedRoute extends StatelessWidget {
  const SubmittedRoute({Key? key}) : super(key: key);

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
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Resiliency Resources",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1,
                      ))),
              Flexible(
                flex: 4,
                child: helpfulLinkView(context),
              ),
            ]));
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

  // TODO (nphair): Figure out scroll clipping text.
  Widget helpfulLinkView(BuildContextcontext) => GridView.count(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          HelpfulLink("Breathing Exercises", "description", Icons.air_rounded,
              "https://www.youtube.com/watch?v=5_N98E5-7jo"),
          HelpfulLink("Body Scan", "description", Icons.person_rounded,
              "https://www.uclahealth.org/marc/mpeg/Body-Scan-Meditation.mp3"),
          HelpfulLink("Chair Yoga", "description", Icons.chair_alt_rounded,
              "https://www.youtube.com/watch?v=tAUf7aajBWE"),
          HelpfulLink("Furry Friends", "description", Icons.pets_rounded,
              "https://www.instagram.com/weratedogs/")
        ].map(buildContainer).toList(),
      );

  Widget buildContainer(HelpfulLink link) {
    return Card(
        elevation: 3,
        child: InkWell(
            splashColor: uvacolors.UVAOrange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(link.title),
                Icon(link.icon, size: 40),
                Text(link.description),
              ],
            ),
            onTap: () => {print('tapped'), _launchURL(link.url)}));
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
