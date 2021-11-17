import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OverlayClass extends StatefulWidget {
  final ValueSetter<int> typeindex;
  final ValueSetter<int> filterindex;
  final ValueSetter<int> orderindex;
  final int selectedFilter;
  final int selectedOrder;
  final int selectedType;

  OverlayClass(
      {required this.typeindex,
      required this.filterindex,
      required this.orderindex,
      required this.selectedFilter,
      required this.selectedOrder,
      required this.selectedType});

  @override
  _OverlayClassState createState() => _OverlayClassState();
}

class _OverlayClassState extends State<OverlayClass> {
  late Size buttonSize;
  late Offset buttonPosition;
  late double screenWidth;
  int selectedFilter = 0;
  int selectedOrder = 0;
  int selectedType = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter;
    selectedType = widget.selectedType;
    selectedOrder = widget.selectedOrder;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> filterEntry = <String>[
      'Name',
      'Last Modified',
      'Last Opend',
      'File type'
    ];
    final List<String> orderEntry = <String>['Ascending', 'Descending'];
    final List<String> typeEntry = <String>['List', 'Grid'];

    return Stack(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                width: 320,
                height: 460,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F6FB),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                        child: Text(
                          'Sort by: ',
                          style: TextStyle(
                              color: Color(0xFF6774A6),
                              fontSize: 21.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFB8BFD7))),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: filterEntry.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.infinity,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = index;
                                      widget.filterindex(this.selectedFilter);
                                    });
                                  },
                                  title: Text(
                                    '${filterEntry[index]}',
                                    style: TextStyle(
                                        color: selectedFilter == index
                                            ? Color(0xFF6774A6)
                                            : Color(0xFFB8BFD7),
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFB8BFD7))),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: orderEntry.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.infinity,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  onTap: () {
                                    setState(() {
                                      selectedOrder = index;
                                      widget.orderindex(this.selectedOrder);
                                    });
                                  },
                                  title: Text(
                                    '${orderEntry[index]}',
                                    style: TextStyle(
                                        color: selectedOrder == index
                                            ? Color(0xFF6774A6)
                                            : Color(0xFFB8BFD7),
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: typeEntry.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.infinity,
                              height: 50,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  onTap: () {
                                    setState(() {
                                      selectedType = index;
                                      widget.typeindex(this.selectedType);
                                    });
                                  },
                                  title: Text(
                                    '${typeEntry[index]}',
                                    style: TextStyle(
                                        color: selectedType == index
                                            ? Color(0xFF6774A6)
                                            : Color(0xFFB8BFD7),
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
