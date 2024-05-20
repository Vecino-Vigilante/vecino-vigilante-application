class ComplaintTypeResponse {
  String? id;
  String? name;

  ComplaintTypeResponse({
    required this.id,
    required this.name,
  });

  factory ComplaintTypeResponse.fromJson(Map<String, dynamic> json) =>
      ComplaintTypeResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
