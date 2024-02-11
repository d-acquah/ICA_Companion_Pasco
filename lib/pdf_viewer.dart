import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/pages/download_page.dart';
import 'package:onepref/onepref.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PDFViewer extends StatefulWidget {
  final MonthYear monthYear;

  const PDFViewer({Key? key, required this.monthYear}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  IApEngine iApEngine = IApEngine();
  bool isLoading = false;
  bool _isLoaded = true;
  final BannerAd myBanner = BannerAd(
    size: AdSize.banner,
    adUnitId: Platform.isAndroid
        ? "ca-app-pub-2530239307985191/4923044950"
        : "ca-app-pub-2530239307985191/4273991819",
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {
        print('$BannerAd loaded.');
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('$BannerAd failedToLoad: $error');
      },
    ),
    request: AdRequest(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    restoreSub();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Make sure you have an internet connection'),
          duration: Duration(seconds: 3),
        ),
      );
    });
    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      if (list.isNotEmpty) {
         OnePref.setPremium(true);
        //restore the subscription
      } else {
        //do nothing or deactivate the subscription if the user is premium
        OnePref.setPremium(false);
      }
    });
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      // Replace the URL with the actual PDF URL
      final url = widget.monthYear.link;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Extract file name from the URL and capitalize the first letter of each word
        final uri = Uri.parse(url);
        final fileName = capitalizeWords(uri.pathSegments.last);

        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Navigate to PdfListScreen after successful download
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfListScreen(),
          ),
        );
      } else {
        // Show a snackbar for download failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download PDF'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show a snackbar for unexpected errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String capitalizeWords(String input) {
    final words = input.split('_');
    for (int i = 0; i < words.length; i++) {
      if (i > 0 && (words[i] == 'to' || words[i] == 'of')) {
        // Do not capitalize 'to' and 'of'
      } else {
        words[i] = capitalizeFirstLetter(words[i]);
      }
    }
    return words.join('_');
  }

  String capitalizeFirstLetter(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-2530239307985191/4612100836"
            : "ca-app-pub-2530239307985191/5454409211",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          if (_isLoaded && OnePref.getPremium() == false) {
            ad.show();
          }
        }, onAdFailedToLoad: (err) {
          debugPrint(err.message);

          // ignore: dead_code
          // Navigator.push(context,MaterialPageRoute(builder: (context){
          //                return NextPage();
        }));
    return SafeArea(
  child: Scaffold(
    appBar: AppBar(toolbarHeight:65,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        widget.monthYear.name,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.blue,
      actions: [ 
        IconButton(
          onPressed: () async {
            // Check the condition before deciding the action
            if (_isLoaded && OnePref.getPremium() == true) {
              try {
                setState(() {
                  isLoading = true; // Set loading to true when starting the download
                });

                await _downloadAndSavePdf();

                // Additional actions after successful download can be added here
              } catch (error) {
                print("Error during download: $error");
                // Handle download error if needed
              } finally {
                setState(() {
                  isLoading = false; // Set loading back to false when download is complete (whether success or failure)
                });
              }
            } else {
              showPersistentDialog(
                context,
                "The download feature is available to premium users only. Subscribe to the premium version to get access to download and view past questions offline.",
              );
            }
          },
          icon: const Icon(Icons.download),
          color: Colors.white,
        ),
      ],
    ),
    body: isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SfPdfViewer.network(widget.monthYear.link),
    bottomNavigationBar: Visibility(
      visible: _isLoaded && OnePref.getPremium() == false,
      child: _isLoaded
          ? Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: myBanner.size.height.toDouble(),
              child: AdWidget(ad: myBanner),
            )
          : Container(),
    ),
  ),
);

  }
  
  void showPersistentDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue, // Set background color
          title: Text(
            'Download Feature', textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, fontSize: 24,
              fontWeight: FontWeight.w600, // Set font weight
            ), // Set title text color
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ), // Set content text color
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white, fontSize: 20,
                  fontWeight: FontWeight.w600, // Set font weight
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void restoreSub()  {
    iApEngine.inAppPurchase.restorePurchases();
  }
}
