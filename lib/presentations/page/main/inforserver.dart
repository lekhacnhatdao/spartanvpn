import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn/presentations/bloc/app_cubit.dart';
import 'package:openvpn/presentations/bloc/app_state.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class InforServer extends StatefulWidget {
  const InforServer({super.key});

  @override
  State<InforServer> createState() => _InforServerState();
}

class _InforServerState extends State<InforServer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Information server',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: state.titleStatus == 'Connected'
                        ? const Color(0xff0ae2a5)
                        : Colors.white,
                  ),
                  width: double.infinity,
                  child: Align(
                      child: Text(
                    "Server's ip address: ${state.currentServer?.ip}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ))),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width / 2,
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
                              labelStyle:
                                  const GaugeTextStyle(color: Colors.black),
                              startValue: 0,
                              endValue: state.titleStatus == 'Connected'
                                  ? double.parse(state.byteIn.split(' ').first)
                                  : 0,
                              color: const Color(0xff00D589),
                            )
                          ],
                          pointers: [
                            NeedlePointer(
                                 needleLength : 0.5,
                                 animationType: AnimationType.linear,
                                 needleStartWidth :1,
                                 needleEndWidth: 5,
                              value: state.titleStatus == 'Connected'
                                  ? double.parse(state.byteIn.split(' ').first)
                                  : 0,
                              enableAnimation: true,
                              needleColor: Colors.black.withOpacity(0.6),
                              tailStyle: const TailStyle(
                                  color: Colors.red,
                                  borderWidth: 0.1,
                                  borderColor: Colors.blue),
                              knobStyle: KnobStyle(
                                borderWidth: 0.1,
                                  color: Colors.blueAccent.withOpacity(0.6),
                                  borderColor: Colors.red),
                            ),
                          ],
                          annotations: [
                            GaugeAnnotation(
                              widget: Container(
                                child: Text(
                                  'Dowload' + ' ${state.byteIn}',
                                  style: const TextStyle(color: Colors.black,  fontWeight: FontWeight.w500),
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
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width / 2,
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
                              labelStyle:
                                  const GaugeTextStyle(color: Colors.black),
                              startValue: 0,
                              endValue: state.titleStatus == 'Connected'
                                  ? double.parse(state.byteOut.split(' ').first)
                                  : 0,
                              color: const Color(0xff00D589),
                            )
                          ],
                          pointers: [
                            NeedlePointer(
                              needleStartWidth :1,
                                 needleEndWidth: 5,
                              needleLength : 0.5,
                              value: state.titleStatus == 'Connected'
                                  ? double.parse(state.byteOut.split(' ').first)
                                  : 0,
                              enableAnimation: true,
                              needleColor: Colors.black.withOpacity(0.6),
                              tailStyle: const TailStyle(
                                  color: Colors.red,
                                  borderWidth: 0.1,
                                  borderColor: Colors.blue),
                              knobStyle: KnobStyle(
                                borderWidth: 0.1,
                                  color: Colors.blueAccent.withOpacity(0.6),
                                  borderColor: Colors.red),
                            ),
                          ],
                          annotations: [
                            GaugeAnnotation(
                              widget: Container(
                                child: Text(
                                  'Upload' + ' ${state.byteOut}',
                                  style: const TextStyle(color: Colors.black,   fontWeight: FontWeight.w500),
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
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: state.titleStatus == 'Connected'
                        ? const Color(0xff0ae2a5)
                        : Colors.white,
                  ),
                  width: double.infinity,
                  child: Align(
                      child: Text(
                    'Time connected: ${state.duration}',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  )))
            ],
          ),
        );
      },
    );
  }
}
