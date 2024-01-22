import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:openvpn/presentations/widget/impl/showdialog.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Speedtestpage extends StatefulWidget {
  const Speedtestpage({super.key});

  @override
  State<Speedtestpage> createState() => _SpeedtestpageState();
}

class _SpeedtestpageState extends State<Speedtestpage> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();
  bool? started;
  bool _testInProgress = false;
  double rate = 0;
  double _downloadRate = 0;

  double _uploadRate = 0;
  String _downloadProgress = '0';
  String _uploadProgress = '0';
  int _downloadCompletionTime = 0;
  int _uploadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String? _ip;
  String? _asn;
  String? _isp;

  String _unitText = 'Mbps';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Test Your Internet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          body: Column(children: [
            Container(
              child: SfRadialGauge(
                axes: [
                  RadialAxis(
                    radiusFactor: 0.85,
                    minorTicksPerInterval: 1,
                    tickOffset: 3,
                    useRangeColorForAxis: true,
                    minimum: 0,
                    maximum: 100,
                    interval: 20,
                    showLastLabel: true,
                    axisLabelStyle: const GaugeTextStyle(
                      color: Colors.black,
                    ),
                    axisLineStyle: AxisLineStyle(
                      color: Colors.blueAccent..withOpacity(0.5),
                    ),
                    ranges: [
                      GaugeRange(
                        labelStyle: const GaugeTextStyle(color: Colors.black),
                        startValue: 0,
                        endValue: state.titleStatus == 'Connected' ? 0 : rate,
                        color: const Color(0xff00D589),
                      )
                    ],
                    pointers: [
                      NeedlePointer(
                        needleLength: 0.55,
                        needleStartWidth: 2,
                        value: rate,
                        enableAnimation: true,
                        needleColor: Colors.black.withOpacity(0.6),
                        tailStyle: const TailStyle(
                            color: Colors.red,
                            borderWidth: 0.1,
                            borderColor: Colors.blue),
                        knobStyle: const KnobStyle(
                            color: Colors.blue,
                            borderWidth: 0.1,
                            borderColor: Colors.red),
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            'Testing ' +
                                '${started == null ? '' : started ?? false ? 'Upload' : 'Download'}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 1,
                      )
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: state.titleStatus == 'Connected'
                  ? () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext) => const ShowDialogPage());
                    }
                  : () async {
                      // if (state.titleStatus != 'Connected' || state.titleStatus =='Not connected') {
                      reset();
                      await internetSpeedTest.startTesting(onStarted: () {
                        setState(() => _testInProgress = true);
                      }, onCompleted: (TestResult download, TestResult upload) {
                        if (kDebugMode) {
                          print(
                              'the transfer rate ${download.transferRate}, ${upload.transferRate}');
                        }
                        setState(() {
                          _downloadRate = download.transferRate;
                          _unitText =
                              download.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _downloadProgress = '100';
                          _downloadCompletionTime = download.durationInMillis;
                          started = false;
                        });
                        setState(() {
                          _uploadRate = upload.transferRate;
                          _unitText =
                              upload.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _uploadProgress = '100';
                          _uploadCompletionTime = upload.durationInMillis;
                          _testInProgress = false;
                          started = true;
                        });
                      }, onProgress: (double percent, TestResult data) {
                        if (kDebugMode) {
                          print(
                              'the transfer rate $data.transferRate, the percent $percent');
                        }
                        setState(() {
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          if (data.type == TestType.download) {
                            _downloadRate = data.transferRate;
                            started = false;

                            rate = _downloadRate;
                            _downloadProgress = percent.toStringAsFixed(2);
                          } else {
                            _uploadRate = data.transferRate;
                            started = true;

                            rate = _uploadRate;
                            _uploadProgress = percent.toStringAsFixed(2);
                          }
                        });
                      }, onError: (String errorMessage, String speedTestError) {
                        if (kDebugMode) {
                          showDialog(
                              context: context,
                              builder: (BuildContext) => alert());
                          print(
                              'the errorMessage $errorMessage, the speedTestError $speedTestError');
                        }

                        reset();
                      }, onDefaultServerSelectionInProgress: () {
                        setState(() {
                          _isServerSelectionInProgress = true;
                        });
                      }, onDefaultServerSelectionDone: (Client? client) {
                        setState(() {
                          _isServerSelectionInProgress = false;
                          _ip = client?.ip;
                          _asn = client?.asn;
                          _isp = client?.isp;
                        });
                      }, onDownloadComplete: (TestResult data) {
                        setState(() {
                          _downloadRate = data.transferRate;
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _downloadCompletionTime = data.durationInMillis;
                        });
                      }, onUploadComplete: (TestResult data) {
                        setState(() {
                          _uploadRate = data.transferRate;
                          _unitText =
                              data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                          _uploadCompletionTime = data.durationInMillis;
                        });
                      }, onCancel: () {
                        reset();
                      });
                      // };
                    },
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 125),
                  decoration: const BoxDecoration(
                      color: Color(0xff00D589),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Align(
                    child: _testInProgress
                        ? GestureDetector(
                            onTap: () => internetSpeedTest.cancelTest(),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cancel_rounded,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Cancel'),
                              ],
                            ))
                        : const Text(
                            'Starting test',
                            style: TextStyle(color: AppColors.primary),
                          ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(children: [
                      const Text('Download: '),
                      const Spacer(),
                      Text(
                        ' ${_downloadRate} MB/S',
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Upload: '),
                        const Spacer(),
                        Text(' ${_uploadRate} MB/S')
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        );
      },
    );
  }

  Widget alert() {
    return Container(
      
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 2.5,
          horizontal: MediaQuery.of(context).size.width / 6),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(  children:  [
        AppBar(leading: TextButton(onPressed: (){
          Navigator.pop(context);
        },child: Icon(Icons.clear_outlined, color: Colors.black,),),),
        const Align(
            child: Text(
          "Sorry, I'm having trouble and I hope you can debug it again ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ))
      ]),
    );
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;
        _uploadRate = 0;
        _downloadProgress = '0';
        _uploadProgress = '0';
        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
        _uploadCompletionTime = 0;

        _ip = null;
        _asn = null;
        _isp = null;
      }
    });
  }
}
