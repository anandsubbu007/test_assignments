class ErrorResponse {
  final String? message;
  final List<Errors>? errors;
  final String? documentationUrl;

  ErrorResponse({
    this.message,
    this.errors,
    this.documentationUrl,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        errors = (json['errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList(),
        documentationUrl = json['documentation_url'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'errors' : errors?.map((e) => e.toJson()).toList(),
    'documentation_url' : documentationUrl
  };
}

class Errors {
  final String? message;
  final String? resource;
  final String? field;
  final String? code;

  Errors({
    this.message,
    this.resource,
    this.field,
    this.code,
  });

  Errors.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        resource = json['resource'] as String?,
        field = json['field'] as String?,
        code = json['code'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'resource' : resource,
    'field' : field,
    'code' : code
  };
}