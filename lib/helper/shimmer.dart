import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_kstylehub_bayuh/helper/utility.dart';
import 'package:test_kstylehub_bayuh/widgets/widget.dart';

class ShimmerWidget {
  static shimmerOnWeather(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade300,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Utility.extraLarge,
              ),
              const SizedBox(
                width: 100,
                height: 30,
                child: Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              const SizedBox(
                width: 200,
                height: 30,
                child: Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              const SizedBox(
                width: 100,
                height: 30,
                child: Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              const SizedBox(
                width: 150,
                height: 30,
                child: Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              const ExpandedView2Row(
                  flexLeft: 50,
                  flexRight: 50,
                  widgetLeft: Card(child: ListTile(title: Text(''))),
                  widgetRight: Card(child: ListTile(title: Text('')))),
              SizedBox(
                height: Utility.extraLarge,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 30,
                        child: Card(child: ListTile(title: Text('')))),
                  ),
                  Expanded(
                    child: SizedBox(
                        height: 30,
                        child: Card(child: ListTile(title: Text('')))),
                  ),
                  Expanded(
                    child: SizedBox(
                        height: 30,
                        child: Card(child: ListTile(title: Text('')))),
                  )
                ],
              ),
              SizedBox(
                height: Utility.medium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: const Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: const Card(child: ListTile(title: Text(''))),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: const Card(child: ListTile(title: Text(''))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
