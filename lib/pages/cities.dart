import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late TextEditingController _newCityController;
  String? addCityError;
  @override
  void initState() {
    super.initState();
    _bloc=BlocProvider.of<CitiesBloc>(context);
    _bloc.add(GetCitiesEvent());
    _newCityController=TextEditingController();
  }
  @override
  void dispose() {
    _newCityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 20),
          child: Text("My Cities",
            style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            padding: EdgeInsets.all(10),
            child: BlocListener<CitiesBloc, CitiesState>(
              listener: (context, state) {

                if(state is DisplayCitiesState){
                  cities=state.cities;
                }else if(state is ShowAddCityUIState){
                  showAddCityDialog();
                }else if(state is ShowAddingCityState){
                  showProcessingAlert();
                }else if(state is CloseProcessingState){
                  Navigator.of(context).pop(true);
                }else if(state is CityAlreadyExistsState){
                  addCityError="This City already added. Please try another city.";
                  showAddCityDialog();
                }else if(state is SuccessCityAddedState){
                  showSuccessAlert();
                }else if(state is ErrorCityAddingState){
                  showInSnackBar("Error adding city. Please try again later.");
                }
              },
              child: BlocBuilder<CitiesBloc, CitiesState>(
                  bloc: _bloc,
                  builder: (BuildContext context, CitiesState state) {
                    if(state is CitiesInitial){
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }


                    return cities.length==0?Container():Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.separated(
                        itemCount: cities.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: 100),
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 0.1,
                            color: Theme.of(context).colorScheme.iconsColor,
                            margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          );
                        },
                        itemBuilder:(BuildContext context, int index){
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(),
                                constraints: BoxConstraints(
                                    minWidth: 50,
                                    maxHeight: 48,
                                    maxWidth: 200
                                ),
                                padding:EdgeInsets.all(8),
                                child: Text("${cities[index]}",
                                  style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
              ),
            ),
          ),
        )
      ],
    );
  }

  showAddCityDialog() {
    var screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 328.0 * (screenWidth/360),
              padding: EdgeInsets.only(top: 10, right: 15, bottom: 30, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 328.0 * (screenWidth/360),
                    padding: EdgeInsets.only(right: 16*(screenWidth/360),bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add New City to the list",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                    child: TextField(
                      controller: _newCityController,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),],
                      decoration: InputDecoration(
                        hintText: "Enter City Name",
                        hintStyle:TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.iconsColor),
                        alignLabelWithHint: true,
                        labelText: "City Name",
                        labelStyle: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.iconsColor),
                        errorText: addCityError,
                        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.iconsColor, width: 1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.iconsColor, width: 1)),
                      )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).colorScheme.iconsColor
                          ),
                          child: Center(
                            child: Text("CANCEL",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),
                            ),
                          ),
                        ),
                        onTap: (){
                          addCityError=null;
                          _newCityController.clear();
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).primaryColor
                          ),
                          child: Center(
                            child: Text("SUBMIT",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),
                            ),
                          ),
                        ),
                        onTap: (){
                          if(_newCityController.text.trim().length>0){
                            Navigator.pop(context);
                            _bloc.add(AddCityEvent(_newCityController.text));
                          }
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
          );
        });
  }
  showSuccessAlert() {
    addCityError=null;
    _newCityController.clear();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            _bloc.add(GetCitiesEvent());
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              padding:
              EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: FlareActor(
                      "assets/animations/Success.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      isPaused: false,
                      animation: "success",
                    ),
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "City Added Successfully.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          );
        });
  }

  showProcessingAlert() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Future.delayed(Duration(seconds: 5), () {
          //   Navigator.of(context).pop(true);
          // });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              padding:
              EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child:  FlareActor(
                      "assets/animations/progress.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      isPaused: false,
                      animation: "CustomProgress",
                    ),
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "Processing data. Please wait.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          );
        });
  }
  void showInSnackBar(String value,{int duration=3}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text('$value'),
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}