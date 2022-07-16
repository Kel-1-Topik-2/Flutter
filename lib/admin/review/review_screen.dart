import 'package:flutter/material.dart';
import 'package:hospital/admin/archive/archive_screen.dart';
import 'package:hospital/admin/review/components/form_review.dart';

class ReviewScreenAdmin extends StatefulWidget {
  const ReviewScreenAdmin({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<ReviewScreenAdmin> createState() => _ReviewScreenAdminState();
}

class _ReviewScreenAdminState extends State<ReviewScreenAdmin> {
  late Size size;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: const Color(0xffF0F4F9),
            ),
            RefreshIndicator(
              onRefresh: refreshData,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 60,
                    top: 60,
                    bottom: 50,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ArchiveScreenAdmin(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Review',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: Color(0xff358C56),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FormReview(id: widget.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future refreshData() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreenAdmin(
          id: widget.id,
        ),
      ),
    );
  }
}
