import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_project/core/theme/colours.dart';
import 'package:pixelfield_project/core/utils/bloc/connectivity_bloc.dart';
import 'package:pixelfield_project/features/sign_in/view/view.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColor.bgColor;
    const Color panelColor = Color(0xFF101D21); // Dark panel background
    const Color buttonColor = Color(0xFFFFB800); // Example golden/yellow color
    const TextStyle panelTextStyle = TextStyle(color: Colors.white);

    return Scaffold(
      // Set the primary background color of the entire screen
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Apply the background pattern
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        // Stack so we can align a panel at the bottom.
        child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectivityOffline) {
              // Show a message or disable features that require the internet.
              return Center(
                child: Text(
                  "No Internet Connection.\nPlease check your connection.",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Stack(
              children: [
                // Bottom-aligned content container
                Padding(
                  padding: const EdgeInsets.only(bottom: 34.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    // A container that holds the panel with text and a button
                    child: Container(
                      width: double.infinity,
                      // Decide the height or use padding for a dynamic size
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
                        horizontal: 24.0,
                      ),
                      decoration: BoxDecoration(
                        color: panelColor.withValues(
                          alpha: 0.9, // Semi-transparent dark background
                        ),
                        // Slight rounded corners at the top
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Wrap content at the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Main welcome text
                          Text(
                            'Welcome!',
                            style: panelTextStyle.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Sub-text
                          Text(
                            'Text text text',
                            style: panelTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          // "Scan bottle" button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // primary: buttonColor,
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                // Handle scan bottle action
                              },
                              child: Text(
                                'Scan bottle',
                                style: panelTextStyle.copyWith(
                                  color: backgroundColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Sign-in text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account? ',
                                style: panelTextStyle.copyWith(fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignInPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign in first',
                                  style: panelTextStyle.copyWith(
                                    color: buttonColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
