import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thrift_nep/constants/colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  var now = new DateTime.now();
  var toDate;
  var fromDate;
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    String checkinDate = formatter.format(now);
    fromDate = DateTime.now();
    toDate = now.add(Duration(days: 1));

    String uptoDate = formatter.format(toDate);
    final fromDateController = TextEditingController(text: "$checkinDate");
    final toDateController = TextEditingController(text: "$uptoDate");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        //automaticallyImplyLeading: false,
        title: Text(
          'Order history',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kAppbar,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [],
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From"),
                  Padding(padding: EdgeInsets.all(5.0)),
                  SizedBox(
                      width: 156,
                      child: InkWell(
                        child: TextField(
                          enabled: false,
                          controller: fromDateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon:
                                Icon(Icons.calendar_today_outlined, size: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          fromDate = date;
                          fromDateController.text =
                              date.toString().substring(0, 10);
                          toDateController.text = fromDate
                              .add(Duration(days: 1))
                              .toString()
                              .substring(0, 10);
                        },
                      )),
                ],
              ),
            ),
            //  Padding(padding: EdgeInsets.all(2.0)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" To"),
                  Padding(padding: EdgeInsets.all(5.0)),
                  SizedBox(
                      width: 158,
                      child: InkWell(
                        child: TextField(
                          enabled: false,
                          controller: toDateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: fromDate.add(Duration(days: 1)),
                              firstDate: fromDate.add(Duration(days: 1)),
                              lastDate: DateTime(2100));
                          print(date);
                          toDateController.text =
                              date.toString().substring(0, 10);
                          print(toDateController.text);
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
