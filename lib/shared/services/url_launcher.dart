import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launcher.g.dart';

class UrlLauncher {
  Future<void> launch(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

@riverpod
UrlLauncher urlLauncher(UrlLauncherRef ref) {
  return UrlLauncher();
}
