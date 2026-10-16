import 'package:flutter/material.dart';

const _primary = Color(0xFF4F5BFF);
const _ink = Color(0xFF1B1B2B);
const _body = Color(0xFF3A3A4A);
const _muted = Color(0xFF9A9AAE);

class OrganizerScreen extends StatefulWidget {
  const OrganizerScreen({super.key});

  @override
  State<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends State<OrganizerScreen> {
  static const _tabs = ['О себе', 'Мероприятия', 'Отзывы'];

  static const _aboutText =
      'Я помогаю организовывать и продвигать мероприятия для творческих сообществ, деловые встречи '
      'и образовательные программы. Я занимаюсь подготовкой площадок, планированием программы '
      'и созданием атмосферы, в которой каждый гость чувствует себя комфортно. '
      'Работаю в этой сфере более восьми лет.';

  static const _events = [
    ('Конференция по дизайну — 2025', '12 января | Главный зал'),
    ('Встреча стартапов', '28 января | Центр города'),
    ('Творческий мастер-класс', '5 февраля | Арт-пространство'),
  ];

  static const _reviews = [
    ('Мария К.', 'Отличная организация, всё прошло вовремя!'),
    ('Иван С.', 'Очень дружная команда и приятная атмосфера.'),
    ('Анна П.', 'Одно из лучших мероприятий, на которых я была.'),
  ];

  bool _following = false;
  int _followers = 2368;
  int _tab = 0;
  bool _expanded = false;

  void _toggleFollow() {
    setState(() {
      _following = !_following;
      _followers += _following ? 1 : -1;
    });
  }

  String _format(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ' ',
    );
  }

  Widget _avatar() {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE4E4EC),
              border: Border.all(color: const Color(0xFFD0D0DC), width: 2),
            ),
            child: const Icon(Icons.person, size: 56, color: Color(0xFFA8A8BA)),
          ),
          Positioned(
            right: 0,
            bottom: 4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primary,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 13, color: _body)),
        ],
      ),
    );
  }

  Widget _tabButton(int index) {
    final active = _tab == index;
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: active ? _primary : Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: _primary),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(19),
            onTap: () => setState(() => _tab = index),
            child: Center(
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : _primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _aboutContent() {
    return [
      const Text(
        'Обо мне',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _ink,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        _aboutText,
        maxLines: _expanded ? null : 3,
        overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        style: const TextStyle(height: 1.5, fontSize: 14, color: _body),
      ),
      const SizedBox(height: 8),
      InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Text(
          _expanded ? 'Свернуть' : 'Читать далее',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _primary,
          ),
        ),
      ),
    ];
  }

  Widget _infoCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _tabContent() {
    switch (_tab) {
      case 1:
        return [for (final e in _events) _infoCard(e.$1, e.$2, Icons.event)];
      case 2:
        return [for (final r in _reviews) _infoCard(r.$1, r.$2, Icons.star)];
      default:
        return _aboutContent();
    }
  }

  Widget _capsule({
    required String label,
    required IconData icon,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: filled ? _primary : Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: _primary, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(23),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: filled ? Colors.white : _primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: filled ? Colors.white : _primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Профиль организатора',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _avatar()),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Альберт Флорес',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
            ),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                children: [
                  _stat(_format(_followers), 'Подписчики'),
                  VerticalDivider(color: Colors.grey.shade300, width: 1),
                  _stat('346', 'Подписки'),
                  VerticalDivider(color: Colors.grey.shade300, width: 1),
                  _stat('13', 'Мероприятия'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Divider(color: Colors.grey.shade300, height: 1),
            const SizedBox(height: 18),
            _capsule(
              label: _following ? 'Вы подписаны' : 'Подписаться',
              icon: _following ? Icons.check : Icons.person_add_alt_1,
              filled: !_following,
              onTap: _toggleFollow,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _tabButton(0),
                const SizedBox(width: 10),
                _tabButton(1),
                const SizedBox(width: 10),
                _tabButton(2),
              ],
            ),
            const SizedBox(height: 18),
            ..._tabContent(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          child: Row(
            children: [
              Expanded(
                child: _capsule(
                  label: 'Написать',
                  icon: Icons.chat_bubble_outline,
                  filled: false,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _capsule(
                  label: 'Позвонить',
                  icon: Icons.call,
                  filled: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
