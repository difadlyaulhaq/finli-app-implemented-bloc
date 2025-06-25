import 'package:carousel_slider/carousel_slider.dart';
import 'package:finli_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tips = const [
    {
      "title":
          "Introduction to Mobile Programming: Dunia Aplikasi di Genggamanmu",
      "image": "assets/img_carousel1.png",
      "Url":
          'https://medium.com/amcc-amikom/introduction-to-mobile-programming-dunia-aplikasi-di-genggamanmu-52401f146543',
    },
    {
      "title":
          "Introduction Git & Github: Sahabat Developer untuk Kolaborasi dan Versi Kode",
      "image": "assets/img_carousel2.png",
      "Url":
          'https://medium.com/amcc-amikom/introduction-git-github-sahabat-developer-untuk-kolaborasi-dan-versi-kode-ce24a1672464',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh functionality placeholder
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ListView(
            children: [
              const SizedBox(height: 20),
              // APP BAR SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Halo, ",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Riyan",
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ],
                ),
              ),
              // END OF APP BAR SECTION
              const SizedBox(height: 20),

              // BALANCE CARD SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Balance",
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.keyboard_arrow_up_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Rp0",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 45),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.blueBackground,
                            radius: 12,
                            child: Icon(
                              Icons.arrow_downward,
                              color: AppColors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Income",
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            backgroundColor: AppColors.blueBackground,
                            radius: 12,
                            child: Icon(
                              Icons.arrow_upward,
                              color: AppColors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Expense",
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Rp0",
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Rp0",
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // END BALANCE CARD SECTION
              SizedBox(height: size.height * 0.025),

              // LATEST TRANSACTIONS SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Transactions",
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/transaction');
                      },
                      child: Text(
                        "View All",
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Empty Transactions Placeholder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: AppColors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "No transactions yet",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // END OF LATEST TRANSACTIONS SECTION
              SizedBox(height: size.height * 0.03),

              // ACADEMY SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Academy This Week",
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CarouselSlider.builder(
                  itemCount: tips.length,
                  itemBuilder: (context, index, realIndex) {
                    final tip = tips[index];
                    return GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse(tip['Url'] as String);
                        await launchUrl(url);
                        print("Kartu di-tap: ${tip['title']}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(tip['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    tip['title']!,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    padEnds: false,
                    height: 180,
                    viewportFraction: 0.7,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    autoPlay: false,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}