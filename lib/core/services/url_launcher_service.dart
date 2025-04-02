import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherService {
  Future<void> redirect(Uri url);
}

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<void> redirect(Uri url) async {
    if (!await canLaunchUrl(url)) {
      throw Exception('Could not launch $url');
    }
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
