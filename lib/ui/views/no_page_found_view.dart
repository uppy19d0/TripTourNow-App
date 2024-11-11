import 'package:flutter/material.dart';

import '../../class/language_constants.dart';


class NoPageFoundView extends StatefulWidget {
  final int? index;
  const NoPageFoundView({Key? key , this.index}) : super(key: key);

  @override
  State<NoPageFoundView> createState() => _NoPageFoundViewState();
}

class _NoPageFoundViewState extends State<NoPageFoundView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index != null) WidgetsBinding.instance.addPostFrameCallback((_) => changePage(widget.index!));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: Text(
          translation(context).page_not_found,

        ),
      ),
    );
  }

  void changePage(int index){

    // if(index == 2){
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     NavigationService.navigateTo('/dashboard/companys');
    //   });
    // }else{
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     NavigationService.navigateTo('/dashboard');
    //   });
    // }
  }


}

