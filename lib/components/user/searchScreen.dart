//import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:oopleproject/backend/datamodels/venuedatamodel.dart';
import 'package:oopleproject/backend/venueList.dart';
import 'package:oopleproject/importedTheme.dart';

import '../../widgets/sports_field_list_ui.dart';

class SearchScreen extends StatefulWidget {

  //String selectedDropdownItem = "";
   //SearchScreen({super.key, required this.selectedDropdownItem});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {





  String? _selectedOption = 'all';
  List<String> _options = ['all','football', 'cricket',];









  String _query = "";
  List<venueDatamodel> _selectedListByCategory = [];
  String _selectedDropdownItem = "All";
  //final TextEditingController _controller = TextEditingController();


  Widget noMatchDataView() {
    return Column(
      children: [
        SizedBox(height: 60,),
        Image.asset(
          "assets/images/no_match_data_illustration.png",
          width: 200,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          "No Match Data.",
          style: titleTextStyle.copyWith(color: darkBlue300),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Sorry we couldn't find what you were looking for, \nplease try another keyword.",
          style: descTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }



  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: lightBlue100,
            borderRadius: BorderRadius.circular(borderRadiusSize)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: TextField(
            onChanged: (String value) {
              setState(() {
                _query = value;
              });
            },
            onSubmitted: (String value) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                      //title: const Text("Hello there :)"),
                      //content: const Text(
                          //'Sorry, the search feature is not implemented yet'),
                    );
                  });
            },
            controller: searchController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search by venue name, location, or sport category",
                suffixIcon: searchController.text.isEmpty
                    ? Container(
                  width: 0,
                )
                    : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: (){
                    searchController.clear();
                    _query = "";
                  },
                )),
          ),
        ),
      ),
    );
  }





  List<venueDatamodel> search(String query, List<venueDatamodel> searchFrom) {
    List<venueDatamodel> searchList = [];
    if (query.isEmpty) {
      return [];
    }
      return searchFrom.where((item) => item.venueName.toLowerCase().contains(query.toLowerCase()) || item.venueLocation.toLowerCase().contains(query.toLowerCase()) || item.venueCategory.toLowerCase().contains(query.toLowerCase())).toList();

  }



  // state variables
  TextEditingController searchController = TextEditingController();
  List<venueDatamodel> _results = [];
  List<venueDatamodel> _finalresults = [];

  @override
  void initState() {
    super.initState();


    searchController.addListener(() {
      // listen for changes to the search input
      // and update the search results
      setState(() {
        //List<venueDatamodel> searchFrom = [];
       // for(var i=0; i<venueList.length; i++) {
          //searchFrom.add(venueList[i]);

          _results = search(searchController.text, venueList);
          int resultLength = _results.length;
          _finalresults = [];
          log("searchresult size: $resultLength");
          if(_selectedOption == 'all'){
            _finalresults = _results;
          }


          else{
            for(var i=0; i<_results.length; i++){
              if(_results[i].venueCategory == _selectedOption){
                _finalresults.add(_results[i]);
              }
            }
          }

      });
    });
  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBlue100,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: primaryColor500,
            statusBarIconBrightness: Brightness.light),
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            width: width,
            padding:
            const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
            color: primaryColor500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_rounded),
                  color: colorWhite,
                ),
      DropdownButton(

        value: _selectedOption,
        iconEnabledColor: colorWhite,
        iconDisabledColor: darkBlue500,
        dropdownColor: Colors.blueAccent.shade400,
        style: normalTextStyle.copyWith(color: Colors.white),
        icon: const Icon(Icons.filter_alt),
        isDense: false,
        isExpanded: false,
        underline: const SizedBox(),
        alignment: Alignment.centerRight,
        items: _options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option[0].toUpperCase()+option.substring(1),style: TextStyle(
              //backgroundColor: backgroundColor,
              fontStyle: FontStyle.italic,

            ),),
            onTap: () {
              setState(() {
                //String tempQuery = _query;
                //searchController.text = _query + " ";
                //searchController.text = tempQuery;
              });
            },
          );
        }).toList(),
        onChanged: (String? newOption) {
          setState(() {
            _selectedOption = newOption;
            String tempQuery = _query;
            searchController.text = _query + " ";
            searchController.text = tempQuery;
          });
        },
      ),
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                  color: primaryColor500,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(borderRadiusSize))),
              child: Column(
                children: [
                  searchBar(),







                  Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                ],
              )),



          Padding(padding: EdgeInsets.symmetric(vertical: 6)),
    if(_finalresults.length<=0 && _query.isNotEmpty)
      noMatchDataView(),

    if(_finalresults.length>0)
    Expanded(

    child: ListView.builder(
    itemCount: _finalresults.length,
    itemBuilder: (context, index) {

      if(_finalresults[index].venueCategory == _selectedOption || _selectedOption == 'all'){
        return SportFieldList(field: _finalresults[index],);
      }
      else {
        return Container();
      }
    }

    ),),


          if(_query.isEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: venueList.length,
                  itemBuilder: (context, index) {
                    if(venueList[index].venueCategory == _selectedOption || _selectedOption == 'all'){
                      return SportFieldList(field: venueList[index],);
                    }
                    else
                      return Container();
                  }
              ),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

}


