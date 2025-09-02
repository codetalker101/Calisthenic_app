import 'package:calisthenics_app/navigation/main_navigator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),

                // App logo
                Center(
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/icons/saitama-profile-pic.png'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // App title
                SizedBox(
                  height: 30,
                  child: const Text(
                    "CalisterPal",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AudioLinkMono',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 5),

                // Subtitle
                SizedBox(
                  height: 20,
                  child: const Text(
                    "Sign in to continue",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'SF-Pro-Display-Thin',
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 45),

                // Email TextField
                SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        fontFamily: 'SF-Pro-Display-Thin',
                        color: Colors.black54,
                        height: 0,
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 20),

                // Password TextField
                SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontFamily: 'SF-Pro-Display-Thin',
                        color: Colors.black54,
                        height: 0,
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 33,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password? click login directly",
                        style: TextStyle(
                          fontFamily: 'SF-Pro-Display-Thin',
                          color: Color(0xFF9B2354),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainNavigator()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B2354),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AudioLinkMono',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Divider with OR
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontFamily: 'SF-Pro-Display-Thin',
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton('assets/icons/google_icon.png', 50),
                    const SizedBox(width: 20),
                    _socialButton('assets/icons/facebook_icon.png', 50),
                  ],
                ),

                const SizedBox(height: 0),

                // Register
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'SF-Pro-Display-Thin',
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'SF-Pro-Display-Thin',
                            color: Color(0xFF9B2354),
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String asset, double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Image.asset(
          asset,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
