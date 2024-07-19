import 'package:flutter/material.dart';
import 'package:flutter_covid_tracking_app/services/stats_services.dart';
import 'package:flutter_covid_tracking_app/view/detial_screen.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchController = TextEditingController();
  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding:const EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon:const Icon(Icons.search_sharp),
                  hintText: 'Search with country name',
                  //hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statsServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(height: 50, width: 50, color: Colors.white,),
                                    title: Container(height: 15, width: 89, color: Colors.white,),
                                    subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){

                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>DetailScreen(

                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalCases: snapshot.data![index]['cases'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            test: snapshot.data![index]['tests'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            todayDeaths: snapshot.data![index]['todayDeaths'],
                                            critical: snapshot.data![index]['critical'],

                                          ),                                          )
                                      );
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  )
                                ],
                              );
                            }

                            else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>DetailScreen(

                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalCases: snapshot.data![index]['cases'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            test: snapshot.data![index]['tests'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            todayDeaths: snapshot.data![index]['todayDeaths'],
                                            critical: snapshot.data![index]['critical'],

                                          ),                                          )
                                      );
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  )
                                ],
                              );
                            }else{
                              return Container();
                            }

                          }
                      );
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
