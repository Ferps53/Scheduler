import 'package:flutter/material.dart';
import 'package:todo_list/src/view/auth/widgets/auth_form.dart';
import 'package:todo_list/src/view/default_widgets/glass_card.dart';

import '../../../styles/app_colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(colors: [
                AppColors.gradientLightColor,
                AppColors.baseColor,
              ], radius: 1, focalRadius: 2),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GlassCard(
                      startGradient: 0.4,
                      endGradient: 0.65,
                      heigth: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width * 0.9,
                      backgroundColor: AppColors.textColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 35,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Scheduler",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 45),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
