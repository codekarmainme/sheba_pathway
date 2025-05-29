import 'package:flutter/material.dart';
import 'package:sheba_pathway/widgets/history_container.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HistoryContainer(historyname: "Hotel | Afarencis Hotel",date: '11:00 PM, 12/11/2025',),
        HistoryContainer(historyname: 'Group Trip | Ras Dashen Mountain', date: '06:00 PM, 12/1/2024',),
        HistoryContainer(historyname: 'Solo Trip | Dire Dawa old metro', date: '04:00 PM, 3/5/2025',),


      ],
    );
  }
}
