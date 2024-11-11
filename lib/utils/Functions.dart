String mask(int value, int length, [String prefix = '0']){
  final str = "0$value";
  return str.substring(str.length - length);
}

String formatTime(DateTime date){
  final h = date.hour;
  final m = mask(date.minute, 2);
  final z = h >= 12 ? 'pm' : 'am';

  int nh = h % 12;
  if(nh == 0) nh = 12;
  
  return "$nh:$m $z";
}