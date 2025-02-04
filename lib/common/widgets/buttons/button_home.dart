import 'package:bloc_clean_arch/common/widgets/buttons/widgets/custom_button.dart';
import 'package:bloc_clean_arch/core/theme/custom_styles/custom_button_theme.dart';
import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  const ButtonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'cancel',
                  onPressed: (){},
                  type: ButtonTypeEnums.outlined,
                  shape: ButtonShapeEnums.rounded,
                ),
                CustomButton(
                  text: 'Yes', 
                  onPressed: (){},
                  type: ButtonTypeEnums.primary,
                  shape: ButtonShapeEnums.rounded,
                ),
               
               
              ],
            )
            // CustomButton(
            //   text: 'Primary Button',
            //   onPressed: () {},
            //   type: ButtonType.elevated,
            //   color: ButtonColor.primary,
            // ),
            // CustomButton(
            //   text: 'Secondary Text Button',
            //   onPressed: () {},
            //   type: ButtonType.text,
            //   color: ButtonColor.secondary,
            // ),
            // CustomButton(
            //   text: 'Icon Button',
            //   onPressed: () {},
            //   type: ButtonType.icon,
            //   icon: Icons.add,
            //   color: ButtonColor.primary,
            // ),
            // CustomButton(
            //   text: 'Loading Button',
            //   onPressed: () {},
            //   type: ButtonType.iconText,
            //   icon: Icons.refresh,
            //   isLoading: true,
            // )
          ],
        ),
      ),
    );
  }
}
