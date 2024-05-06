import 'dart:convert';

List<ComplaintDTO> getAllComplaintsResponseFromJson(String str) => List<ComplaintDTO>.from(json.decode(str).map((x) => ComplaintDTO.fromJson(x)));

String getAllComplaintsResponseToJson(List<ComplaintDTO> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintDTO {
    String id;
    int typeId;
    String type;
    String description;
    DateTime date;
    String imageUrl;
    UserDTO user;
    LocationDTO location;

    ComplaintDTO({
        required this.id,
        required this.typeId,
        required this.type,
        required this.description,
        required this.date,
        required this.imageUrl,
        required this.user,
        required this.location,
    });

    factory ComplaintDTO.fromJson(Map<String, dynamic> json) => ComplaintDTO(
        id: json["id"],
        typeId: json["type_id"],
        type: json["type"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        imageUrl: json["image_url"],
        user: UserDTO.fromJson(json["user"]),
        location: LocationDTO.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "type": type,
        "description": description,
        "date": date.toIso8601String(),
        "image_url": imageUrl,
        "user": user.toJson(),
        "location": location.toJson(),
    };
}

class LocationDTO {
    String incidentId;
    double latitude;
    double longitude;
    String direction;

    LocationDTO({
        required this.incidentId,
        required this.latitude,
        required this.longitude,
        required this.direction,
    });

    factory LocationDTO.fromJson(Map<String, dynamic> json) => LocationDTO(
        incidentId: json["incident_id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        direction: json["direction"],
    );

    Map<String, dynamic> toJson() => {
        "incident_id": incidentId,
        "latitude": latitude,
        "longitude": longitude,
        "direction": direction,
    };
}

class UserDTO {
    String id;
    String name;
    String lastName;
    String email;
    String profileImage;

    UserDTO({
        required this.id,
        required this.name,
        required this.lastName,
        required this.email,
        required this.profileImage,
    });

    factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "profile_image": profileImage,
    };
}
