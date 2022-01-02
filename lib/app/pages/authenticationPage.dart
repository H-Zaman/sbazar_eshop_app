import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sbazar/app/pages/home_page.dart';
import 'package:sbazar/others/resources/colors.dart';
import 'package:sbazar/others/resources/fonts.dart';
import 'package:sbazar/others/resources/images.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final PanelController _panelController = PanelController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            // imageUrl: 'https://images.unsplash.com/photo-1537130508986-20f4fd870b4e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=688&q=80',
            imageUrl: 'https://images.unsplash.com/photo-1429991889170-afd56b2a1210?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SlidingUpPanel(
              controller: _panelController,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity,height: 32,),
                  Image.asset(
                    Images.LOGO,
                    width: 60,
                    height: 60,
                  ),
                  Text(
                    'Welcome to S-Bazar',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: CFontFamily.BOLD,
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'A app slogan or something to simply describe the app for customers',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                ],
              ).paddingAll(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              minHeight: 55,
              maxHeight: Get.height * .275,
              defaultPanelState: PanelState.CLOSED,
              collapsed: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  Future.delayed(Duration(seconds: 1),(){
                    Get.to(()=>HomePage());
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColor.GREEN,
                    fixedSize: Size(double.infinity, 55),
                    maximumSize: Size(double.infinity, 55),
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ))
                ),
                child: loading ? SizedBox(
                  child: SpinKitPianoWave(color: Colors.white),
                  height: 12,
                ) : Text(
                  'Continue',
                  style: TextStyle(
                      fontFamily: CFontFamily.BOLD,
                      fontSize: 18
                  ),
                ),
              ),
              panel: _Panel()
            ),
          ),
        ),
      ],
    );
  }
}


// class _Header extends StatelessWidget {
//   final PanelController panelController;
//   const _Header({required this.panelController});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           loading = true;
//         });
//         Future.delayed(Duration(seconds: 2),(){
//           Get.to(()=>HomePage());
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         primary: AppColor.GREEN,
//         fixedSize: Size(double.infinity, 55),
//         maximumSize: Size(double.infinity, 55),
//         minimumSize: Size(double.infinity, 55),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ))
//       ),
//       child: Text(
//         'Continue',
//         style: TextStyle(
//             fontFamily: CFontFamily.BOLD,
//             fontSize: 18
//         ),
//       ),
//     );
//   }
// }

class _Panel extends StatefulWidget {
  @override
  State<_Panel> createState() => _PanelState();
}

class _PanelState extends State<_Panel> {

  final _formKey = GlobalKey<FormState>();

  final _numberController = TextEditingController();
  final _pinController = TextEditingController();

  bool validatePin = false;
  bool loading = false;
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              validatePin ? 'Confirm OTP' : 'Please login/ register',
              style: TextStyle(
                fontSize: 18,
              ),
            ).paddingOnly(left: 2),


            validatePin ? PinCodeTextField(
              length: 6,
              appContext: context,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                disabledColor: Colors.white,
                inactiveColor: Colors.grey
              ),
              animationDuration: Duration(milliseconds: 300),
              // backgroundColor: Colors.blue.shade50,
              // enableActiveFill: true,
              errorAnimationController: errorController,
              controller: _pinController,
              onCompleted: (v) {
                FocusScope.of(context).unfocus();
                setState(() {
                  loading = true;
                });
                Future.delayed(Duration(seconds: 2),(){
                  Get.to(()=>HomePage());
                });
              },
              onChanged: (value) {

              },
              beforeTextPaste: (text) {

                return true;
              },
            ) : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.GREEN,
                  width: 2
                )
              ),
              child: TextFormField(
                controller: _numberController,
                validator: (vale){
                  if(vale == null || vale.trim().length < 1) return 'Please enter a valid number';
                  if(vale.length < 11){
                    return 'Please enter at-least 11 digits';
                  }else{
                    return null;
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Please enter mobile number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12)
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                Future.delayed(Duration(seconds: 2),(){
                  Get.to(()=>HomePage());
                });
                // if(validatePin){
                //   setState(() {
                //     loading = true;
                //   });
                //   Future.delayed(Duration(seconds: 2),(){
                //     Get.to(()=>HomePage());
                //   });
                // }else{
                //   setState(() {
                //     validatePin = true;
                //   });
                // }
              },
              style: ElevatedButton.styleFrom(
                primary: AppColor.GREEN,
                fixedSize: Size(double.infinity, 45),
                maximumSize: Size(double.infinity, 45),
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
              ),
              child: loading ? SizedBox(
                child: SpinKitPianoWave(color: Colors.white),
                height: 12,
              ) : Text(
                'Continue',
                style: TextStyle(
                  fontFamily: CFontFamily.BOLD,
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
