class HelpSupportTicket {
  String? ticketId;
  String? fullName;
  String? message;
  String? createdAt;
  String? response; // 👈 add this

  HelpSupportTicket({
    this.ticketId,
    this.fullName,
    this.message,
    this.createdAt,
    this.response,
  });

  HelpSupportTicket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    fullName = json['full_name'];
    message = json['message'];
    createdAt = json['created_at'];
    response = json['response']; // 👈 map response
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['full_name'] = fullName;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['response'] = response;
    return data;
  }
}
