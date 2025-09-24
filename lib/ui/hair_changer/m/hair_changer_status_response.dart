class HairChangerStatusResponse {
  final bool success;
  final String? referenceId;
  final String? status;
  final String? resultImageUrl;
  final String? originalImageUrl;
  final String? errorMessage;
  final int? processingTime;
  final String? transformationType;
  final String? colorDescription;
  final String? hairstyleDescription;
  final DateTime? createdAt;

  HairChangerStatusResponse({
    required this.success,
    this.referenceId,
    this.status,
    this.resultImageUrl,
    this.originalImageUrl,
    this.errorMessage,
    this.processingTime,
    this.transformationType,
    this.colorDescription,
    this.hairstyleDescription,
    this.createdAt,
    this.error,
  });

  final String? error;

  factory HairChangerStatusResponse.fromJson(Map<String, dynamic> json) {
    return HairChangerStatusResponse(
      success: json['success'] ?? false,
      referenceId: json['referenceId'] ?? json['data']?['reference_id'],
      status: json['status'] ?? json['data']?['status'],
      resultImageUrl: json['resultImageUrl'] ?? json['data']?['result_image_url'],
      originalImageUrl: json['originalImageUrl'] ?? json['data']?['original_image_url'],
      errorMessage: json['error'] ?? json['data']?['error_message'],
      processingTime: json['processingTime'] ?? json['data']?['processing_time_ms'],
      transformationType: json['transformationType'] ?? json['data']?['transformation_type'],
      colorDescription: json['colorDescription'] ?? json['data']?['color_description'],
      hairstyleDescription: json['hairstyleDescription'] ?? json['data']?['hairstyle_description'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] ?? json['data']?['created_at'])
          : null,
      error: json['error'] ?? json['message'],
    );
  }
}