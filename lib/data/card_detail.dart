class OrderInfo {
  const OrderInfo({
    required this.id,
    required this.date,
    required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
  final List<DeliveryProcess> deliveryProcesses;
}

class DeliveryProcess {
  const DeliveryProcess(
    this.name,
    this.details,
  );

  const DeliveryProcess.complete()
      : name = 'Status',
        details = "Active";

  final String name;
  final String details;
}

dataList(int id) => OrderInfo(
      id: id,
      date: DateTime.now(),
      deliveryProcesses: [
        const DeliveryProcess(
          'Card Type',
          'Value',
        ),
        const DeliveryProcess(
          'Insurance Fee',
          "5.00 USD",
        ),
        const DeliveryProcess(
          'Card Load Type',
          "Reloadble",
        ),
        const DeliveryProcess(
          'Load Fee',
          '2.00 USD + 2%',
        ),
        const DeliveryProcess(
          'Min Load',
          '5.00 USD',
        ),
        const DeliveryProcess(
          'Max Load',
          '1500.00 USD',
        ),
        const DeliveryProcess(
          'validity',
          '4 Years',
        ),
        const DeliveryProcess(
          'Monthly Fees',
          'N/O',
        ),
        const DeliveryProcess.complete(),
      ],
    );
