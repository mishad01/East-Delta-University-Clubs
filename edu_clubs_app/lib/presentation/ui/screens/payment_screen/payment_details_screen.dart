import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({
    super.key,
    required this.image,
  });
  final String image;

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _studentIdTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TextEditingController _trxIDTEController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 355,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffFFFCF3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 33),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 155,
                              height: 91,
                              child: Image.asset(widget.image),
                            ),
                            SizedBox(width: 2.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Software Dev session",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "BDT 4000 Tk",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffD0D9FC).withOpacity(0.20),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "Name",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Full Name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 2.h),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "Student Id",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Full Name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 2.h),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Mobile Number Used For Payment"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Mobile Number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 2.h),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  decoration:
                                      const InputDecoration(hintText: "TrxID"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Mobile Number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 8.h),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                        200,
                                        50,
                                      ),
                                      backgroundColor: Color(0xffFDEBB9)),
                                  child: Text(
                                    "Submit",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
