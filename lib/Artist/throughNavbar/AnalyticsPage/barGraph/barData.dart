import 'package:takhleekish/Artist/throughNavbar/AnalyticsPage/barGraph/bars.dart';

class BarData
{
  final double AbstractAmount;
  final double landscapeAmount;
  final double portraitAmount;
  final double StillLifeAmount;
  final double ModernArtAmount;
  final double ContemporaryAmount;

  BarData({required this.AbstractAmount,required this.landscapeAmount,
  required this.portraitAmount, required this.StillLifeAmount,
  required this.ModernArtAmount,required this.ContemporaryAmount});

  List<Bars> barData=[];

  void intializeBarData()
  {
    barData=[
    Bars(x: 0, y: AbstractAmount),
    Bars(x: 1, y: landscapeAmount),
    Bars(x: 2, y: portraitAmount),
    Bars(x: 3, y: StillLifeAmount),
    Bars(x: 4, y: ModernArtAmount),
    Bars(x: 5, y: ContemporaryAmount),
    ];
  }
}