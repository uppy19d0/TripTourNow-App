class CardInfoDetails {
  const CardInfoDetails({
    required this.cardTimelineData,
  });

  final List<CardTimelineData> cardTimelineData;
}

class CardTimelineData {
  const CardTimelineData(
    this.name,
    this.details,
  );

  final String name;
  final String details;
}

dataList(int id) => const CardInfoDetails(
      cardTimelineData: [
        CardTimelineData(
          'Category',
          'Google Play',
        ),
        CardTimelineData(
          'Sub Category',
          "Google Play 60",
        ),
        CardTimelineData(
          'Price',
          "100.00 USD",
        ),
        CardTimelineData(
          'Available',
          '5 cards',
        ),
      ],
    );
