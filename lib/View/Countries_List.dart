import 'package:covid_19_tracker/Services/States_Service.dart';
import 'package:covid_19_tracker/View/Details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries_List extends StatefulWidget {
  const Countries_List({super.key});

  @override
  State<Countries_List> createState() => _Countries_ListState();
}

class _Countries_ListState extends State<Countries_List> {

  var searchControlar=TextEditingController();

  @override
  Widget build(BuildContext context) {
    States_Service states_service=States_Service();
    return Scaffold(
      appBar: AppBar(
        // title: Text("Countries statement"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchControlar,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
            ),

            Expanded(
                child: FutureBuilder(
                    future: states_service.countriesListApi(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                      if(!snapshot.hasData){
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                              child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10, width: 10, color: Colors.white,),
                                  subtitle:Container(height: 10, width: 10, color: Colors.white,),
                                  leading: Container(height: 10, width: 10, color: Colors.white,),
                                )
                                ],
                              ),
                            );
                          },
                        );
                      }else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {

                            String name=snapshot.data![index]['country'];

                            if(searchControlar.text.isEmpty){

                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Details_Screen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'],

                                  ),));
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle:Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height:50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              );
                            }else
                              if(name.toLowerCase().contains(searchControlar.text.toLowerCase())){
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Details_Screen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],

                                    ),));
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle:Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                          height:50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag']
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                );
                            }else{
                                return Container(

                                );
                            }
                          },
                        );
                      }
                    },
                )
            )
          ],
        ),
      ),
    );
  }
}
