import 'package:flutter/material.dart';

// =======================================================
// --- MOCKUP WIDGETS & MODEL & KONSTANTA ---
// =======================================================

// Mockup Model
class TransactionModel {
  final String title;
  final String amount;
  final String category;
  TransactionModel(this.title, this.amount, this.category);
}

// Konstanta Warna Asli Anda
const Color kAppBarColor = Color.fromARGB(255, 252, 115, 243); // Pink AppBar
const Color kCardColor1 = Color.fromARGB(255, 252, 115, 243);
const Color kCardColor2 = Color.fromARGB(255, 245, 163, 201);
const Color kGridIconColor = Color.fromARGB(255, 197, 170, 241); // Ungu pada ikon
const Color kSearchColor = Color.fromARGB(255, 245, 245, 245); // Warna abu-abu muda untuk background search

// --- AtmCard ---
class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;
  final IconData logoIcon; 

  const AtmCard({
    super.key, required this.bankName, required this.cardNumber, required this.balance, required this.color1, required this.color2, required this.logoIcon, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [BoxShadow(color: color1.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5),)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bankName, style: const TextStyle(color: Colors.white70, fontSize: 16),),
              Icon(logoIcon, color: Colors.white, size: 30,)
            ],
          ),
          const Spacer(), 
          Text(balance, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          Text(cardNumber, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),),
        ],
      ),
    );
  }
}

// --- GridMenuItem ---
class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const GridMenuItem({super.key, required this.icon, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60, 
          width: 60,  
          decoration: BoxDecoration(
            color: kGridIconColor.withOpacity(0.1), 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: kGridIconColor, size: 30),
        ),
        const SizedBox(height: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80), 
          child: Text(
            label, 
            style: const TextStyle(fontSize: 12, color: Colors.black87), 
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// --- TransactionItem ---
class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionItem({super.key, required this.transaction});

  IconData _getIcon(String category) {
    switch (category) {
      case 'Food': return Icons.local_dining_rounded;
      case 'Travel': return Icons.flight_takeoff_rounded;
      case 'Health': return Icons.medical_services_rounded;
      case 'Event': return Icons.event_available_rounded;
      case 'Income': return Icons.attach_money_rounded;
      default: return Icons.shopping_bag_rounded;
    }
  }

  Color _getAmountColor(String amount) {
    if (amount.startsWith('+')) {
      return Colors.green.shade600;
    } else if (amount.startsWith('-')) {
      return Colors.red.shade600;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    const Color transactionBg = Color.fromARGB(255, 255, 245, 245); 
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: transactionBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3),),],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: kGridIconColor.withOpacity(0.15),
            child: Icon(_getIcon(transaction.category), color: kGridIconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),),
                Text(transaction.category, style: const TextStyle(fontSize: 12, color: Colors.grey),),
              ],
            ),
          ),
          Text(transaction.amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _getAmountColor(transaction.amount)),),
        ],
      ),
    );
  }
}

// --- TotalBalanceCard ---
class TotalBalanceCard extends StatelessWidget {
  final String totalBalance;
  const TotalBalanceCard({super.key, required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kAppBarColor, 
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 16),),
          const SizedBox(height: 6),
          Text(totalBalance, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8), 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4),),
            child: const Text('Manage Funds', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),), 
          ),
        ],
      ),
    );
  }
}

// --- SummaryItem (Komponen) ---
class SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color color;

  const SummaryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08), 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    amount,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- MonthlySummaryCard ---
class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Memberikan jarak ke Quick Access
      child: Row(
        children: const [
          // Pemasukan
          SummaryItem(
            icon: Icons.arrow_downward_rounded,
            title: 'Income',
            amount: '+Rp15.200.000',
            color: Colors.green,
          ),
          SizedBox(width: 12),
          // Pengeluaran
          SummaryItem(
            icon: Icons.arrow_upward_rounded,
            title: 'Expense',
            amount: '-Rp5.120.000',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

// =============================
// --- HOME SCREEN UTAMA ---
// =============================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _calculateTotalBalance() {
    return 'Rp10.549.850.000'; 
  }

  // Widget untuk Search Bar
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Jarak di bawah Search Bar
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: kSearchColor, // Warna abu-abu muda
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search transactions, menu, or category...',
          hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.black54),
          border: InputBorder.none, // Menghilangkan border default
        ),
      ),
    );
  }

  // Widget untuk sapaan, profil dan notifikasi (Di bawah AppBar)
  Widget _buildGreetingHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0), // Jarak atas dan bawah
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kiri: Profile Avatar dan Sapaan
          Row(
            children: [
              // 1. Profile Avatar (Placeholder)
              const CircleAvatar(
                radius: 24, // Ukuran avatar
                backgroundColor: kGridIconColor, // Warna latar belakang avatar
                child: Icon(Icons.person, color: Colors.white, size: 30), // Ikon default 
              ),
              const SizedBox(width: 12), // Jarak antara avatar dan teks sapaan

              // 2. Sapaan 2 baris (Hallo, + Nama)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hallo,', 
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.black54, 
                    ),
                  ),
                  Text(
                    'Siti Alfiah Kharun Nisa', 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold, 
                      color: Colors.black54 
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Kanan: Ikon Notifikasi
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded, 
              color: Colors.black54,
              size: 28
            ),
            onPressed: () {
              // TODO: Tambahkan aksi saat ikon notifikasi ditekan
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Coffee Shop', '-Rp155.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp45.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp90.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

    final String totalBalance = _calculateTotalBalance();

    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text('Finance Mate'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // ===== 0. Header (Avatar, Sapaan, Notifikasi) =====
            _buildGreetingHeader(),
            
            // ===== 1. Total Saldo Card =====
            TotalBalanceCard(totalBalance: totalBalance),
            
            // ===== 2. My Cards Section =====
            const Text(
              'My Cards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  AtmCard(
                    bankName: 'Bank BCA',
                    cardNumber: '**** 2345',
                    balance: 'Rp9593.500.000',
                    color1: kCardColor1, color2: kCardColor2,
                    logoIcon: Icons.account_balance_wallet,
                  ),
                  AtmCard(
                    bankName: 'Bank Mandiri',
                    cardNumber: '**** 8765',
                    balance: 'Rp790.850.000',
                    color1: kCardColor1, color2: kCardColor2,
                    logoIcon: Icons.credit_card,
                  ),
                  AtmCard(
                    bankName: 'Bank BNI',
                    cardNumber: '**** 6707',
                    balance: 'Rp115.000.000',
                    color1: kCardColor1, color2: kCardColor2,
                    logoIcon: Icons.payments,
                  ),
                  AtmCard(
                    bankName: 'Bank SeaBank',
                    cardNumber: '**** 9508',
                    balance: 'Rp54.571.090',
                    color1: kCardColor1, color2: kCardColor2,
                    logoIcon: Icons.savings,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), 

            // ===== 2.5 MONTHLY SUMMARY CARD =====
            const MonthlySummaryCard(), 

            // ===== Search Bar  =====
            _buildSearchBar(),

            // ===== 3. Quick Access (8 ITEM) =====
            const Text(
              'Quick Access', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 4, 
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16, 
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0, 
              children: const [
                GridMenuItem(icon: Icons.health_and_safety, label: 'Health'),
                GridMenuItem(icon: Icons.travel_explore, label: 'Travel'),
                GridMenuItem(icon: Icons.fastfood, label: 'Food'),
                GridMenuItem(icon: Icons.event, label: 'Event'),
                GridMenuItem(icon: Icons.send_to_mobile_rounded, label: 'Transfer'),
                GridMenuItem(icon: Icons.qr_code_scanner_rounded, label: 'QR Pay'),
                GridMenuItem(icon: Icons.system_update_alt_rounded, label: 'Top Up'),
                GridMenuItem(icon: Icons.history_toggle_off_rounded, label: 'Riwayat'),
              ],
            ),

            const SizedBox(height: 12), 

            // ===== 4. Recent Transactions =====
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: transactions[index]);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}