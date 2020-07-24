import 'dart:convert';

class GrafanaDashboard {
  
  GrafanaDashboard({this.folder, this.title, this.uid, this.url, this.theme, this.from, this.to, this.panelsId});

  final String folder;
  final String title;
  final String uid;
  final String url;
  final String theme;
  final String from;
  final String to;
  final List<int> panelsId;


  static GrafanaDashboard fromResponseV7(dynamic data, String theme, String from, String to) {
    final panels = data['dashboard']['panels'] as List<dynamic>;
    return GrafanaDashboard(
        folder: data['meta']['folderTitle'].toString(),
        title: data['dashboard']['title'].toString(),
        uid: data['dashboard']['uid'].toString(),
        url: data['meta']['url'].toString(),
        theme: theme ?? data['dashboard']['style'].toString(),
        from: from ?? data['dashboard']['time']['from'].toString(),
        to: to ?? data['dashboard']['time']['to'].toString(),
        panelsId: List.generate(panels.length, (index) => int.tryParse(panels[index]['id'].toString()))
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folder': folder,
      'title': title,
      'uid': uid,
      'url': url,
      'theme': theme,
      'from': from,
      'to': to,
      'panelsId': panelsId
    };
  }
  
  String toJson() => json.encode(toMap());

}

