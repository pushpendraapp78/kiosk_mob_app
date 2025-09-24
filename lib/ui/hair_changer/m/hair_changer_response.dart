class HairChangerResponse {
  final bool success;
  final String? referenceId;
  final String? originalImageUrl;
  final String? resultUrl;
  final String? status;
  final String? message;
  final String? error;
  final String? transformationType;
  final String? colorDescription;
  final String? hairstyleDescription;
  final int? processingTimeMs;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fileName;

  HairChangerResponse({
    required this.success,
    this.referenceId,
    this.originalImageUrl,
    this.resultUrl,
    this.status,
    this.message,
    this.error,
    this.transformationType,
    this.colorDescription,
    this.hairstyleDescription,
    this.processingTimeMs,
    this.createdAt,
    this.updatedAt,
    this.fileName,
  });

  factory HairChangerResponse.fromJson(Map<String, dynamic> json) {
    return HairChangerResponse(
      success: json['success'] ?? false,
      referenceId: json['data']?['referenceId'] ?? json['reference_id'],
      originalImageUrl: json['data']?['originalImageUrl'] ?? json['original_image_url'],
      resultUrl: json['data']?['resultImageUrl'] ?? json['result_image_url'],
      status: json['data']?['status'] ?? json['status'],
      message: json['message'],
      error: json['error'] ?? json['message'],
      transformationType: json['data']?['transformationType'] ?? json['transformation_type'],
      colorDescription: json['data']?['colorDescription'] ?? json['color_description'],
      hairstyleDescription: json['data']?['hairstyleDescription'] ?? json['hairstyle_description'],
      processingTimeMs: json['data']?['processingTimeMs'] ?? json['processing_time_ms'],
      createdAt: json['data']?['createdAt'] != null
          ? DateTime.parse(json['data']['createdAt'])
          : json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['data']?['updatedAt'] != null
          ? DateTime.parse(json['data']['updatedAt'])
          : json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      fileName: json['data']?['fileName'] ?? json['fileName'],
    );
  }
}