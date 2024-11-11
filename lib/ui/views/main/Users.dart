import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/views/main/UserDetails.dart';


import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../data/drawer_data/save_receipient_data.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/drawer_widget/save_receipient_widget.dart';

class SavereceipientScreen extends StatefulWidget {
  const SavereceipientScreen({Key? key}) : super(key: key);

  @override
  State<SavereceipientScreen> createState() => _SavereceipientScreenState();
}

class _SavereceipientScreenState extends State<SavereceipientScreen> {
  List<User> usuarios = [];
  bool isloading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/admin/users').then((value) {

      //convert value to json
      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        User user = User.fromJson(data[i]);
       usuarios.add(user);//
      }
      setState(() {
        isloading = false;
      });
    }).catchError((error) {
      print(error);
      print(error.data);
    });
  }
  List<User> _filterUsers(String query) {
    return usuarios.where((user) {
      final fullName = '${user.firstName} ${user.lastname}'.toLowerCase();
      final email = user.email.toLowerCase();
      final phone = user.phone.toLowerCase();
      return fullName.contains(query.toLowerCase()) ||
          email.contains(query.toLowerCase()) ||
          phone.contains(query.toLowerCase());
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).users_text),

        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>  {
            NavigationService.replaceRemoveTo(Flurorouter.administracionRoute)
          }
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(


                context: context,
                delegate:CustomSearchDelegate(usuarios),

              );
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: (!isloading)?_bodyWidget(context): Container(color  :backgroundcolor,width:double.infinity,height: double.infinity,child:Center(child: CircularProgressIndicator(
        color:goldcolor,
      ))),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      color: backgroundcolor,
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.defaultPaddingSize * 0.4,
        horizontal: Dimensions.defaultPaddingSize * 0.6,
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: usuarios.length,
              itemBuilder: ((context, index) {
                final usuario = usuarios[index];
                return GestureDetector(
                    onTap: () {
                      final user = usuarios[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  UserDetailsPage( user: usuario,)),
                      );
                    },
                    child:Container(
                        color: Colors.black,
                        //margin bottom 20
                        margin: EdgeInsets.only(bottom: 20),
                        //padding vertical 10
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:ListTile(


                      title:
                      Row(children:[
                       //SvgPicture.asset('assets/icons/micuenta-perfil.svg',
                        //                         color: goldcolor, semanticsLabel: 'Label'),
                        //set svg above as leading
                        Container(
                          width: 50,
                          height: 50,
                          child: SvgPicture.asset('assets/icons/micuenta-perfil.svg',
                              color: goldcolor, semanticsLabel: 'Label'),
                        ),
                        SizedBox(width: 10,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(usuarios[index].firstName+ ' ' + usuarios[index].lastname, style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5,),
                        Text(usuarios[index].email, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w100)),],),
                        ),

                ]),
                      //trailing arrow right Icon

                //leading assets / default user image

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 5,),
                          Text(usuarios[index].phone, style: TextStyle(color: Colors.white)),
                          //label status: + usuarios[index].status,
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(translation(context).email_verification_text + ': ', style: TextStyle(color: Colors.white)),
                              if(usuarios[index].email_verified == true)
                                Text(translation(context).verified_text, style: TextStyle(color: Colors.green)),
                              if(usuarios[index].email_verified == false)
                                Text(translation(context).unverified_text, style: TextStyle(color: Colors.yellow)),

                            ],
                          ),
                          SizedBox(height: 5,),
                          //verificacion de identidad
                          Row(
                            children: [
                              Text(translation(context).identity_verification_text + ': ', style: TextStyle(color: Colors.white)),
                              if(usuarios[index].verificationStatus == 'unverified')
                                Text(translation(context).unverified_text, style: TextStyle(color: Colors.red)),
                              if(usuarios[index].verificationStatus == 'pending')
                                Text(translation(context).pending_text, style: TextStyle(color: Colors.yellow)),
                              if(usuarios[index].verificationStatus == 'verified')
                                Text(translation(context).verified_text, style: TextStyle(color: Colors.green)),
                            ],
                          ),

                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    )
                    ));
              }),
            ),
          ),
        ],
      ),
    );
  }

}
class CustomSearchDelegate extends SearchDelegate {
  List<String> SearchTerms = [];
  //list usuarios with same index of SearchTerms
  List<User> usuarios = [];


  CustomSearchDelegate(List<User> users) {
    SearchTerms = users.map((user) => '${user.firstName} ${user.lastname}').toList();
    usuarios = users;
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: (){
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String>  matchquery = [];
    for (var user in SearchTerms){
      if (user.contains(query)){
        matchquery.add(user);
      }
    }
    return
      Container(
        color:backgroundcolor,
        child:ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(matchquery[index], style: TextStyle(color: white),),
          onTap: (){
            close(context, matchquery[index]);
          },
        );
      },
    ));


  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String>  matchquery = [];
    for (var user in SearchTerms){
      if (user.contains(query)){
        matchquery.add(user);
      }
    }
    return
      Container(
      color:backgroundcolor,
      child:
      ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(matchquery[index], style: TextStyle(color: white),),
          onTap: (){
            close(context, matchquery[index]);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDetailsPage(user: usuarios[index],)),
            );
          },
        );
      },
    )
      );

  }
  

}


