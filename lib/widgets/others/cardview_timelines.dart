import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';
import '../../data/cardview_timelines_data.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        final data = dataList(index + 1);
        return Center(
          child: _CardViewTimelieswidget(
            cardTimelineData: data.cardTimelineData,
          ),
        );
      },
    );
  }
}

class _CardViewTimelieswidget extends StatelessWidget {
  const _CardViewTimelieswidget({Key? key, required this.cardTimelineData})
      : super(key: key);

  final List<CardTimelineData> cardTimelineData;
  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        indicatorTheme: const IndicatorThemeData(
          position: 0,
          color: CustomColor.whiteColor,
          size: 0.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: cardTimelineData.length,
        contentsBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.marginSize * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.defaultPaddingSize * 0.3),
                      child: Text(
                        cardTimelineData[index].name,
                        style: GoogleFonts.inter(
                          color: CustomColor.primaryColor,
                          fontSize: Dimensions.mediumTextSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.defaultPaddingSize * 0.3),
                      child: Text(
                        cardTimelineData[index].details,
                        style: GoogleFonts.inter(
                          color: CustomColor.primaryColor,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(Dimensions.heightSize * 1)
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: CustomColor.primaryColor.withOpacity(0.5), width: 6),
              shape: BoxShape.circle,
            ),
          );
        },
        connectorBuilder: (_, index, ___) => const DashedLineConnector(),
      ),
    );
  }
}
