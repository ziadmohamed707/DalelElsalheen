import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryadelsalehen/Screens/elSabrr.dart';
import 'package:ryadelsalehen/Screens/elTawbaa.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Widgets/TextButton.dart';
import 'chapters.dart';

class HomePage extends StatefulWidget {
  String id = 'HomePage';
  HomePage();


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  OverlayEntry? _overlayEntry;
  int _selectedIndex = 0-1;

  late TextEditingController textController;

  double boxsize = 1.0;

  double boxsizeheader = 35;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    textController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 75,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: TextButton(
          onPressed: () {
            Clipboard.setData(
                ClipboardData(text: details.selectedText.toString()));
            print('Text copied to clipboardssssssssssss: ' +
                details.selectedText.toString());
            _pdfViewerController.clearSelection();
            setState(() {});
          },
          child: Text('Copy',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pdfViewerController.jumpToPage(getPageNumbers(index));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(
              'دليل الصالحين',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: Drawer(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 10, top: 0, right: 10),
              itemCount: getChapterNumbers(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: ListTile(
                    title: Text(
                      '${index + 1} - ' +
                          '${getChapterName()[index].toString()}',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    selected: _selectedIndex == index,
                    onTap: () {
                      // Update the state of the app
                      _onItemTapped(index);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            ),
          ),
        ),
        body: SfPdfViewer.asset(
          'images/${_selectedIndex + 1}.pdf',
          //key: _pdfViewerKey,
          enableTextSelection: true,
          currentSearchTextHighlightColor: Colors.blue.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.blue.withOpacity(0.3),
          onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
            if (details.selectedText == null && _overlayEntry != null) {
              _overlayEntry!.remove();
              _overlayEntry = null;
            } else if (details.selectedText != null && _overlayEntry == null) {
              _showContextMenu(context, details);
            }
          },
          controller: _pdfViewerController,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // openDialog();

            // int customerPageSelected = openDialog();

            // if(customerPageSelected == null )
            //   return;
            //
            // setState(() {
            //   // this.customerPageselected = customerPageSelected;
            // });

            // _pdfViewerController.jumpToPage(customerPageSelected);

            // search method

            var TextSearchOption;
            _searchResult = _pdfViewerController.searchText('الصالحين',
                searchOption: TextSearchOption);
            _searchResult.addListener((){
              if (_searchResult.hasResult) {
                setState(() {});
              }
            });
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.search),
        ),
      ),
    );
  }

  int getCustomerPageNumber(int pageNumber) {
    int customerPgaeNumber = pageNumber;

    return customerPgaeNumber;
  }

  int openDialog() {
    var pageNumber;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Page Number'),
        content: TextField(
          onChanged: (data){
            pageNumber = data;
          },
          keyboardType: TextInputType.number,

          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter Here your Page Number',

          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: (){


              submit();
            }),
        ],
      ),
    );
    return pageNumber!;
  }

  void submit() {
    Navigator.of(context).pop(textController.text);
  }
}