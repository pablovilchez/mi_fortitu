import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

const urlHome =
    'https://gist.githubusercontent.com/pablovilchez/4cd081c2136eb6e595743b446163b803/raw/home_info.md';
const urlProfile =
    'https://gist.githubusercontent.com/pablovilchez/dacd33e72dee5b2bbaa650b5b83ed319/raw/profile_info.md';
const urlSearchProfile =
    'https://gist.githubusercontent.com/pablovilchez/e15a2464217ac7cae81101d9e88be117/raw/search_profile_info.md';
const urlSlots =
    'https://gist.githubusercontent.com/pablovilchez/c9a2ce0c67f0f223e4415bd431f0a5e0/raw/slots_info.md';
const urlShop =
    'https://gist.githubusercontent.com/pablovilchez/1b3efcad3e90834baebb67122ec58e62/raw/shop_info.md';
const urlPeer2peer =
    'https://gist.githubusercontent.com/pablovilchez/90f66a3232b2e90679b1f834ce779394/raw/peer2peer_info.md';
const urlClusters =
    'https://gist.githubusercontent.com/pablovilchez/1b0c4ed16992448f6916009aeb790423/raw/clusters_info.md';
const urlCoalitions =
    'https://gist.githubusercontent.com/pablovilchez/4f277e6fec961379b7c7e1fa4a2bd164/raw/coalitions_info.md';
const urlLeagues =
    'https://gist.githubusercontent.com/pablovilchez/38a3c15f37edf7d4f4872581b49a1fe2/raw/leagues_info.md';
const urlSettings = 'https://gist.githubusercontent.com/pablovilchez/7608ab0cb1fd2117bdcbdf1f5bad6b7c/raw/settings_info.md';

Future<String?> _fetchDevInfo(String section) async {
  try {
    final response = await http.get(Uri.parse(section));
    if (response.statusCode == 200) return response.body;
  } catch (e) {
    debugPrint('Error fetching dev info: $e');
  }
  return null;
}

Future<void> showDevInfoDialog(BuildContext context, String section) async {
  late final String url;
  if (section == 'homeTestInfo') {
    url = urlHome;
  } else if (section == 'profileTestInfo') {
    url = urlProfile;
  } else if (section == 'searchTestInfo') {
    url = urlSearchProfile;
  } else if (section == 'slotsTestInfo') {
    url = urlSlots;
  } else if (section == 'shopTestInfo') {
    url = urlShop;
  } else if (section == 'peer2peerTestInfo') {
    url = urlPeer2peer;
  } else if (section == 'clustersTestInfo') {
    url = urlClusters;
  } else if (section == 'coalitionsTestInfo') {
    url = urlCoalitions;
  } else if (section == 'leaguesTestInfo') {
    url = urlLeagues;
  } else if (section == 'settingsTestInfo') {
    url = urlSettings;
  } else {
    return;
  }

  final content = await _fetchDevInfo(url);
  if (!context.mounted || content == null) return;

  final scrollController = ScrollController();
  bool hasScroll = false;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients &&
                scrollController.position.maxScrollExtent > 0 &&
                !hasScroll) {
              setState(() => hasScroll = true);
            }
          });

          return AlertDialog(
            content: SizedBox(
              width: 450,
              height: 550,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: MarkdownBody(data: content),
                    ),
                  ),
                  if (hasScroll)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.grey),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ],
          );
        },
      );
    },
  );
}
