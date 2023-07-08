class FirebaseRequest {
  final String? title;
  final String? description;
  final String? location;
  final String? date;
   String? attachment;
    String? uid;

  FirebaseRequest({
    this.title,
    this.description,
    this.location,
    this.date,
    this.uid,
    this.attachment,
  });

  FirebaseRequest.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        description = json['description'] as String?,
        location = json['location'] as String?,
        date = json['date'] as String?,
        uid = json['uid'] as String?,
        attachment = json['attachment'] as String?;

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'location': location,
        'date': date,
        'uid': uid,
        'attachment': attachment
      };
}
