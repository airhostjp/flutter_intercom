class ICMUserAttributes {
  final String? userId;
  final String? email;
  final String? phone;
  final String? name;
  final String? languageOverride;
  final Map<String, dynamic>? customAttributes;

  ICMUserAttributes({
    this.userId,
    this.email,
    this.phone,
    this.name,
    this.languageOverride,
    this.customAttributes,
  });

  factory ICMUserAttributes.fromJson(Map<String, dynamic> json) {
    return ICMUserAttributes(
      userId: json['userId'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      languageOverride: json['languageOverride'],
      customAttributes: Map<String, dynamic>.from(json['customAttributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'phone': phone,
      'name': name,
      'languageOverride': languageOverride,
      'customAttributes': customAttributes,
    };
  }
}