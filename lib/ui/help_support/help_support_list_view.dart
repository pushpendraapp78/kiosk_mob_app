import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipbot_app/Constant/color_const.dart';
import 'package:ipbot_app/ui/widgets/header_txt_widget.dart';
import 'package:ipbot_app/ui/widgets/sub_txt_widget.dart';
import 'package:ipbot_app/ui/widgets/loading_widget.dart';
import '../widgets/app_bar_widget.dart';
import 'help_support_controller.dart';
import '../../model/help_support_ticket.dart';

class HelpSupportListPage extends StatelessWidget {
  final _con = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        height: 70,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            HeaderTxtWidget(
              "Help & Support Tickets",
              fontSize: 18,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (_con.isLoading.value) {
          return LoadingWidget(type: LoadingType.LIST);
        }

        if (_con.tickets.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(20),
            alignment: AlignmentDirectional.center,
            child: SubTxtWidget("No tickets found"),
          );
        }

        return RefreshIndicator(
          onRefresh: _con.fetchTickets,
          child: ListView.builder(
            itemCount: _con.tickets.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              HelpSupportTicket ticket = _con.tickets[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade50,
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.all(12),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Ticket ID Row + Notification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubTxtWidget(
                            "Ticket ID: ${ticket.ticketId ?? 'N/A'}",
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          Stack(
                            children: [

                              Icon(
                                Icons.notifications,
                                color: ticket.response == null
                                    ? Colors.grey.shade400
                                    : Colors.blue,
                                size: 24,
                              ),
                              if (ticket.response != null)
                                Positioned(
                                  right: -2,
                                  top: -3,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        ticket.message ?? 'No message provided',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubTxtWidget(
                            "By: ${ticket.fullName ?? 'Unknown'}",
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                          SubTxtWidget(
                            ticket.createdAt?.split("T")[0] ?? 'Unknown date',
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    if (ticket.response != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          ticket.response ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
