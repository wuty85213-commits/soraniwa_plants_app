import 'package:flutter/material.dart';
import 'package:myplantapp_ver1/l10n/app_localizations.dart';
import 'package:myplantapp_ver1/ui/common/widget/cancel_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditDialog extends StatelessWidget {
  const CreditDialog({super.key});

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/common/dialog_cream2.png'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 8),
              blurRadius: 10,
              spreadRadius: 0.5,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l.credit,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            _creditItem(
              context,
              title: l.illustration_Credits,
              urlName: l.illustAC,
              url: "https://www.ac-illust.com/",
            ),

            _creditItem(
              context,
              title: l.illustration_Credits,
              urlName: "Paper-co",
              url: "https://free-paper-texture.com/",
            ),

            _creditItem(
              context,
              title: l.bgm_Credits,
              urlName: "MusMus",
              url: "https://musmus.main.jp/",
            ),

            _creditItem(
              context,
              title: l.se_Credits,
              urlName: l.sound_Effect_Lab,
              url: "https://soundeffect-lab.info/",
            ),

            const SizedBox(height: 20),

            Text(
              l.text2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            CancelButton(onTap: () => Navigator.pop(context))
          ],
        ),
      ),
    );
  }

  Widget _creditItem(
      BuildContext context, {
        required String title,
        required String urlName,
        required String url,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _openUrl(url),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("【$title】", style: const TextStyle(fontSize: 16)),
            Text(
              "・$urlName",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}