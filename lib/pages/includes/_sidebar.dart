import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SafeArea(
        child: Material(
          // FIX: Wrap with Material to fix ListTile error
          color: Colors.transparent, // Ensures background stays transparent
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            constraints: const BoxConstraints(maxWidth: 300),
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                ),
                ListTile(
                  leading: const Icon(Icons.calculate, color: Colors.black),
                  title: const Text('BMI Calculator',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'OpenSans')),
                  onTap: () {
                    Navigator.pop(context);
                    print('Calculator Clicked');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.black),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    print('Logout Clicked');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
