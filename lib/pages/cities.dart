import 'package:teleport_weather_bhargav/blocs/Cities/cities_bloc.dart';
import 'package:teleport_weather_bhargav/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  late CitiesBloc _bloc;
  List<String> cities=[];
  late String selectedCity;
  @override
  void initState() {
    super.initState();
    _bloc=BlocProvider.of<CitiesBloc>(context);

    cities=["Kuala Lumpur","Klang","Ipoh","Butterworth","George Town","Petaling Jaya","Kuantan","Shah Alam",
      "Johor Bahru","Kota Bharu","Melaka","Kota Kinabalu","Seremban","Sandakan","Sungai Petani","Kuching",
      "Kuala Terengganu","Alor Setar","Putrajaya","Kangar","Labuan","Pasir Mas","Tumpat","Ketereh","Kampung Lemal","Pulai Chondong"];

    selectedCity=cities[0];
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CitiesBloc, CitiesState>(
      listener: (context, state) {

      },
      child: BlocBuilder<CitiesBloc, CitiesState>(
          bloc: _bloc,
          builder: (BuildContext context, CitiesState state) {
            return ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: [
                Text("Cities")
              ],
            );
          }
      ),
    );
  }
}