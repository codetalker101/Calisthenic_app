import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final List<DateTime> _reminders = [
    DateTime.now().add(const Duration(hours: 2)),
    DateTime.now().add(const Duration(hours: 4)),
  ];

  final List<bool> _reminderStatus = [
    true,
    true
  ]; // On/Off state for each reminder

  /// Add a reminder with time picker
  Future<void> _addReminder() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final reminder = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      setState(() {
        _reminders.add(reminder);
        _reminderStatus.add(true); // default to ON
      });
    }
  }

  /// Edit reminder (by tapping the card)
  Future<void> _editReminder(int index) async {
    final reminder = _reminders[index];
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: reminder.hour, minute: reminder.minute),
    );

    if (picked != null) {
      final now = DateTime.now();
      final updated = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      setState(() => _reminders[index] = updated);
    }
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFECE6EF),
      elevation: 0,
      scrolledUnderElevation: 1,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Reminders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// Reminder Item
  Widget _buildReminderItem(int index) {
    final reminder = _reminders[index];
    final formattedTime = DateFormat("h:mm a").format(reminder);

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () => _editReminder(index), // 🔹 Tap card to edit
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🔹 Left side: time text
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 22, // 🔹 Bigger time text
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A),
              ),
            ),

            // Right side: delete button + switch
            Row(
              children: [
                // Delete Icon (SVG)
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      _reminders.removeAt(index);
                      _reminderStatus.removeAt(index);
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/icons/trashBin.svg',
                    height: 24,
                    width: 24,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(width: 12),

                // Switch Button
                Switch(
                  value: _reminderStatus[index],
                  activeColor: const Color(0xFF26AAC7),
                  onChanged: (value) {
                    setState(() => _reminderStatus[index] = value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Reminder List
  Widget _buildReminderList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _reminders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) => _buildReminderItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: _buildReminderList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF26AAC7),
        onPressed: _addReminder,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
