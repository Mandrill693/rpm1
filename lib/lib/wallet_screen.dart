import 'package:flutter/material.dart';

const _primary = Color(0xFF4F5BFF);
const _ink = Color(0xFF1B1B2B);
const _muted = Color(0xFF9A9AAE);
const _red = Color(0xFFF23F3F);
const _green = Color(0xFF2BB673);

class Transaction {
  final String title;
  final String date;
  final int amount;
  final bool isOrder;
  final IconData icon;

  const Transaction(
    this.title,
    this.date,
    this.amount,
    this.isOrder,
    this.icon,
  );
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  static const _topUpAmount = 100;

  int _balance = 9379;

  static const _transactions = [
    Transaction(
      'Стул «Лоусон»',
      '15 дек. 2024 | 10:00',
      120,
      true,
      Icons.chair_alt,
    ),
    Transaction(
      'Пополнение кошелька',
      '14 дек. 2024 | 16:42',
      400,
      false,
      Icons.account_balance_wallet,
    ),
    Transaction(
      'Параболический отражатель',
      '14 дек. 2024 | 11:39',
      170,
      true,
      Icons.light,
    ),
    Transaction(
      'Минималистичный стол',
      '13 дек. 2024 | 14:46',
      165,
      true,
      Icons.table_restaurant,
    ),
    Transaction(
      'Пополнение кошелька',
      '12 дек. 2024 | 09:27',
      300,
      false,
      Icons.account_balance_wallet,
    ),
  ];

  void _topUp() {
    setState(() => _balance += _topUpAmount);
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Баланс пополнен на $_topUpAmount ₽'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _money(int value) {
    final text = value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ' ',
    );
    return '$text ₽';
  }

  Widget _card() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A3A3C), Color(0xFF101012)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 22,
            left: 22,
            child: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD66B), Color(0xFFC9962B)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 22,
            right: 22,
            child: SizedBox(
              width: 44,
              height: 28,
              child: Stack(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 72,
            left: 22,
            child: Text(
              '•••• •••• •••• 3629',
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 2,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
          Positioned(
            top: 96,
            left: 22,
            child: const Text(
              'Андрей Эйнсли',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 22,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ваш баланс',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _money(_balance),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 22,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _topUp,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 16, color: _ink),
                      SizedBox(width: 6),
                      Text(
                        'Пополнить',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Электронный кошелёк',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _card(),
            const SizedBox(height: 22),
            Row(
              children: const [
                Text(
                  'История операций',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                Spacer(),
                Text(
                  'Все операции',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: _transactions.length,
                itemBuilder: (context, index) =>
                    TransactionCard(transaction: _transactions[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final color = t.isOrder ? _red : _green;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEDEDF2),
            ),
            child: Icon(t.icon, size: 22, color: _ink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  t.date,
                  style: const TextStyle(fontSize: 11, color: _muted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${t.isOrder ? '-' : '+'}${t.amount} ₽',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t.isOrder ? 'Покупка' : 'Пополнение',
                style: const TextStyle(fontSize: 11, color: _muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
