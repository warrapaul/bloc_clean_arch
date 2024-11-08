import 'package:bloc_clean_arch/common/widgets/shimmer/components/shimmer_package_item.dart';
import 'package:bloc_clean_arch/common/widgets/shimmer/components/simple_shimmer.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHome extends StatelessWidget {
  const ShimmerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              const Text('Basic Shimmer'),
              const SimpleShimmer(
                width: 200,
                height: 50,
              ),
          
              const SizedBox(height: 5),
              const Text('Card with multiple Basic shimmers'),
              const SizedBox(height: 10),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title shimmer
                      SimpleShimmer(
                        width: 200,
                        height: 20,
                      ),
                      SizedBox(height: 16),
                      // Content shimmer
                      SimpleShimmer(
                        width: double.infinity,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
          
               const SizedBox(height: 5),
              const Text('List of Basic shimmers'),
              const SizedBox(height: 10),
              Container( 
                height: 200,
                child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: SimpleShimmer(
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 5),
              const Text('Package shimmer'),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text('text with shimmer'),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                // baseColor: Colors.red,
                //           highlightColor: Colors.yellow,
                child: const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              Container(
                height: 400,
                child:  ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const ShimmerPackageItem(),
              ),
            
              )
              // ShimmerBasic(),
              // ShimmerPackage(),
            ],
          ),
        ),
      ),
    );
  }
}
