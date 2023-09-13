class KeyPair {
  final String pk;
  final String sk;

  KeyPair({required this.pk, required this.sk});

  factory KeyPair.fromJson(Map<Object?, Object?> json) => KeyPair(
        pk: (json['pk'] ?? '') as String,
        sk: (json['sk'] ?? '') as String,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pk': pk,
      'sk': sk,
    };
  }
}
