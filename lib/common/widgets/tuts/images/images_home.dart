import 'package:bloc_clean_arch/common/widgets/tuts/images/components/asset_image.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/images/components/image_avatars.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/images/components/loading_n_error.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/images/components/network_image.dart';
import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 Image.network
  > - /.asset, /.file ... is a widget used to display an image
  > has an optional loadingBuilder and errorBuilder  params
  > directly display images without extra confirgurations

  NetworkImage
  > - AssetImage, FileImage, MemoryImage -
  > is an ImageProvider - provides an image without directly displaying it as a widget 
  > is an image provider widget used within other widgets such as CircleAvatar,
  DecorationImage in BoxDecoration, Image



 -- asset images
 Image.asset(
      'assets/images/techd.jpg',
      height: 400,
      width: 400,
    );

  -- network 
  Image.network(
      'https://picsum.photos/id/1074/400/400',
    );


  * by default images are not rendered in the specified dimensions using height and width
  as the image is not constrained to the dimensions unless the fit property is set
  fit - determines how image should be inscribed into the space
  > BoxFit.cover - ensure image fills the area while 
    * ignores the specified width unless wrapped with center widget


  * CircleAvatar crops the image - do not display the whole image
  > instead of using backgroundImage property use the child property to display ClipOval widget
  ClipOval - child as an Image widget


  ** simulate loading using loadingBuilder param
  loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child; //already loaded
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.white,
          ),
        );
      },
    
   ** error builder 
   errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: 200,
            width: 200,
            child: ColoredBox(
              color: Colors.grey[200]!,
              child: const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 200,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },

  //don't use shimmer on individual widgets for reused components e.g in listview
  instead use in the overall parent widget  for consistency, performance


 */
class ImagesHome extends StatelessWidget {
  const ImagesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          SizedBox(height: 10),
          Text('Loading Avatars'),
          LoadingNErrorImage(),

          SizedBox(height: 10),
          Text('Image Avatars'),
          ImageAvatars(),
          SizedBox(height: 10),
          Text('Network Image'),
          ImageNetwork(),

          SizedBox(height: 10),
          Text('Asset Image'),
          ImageAsset(),
          
          SizedBox(height: 10),
          Text('Load from gallery'),
          ImageAsset(),
          
        ],
      ),
    ));
  }
}
