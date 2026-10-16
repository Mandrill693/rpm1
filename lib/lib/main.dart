import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'meditate_screen.dart';
import 'organizer_screen.dart';
import 'wallet_screen.dart';

void main() => runApp(const TemplatesApp());

class TemplatesApp extends StatelessWidget {
  const TemplatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Шаблоны приложений',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F5BFF)),
      ),
      home: const CatalogScreen(),
    );
  }
}

class _Template {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _Template(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.screen,
  );
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const _templates = [
    _Template(
      'Менеджер задач',
      'Профиль, поиск и списки задач',
      Icons.checklist,
      Color(0xFF4F5BFF),
      HomeScreen(),
    ),
    _Template(
      'Глубокое расслабление',
      'Медитация и отдых',
      Icons.self_improvement,
      Color(0xFF8B5CF6),
      MeditateScreen(),
    ),
    _Template(
      'Мой электронный кошелёк',
      'Баланс и история операций',
      Icons.account_balance_wallet,
      Color(0xFF2BB673),
      WalletScreen(),
    ),
    _Template(
      'Организатор мероприятий',
      'Профиль организатора',
      Icons.event,
      Color(0xFFF23F63),
      OrganizerScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Каталог шаблонов',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _templates.length,
        itemBuilder: (context, index) {
          final t = _templates[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => t.screen),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: t.color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(t.icon, color: t.color, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1B1B2B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              t.subtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9A9AAE),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFF9A9AAE)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
