import 'package:carousel_slider/carousel_slider.dart';
import 'package:finli_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:finli_app/bloc/crud/crud_bloc.dart';
import 'package:finli_app/bloc/crud/crud_event.dart';
import 'package:finli_app/bloc/crud/crud_state.dart';
import 'package:finli_app/bloc/crud/crud_model.dart';

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
  void initState() {
    super.initState();
    // Fetch transactions when the page loads
    context.read<CrudBloc>().add(FetchTransactionsEvent());
  }

  String _calculateBalance(List<TransactionModel> transactions) {
    double totalIncome = 0;
    double totalExpense = 0;

    for (var transaction in transactions) {
      double amount = double.tryParse(transaction.amount.replaceAll('.', '').replaceAll(',', '')) ?? 0;
      if (transaction.isIncome) {
        totalIncome += amount;
      } else {
        totalExpense += amount;
      }
    }

    double balance = totalIncome - totalExpense;
    return _formatCurrency(balance);
  }

  String _calculateTotalIncome(List<TransactionModel> transactions) {
    double totalIncome = 0;
    for (var transaction in transactions) {
      if (transaction.isIncome) {
        double amount = double.tryParse(transaction.amount.replaceAll('.', '').replaceAll(',', '')) ?? 0;
        totalIncome += amount;
      }
    }
    return _formatCurrency(totalIncome);
  }

  String _calculateTotalExpense(List<TransactionModel> transactions) {
    double totalExpense = 0;
    for (var transaction in transactions) {
      if (!transaction.isIncome) {
        double amount = double.tryParse(transaction.amount.replaceAll('.', '').replaceAll(',', '')) ?? 0;
        totalExpense += amount;
      }
    }
    return _formatCurrency(totalExpense);
  }

  String _formatCurrency(double amount) {
    return "Rp${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<CrudBloc>().add(FetchTransactionsEvent());
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
              BlocBuilder<CrudBloc, CrudState>(
                builder: (context, state) {
                  if (state is FetchLoaded) {
                    final balance = _calculateBalance(state.transactions);
                    final income = _calculateTotalIncome(state.transactions);
                    final expense = _calculateTotalExpense(state.transactions);

                    return Padding(
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
                              balance,
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
                                  income,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  expense,
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
                    );
                  } else if (state is FetchLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (state is FetchError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Error loading balance",
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CrudBloc>().add(FetchTransactionsEvent());
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  // Default fallback
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Loading...",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
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

              // Transactions List
              BlocBuilder<CrudBloc, CrudState>(
                builder: (context, state) {
                  if (state is FetchLoaded) {
                    if (state.transactions.isEmpty) {
                      return Padding(
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
                      );
                    }

                    // Show only the latest 3 transactions
                    final latestTransactions = state.transactions.take(3).toList();

                    return Column(
                      children: latestTransactions.map((transaction) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          child: Card(
                            color: AppColors.white,
                            elevation: 0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: transaction.isIncome
                                    ? Colors.blue[100]
                                    : Colors.red[100],
                                child: Icon(
                                  transaction.isIncome
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: transaction.isIncome ? Colors.blue : Colors.red,
                                ),
                              ),
                              title: Text(
                                transaction.title,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                transaction.subtitle,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              trailing: Text(
                                "${transaction.isIncome ? '+' : '-'}Rp ${transaction.amount}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: transaction.isIncome ? Colors.green : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (state is FetchLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is FetchError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        color: AppColors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Error loading transactions",
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<CrudBloc>().add(FetchTransactionsEvent());
                                },
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
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