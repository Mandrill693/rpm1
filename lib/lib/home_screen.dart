import 'package:flutter/material.dart';

const _primary = Color(0xFF4F5BFF);
const _ink = Color(0xFF1B1B2B);
const _muted = Color(0xFF9A9AAE);

class _WeekTask {
  final String title;
  final String day;
  final Color color;
  final int members;

  const _WeekTask(this.title, this.day, this.color, this.members);
}

class _TodayTask {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  const _TodayTask(this.title, this.time, this.icon, this.color);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _week = [
    _WeekTask('Обсуждение дизайна', 'Понедельник', Color(0xFF4F5BFF), 5),
    _WeekTask('Встреча команды', 'Вторник', Color(0xFFF23F63), 3),
    _WeekTask('Звонок клиенту', 'Среда', Color(0xFFFF7A1A), 2),
    _WeekTask('План релиза', 'Четверг', Color(0xFF2BB673), 6),
    _WeekTask('Ретроспектива', 'Пятница', Color(0xFF8B5CF6), 4),
  ];

  static const _today = [
    _TodayTask(
      'Подготовить макеты интерфейса',
      '09:00–10:30',
      Icons.palette_outlined,
      Color(0xFF4F5BFF),
    ),
    _TodayTask('Проверить код', '11:00–12:00', Icons.code, Color(0xFF8B5CF6)),
    _TodayTask(
      'Обед с командой',
      '13:00–14:00',
      Icons.restaurant,
      Color(0xFFFF7A1A),
    ),
    _TodayTask(
      'Написать документацию',
      '15:00–16:30',
      Icons.description_outlined,
      Color(0xFF2BB673),
    ),
    _TodayTask(
      'Составить план на завтра',
      '17:00–17:30',
      Icons.event_note,
      Color(0xFFF23F63),
    ),
  ];

  Widget _header() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundColor: Color(0xFFE4E4F5),
          child: Icon(Icons.person, size: 30, color: _primary),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Привет, Алексей',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Сегодня у вас 5 задач',
                style: TextStyle(fontSize: 13, color: _muted),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.notifications_none, color: _ink),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Поиск задач',
          hintStyle: TextStyle(color: _muted, fontSize: 14),
          icon: Icon(Icons.search, color: _muted),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: _ink,
        ),
      ),
    );
  }

  Widget _weekCard(_WeekTask task) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 14, bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: task.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: task.color.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.day,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          _AvatarStack(total: task.members, borderColor: task.color),
        ],
      ),
    );
  }

  Widget _todayCard(_TodayTask task) {
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: task.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(task.icon, color: task.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  task.time,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: _muted),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Менеджер задач',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _header(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _searchBar(),
            ),
            const SizedBox(height: 22),
            _title('На этой неделе'),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 6),
                itemCount: _week.length,
                itemBuilder: (context, index) => _weekCard(_week[index]),
              ),
            ),
            const SizedBox(height: 14),
            _title('Сегодня'),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: _today.length,
                itemBuilder: (context, index) => _todayCard(_today[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final int total;
  final Color borderColor;

  const _AvatarStack({required this.total, required this.borderColor});

  static const _avatarColors = [
    Color(0xFFFFC857),
    Color(0xFF7BDFF2),
    Color(0xFFB2F7EF),
  ];
  static const _size = 30.0;
  static const _step = 20.0;

  Widget _circle({required Color color, required Widget child}) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final shown = total < 3 ? total : 3;
    final extra = total - shown;
    final count = shown + (extra > 0 ? 1 : 0);

    return SizedBox(
      height: _size,
      width: _size + (count - 1) * _step,
      child: Stack(
        children: [
          for (var i = 0; i < shown; i++)
            Positioned(
              left: i * _step,
              child: _circle(
                color: _avatarColors[i],
                child: const Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: shown * _step,
              child: _circle(
                color: Colors.white,
                child: Text(
                  '+$extra',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
