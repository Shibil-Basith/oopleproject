import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  List<TimeOfDay> timeSlots = [    for (int i = 1; i <= 24; i++) TimeOfDay(hour: i, minute: 0)  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar with Time Slots"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text("Selected Date: ${DateFormat.yMMMMd().format(selectedDate)}"),
              Text("Selected Time: ${selectedTime?.format(context)}"),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text("Select Date"),
              ),
              Container(
                height: 450,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: timeSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                      children: [


                        GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = timeSlots[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedTime == timeSlots[index]
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          //height: 50,
                          width: 20,
                          alignment: Alignment.center,
                          child: Text((timeSlots[index].format(context).indexOf(':')==1)?(timeSlots[index].format(context).substring(0,1) ):timeSlots[index].format(context).substring(0,2)),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Submit the selected date and time here
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
